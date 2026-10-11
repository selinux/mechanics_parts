"""Generic surface texturing for build123d.

texture_face(face, kind, ...) -> list[Face]  (cells to extrude through / engrave)

Pipeline (same for every texture):
  1. flatten the planar face onto XY and convert it to a shapely polygon
  2. a texture generator returns raw cells (shapely polygons) covering the face
  3. each cell is shrunk by wall/2   -> the wall between two holes = `wall`
  4. cells not fully inside (face offset by `margin`) are dropped -> never truncated
  5. cells go back to build123d faces, moved back to the original plane

Add a texture = write one function and decorate it with @texture("name").
"""

import numpy as np
import ocp_vscode as ocp
from scipy.spatial import Voronoi
import shapely.geometry as sg
from shapely.geometry.polygon import orient
from shapely.ops import polygonize, unary_union
from build123d import Face, Wire, Vector, Plane, GeomType

TEXTURES = {}


def texture(name):
    """Decorator: register a cell generator  fn(region: Polygon, **params) -> [Polygon]."""

    def register(fn):
        TEXTURES[name] = fn
        return fn

    return register


# ---------------------------------------------------------------- textures
@texture("voronoi")
def voronoi_cells(region, cell_size=10.0, jitter=0.7, seed=0):
    """Random voronoi. cell_size ~ mean cell diameter, jitter 0..1 (0 = regular grid)."""
    rng = np.random.default_rng(seed)
    x0, y0, x1, y1 = region.bounds
    pad = 2 * cell_size  # seeds outside the bbox -> all useful cells are finite
    xs = np.arange(x0 - pad, x1 + pad, cell_size)
    ys = np.arange(y0 - pad, y1 + pad, cell_size)
    pts = np.array([(x, y) for x in xs for y in ys])
    pts += rng.uniform(-jitter, jitter, pts.shape) * cell_size / 2
    vor = Voronoi(pts)
    cells = []
    for idx in vor.point_region:
        reg = vor.regions[idx]
        if reg and -1 not in reg:  # skip unbounded cells
            cells.append(sg.Polygon(vor.vertices[reg]))
    return cells


@texture("honeycomb")
def honeycomb_cells(region, cell_size=10.0, angle=0.0):
    """Hexagons, cell_size = flat-to-flat distance."""
    d = cell_size
    r = d / np.sqrt(3)  # circumradius
    x0, y0, x1, y1 = region.bounds
    cx, cy = (x0 + x1) / 2, (y0 + y1) / 2
    n = int(np.hypot(x1 - x0, y1 - y0) / d) + 2
    hexa = [(r * np.cos(a), r * np.sin(a)) for a in np.radians(np.arange(0, 360, 60))]
    cells = []
    for i in range(-n, n + 1):
        for j in range(-n, n + 1):
            ox = i * 1.5 * r
            oy = j * d + (d / 2 if i % 2 else 0)
            cells.append(sg.Polygon([(ox + x, oy + y) for x, y in hexa]))
    # rotate around origin, then centre on the region
    from shapely import affinity

    return [
        affinity.translate(affinity.rotate(c, angle, origin=(0, 0)), cx, cy)
        for c in cells
    ]


# ---------------------------------------------------------------- helpers
def _wire_to_poly(wire, n=24):
    lines = []
    for e in wire.edges():
        k = 1 if e.geom_type == GeomType.LINE else n
        p = [e @ (i / k) for i in range(k + 1)]
        lines.append(
            sg.LineString([(round(v.X, 6), round(v.Y, 6)) for v in p])
        )  # round: close rings exactly
    return next(
        iter(polygonize(unary_union(lines)))
    )  # polygonize fixes edge order/direction


def _face_to_poly(face):
    poly = _wire_to_poly(face.outer_wire())
    for w in face.inner_wires():
        poly = poly.difference(_wire_to_poly(w))
    return poly


def _poly_to_face(poly):
    poly = orient(poly, 1.0)  # CCW -> face normal = +Z, same as the source face
    pts = [Vector(x, y, 0) for x, y in poly.exterior.coords[:-1]]
    return Face(Wire.make_polygon(pts, close=True))  # cells never have holes


# ---------------------------------------------------------------- main API
def texture_face(face, kind="voronoi", wall=1.5, margin=2.0, fillet=0.0, **params):
    """Cells (list[Face]) to extrude through / engrave a planar face.

    wall   : material left between two cells
    margin : untouched border along the face outline and inner holes
    fillet : rounding radius of the cell corners (0 = sharp)
    params : forwarded to the texture generator (cell_size, seed, ...)
    """
    loc = Plane(face).location
    flat = face.moved(loc.inverse())  # work in XY
    region = _face_to_poly(flat)
    inner = region.buffer(-margin)

    out = []
    for c in TEXTURES[kind](region, **params):
        c = c.buffer(-wall / 2 - fillet).buffer(fillet)  # shrink (+ round corners)
        if c.is_empty or c.geom_type != "Polygon":
            continue
        if inner.contains(c):  # fully inside -> never truncated
            out.append(_poly_to_face(c).moved(loc))
    return out


if __name__ == "__main__":
    from build123d import (
        BuildPart,
        BuildSketch,
        Locations,
        Pos,
        Rectangle,
        Mode,
        Side,
        offset,
        Box,
        Axis,
        Compound,
        extrude,
        fillet,
        chamfer,
        Align,
        GridLocations,
        export_step,
        export_stl,
    )

    length, width, height, s = 226.0, 300.0, 112.0, 3.0

    with BuildPart() as plate:
        Box(length, width, height)
        top_f = plate.faces().sort_by(Axis.Z)[-1]
        offset(amount=-3.0, openings=top_f)
    # extrude(Face(top_f.outer_wire().offset_2d(-3), amount=40, mode=Mode.ADD))

    with BuildPart() as base:
        Box(length, width, s)
        fillet(base.edges().filter_by(lambda e: e.length == s), radius=2 * s)
        # bottom stackable champfer
        chamfer(base.edges().sort_by(Axis.Z)[0], length=s - 0.001)
        _top_base = base.faces().sort_by(Axis.Z)[-1]

        # wall
        with BuildSketch(_top_base) as wall:
            _r = Rectangle(length, width)
            _r = fillet(_r.vertices(), radius=2 * s)
            offset(_r, amount=-s, mode=Mode.SUBTRACT)
        extrude(amount=height - s)

        # gridfinity
        with BuildPart(_top_base) as gridfinity:
            Box(
                42 * 5, 42 * 7, 4.4 - 0.7, align=(Align.CENTER, Align.CENTER, Align.MIN)
            )
            with GridLocations(x_spacing=42, y_spacing=42, x_count=5, y_count=7):
                with BuildSketch() as b1:
                    _x, _y = 42 - 2 * 1.9, 42 - 2 * 1.9
                    Rectangle(_x, _y)
                    fillet(b1.vertices(), radius=1.5)
                extrude(amount=1.8, taper=0, mode=Mode.SUBTRACT)
                with Locations((0, 0, 1.8)):
                    with BuildSketch() as b1:
                        _x, _y = 42 - 2 * 1.9, 42 - 2 * 1.9
                        Rectangle(_x, _y)
                        fillet(b1.vertices(), radius=1.5)
                    extrude(amount=1.9, taper=-45, mode=Mode.SUBTRACT)
        with GridLocations(x_spacing=42, y_spacing=42, x_count=5, y_count=7):
            with BuildSketch(_top_base) as ch0:
                _x, _y = 42 - 1.9 * 2, 42 - 2 * 1.9
                Rectangle(_x, _y)
                fillet(ch0.vertices(), radius=1.5)
            extrude(amount=-0.8, taper=45, mode=Mode.SUBTRACT)

        # top stackable champfer
        with Locations((0, -s, 0)):
            with BuildSketch(base.faces().sort_by(Axis.Z)[-1]) as cham:
                Rectangle(length, width + 2 * s)
            extrude(amount=-s, taper=45, mode=Mode.SUBTRACT)

    # get bin
    plate = base.part

    # make opening
    f0, f1 = [plate.faces().filter_by(Plane.YZ).sort_by(Axis.X)[i] for i in [0, -1]]
    f2 = plate.faces().filter_by(Plane.XZ).sort_by(Axis.Y)[-1]
    cells0 = texture_face(
        f0, "voronoi", wall=2, margin=2, seed=3, cell_size=17, fillet=0.5
    )
    cells1 = texture_face(
        f1, "voronoi", wall=2, margin=2, seed=36, cell_size=17, fillet=0.5
    )
    cells2 = texture_face(
        f2, "voronoi", wall=2, margin=2, seed=39, cell_size=17, fillet=0.5
    )
    cutter0 = Compound(extrude(cells0, -s))
    cutter1 = Compound(extrude(cells1, -s))
    cutter2 = Compound(extrude(cells2, -s))
    part = plate - cutter0 - cutter1 - cutter2

    ocp.show(part)
    export_step(part, "ptl-storage/ptl-drawer-voronoi.step")
    export_stl(part, "ptl-storage/ptl-drawer-voronoi.stl")

    # for kind, kw in (("voronoi", dict(cell_size=9, seed=3, fillet=0.5)),
    #                 ("honeycomb", dict(cell_size=9, angle=0))):
    #    cells = texture_face(top, kind, wall=1.5, margin=3, **kw)
    #    cutter = Compound([extrude(c, -3) for c in cells])
    #    part = plate - cutter
    #    print(f"{kind}: {len(cells)} cells, volume {plate.volume:.0f} -> {part.volume:.0f} mm3")
    #    export_step(part, f"plate_{kind}.step")
    #    ocp.show(part)

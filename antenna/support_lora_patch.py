"""Generic display support"""

import ocp_vscode as ocp
from build123d import *

BASEDIR = "antenna"
PARTNAME = "support_lora_patch"
FILENAME = BASEDIR + "/" + PARTNAME

EXPORT = True


def mk_flang(pos, larg):
    _width = 100.0 / 2
    _radius = 26.0
    with BuildPart() as f:
        with BuildSketch(Plane.XZ.offset(pos)):
            with BuildLine():
                c0 = CenterArc(
                    center=(0, 36.0),
                    radius=_radius,
                    start_angle=0,
                    arc_size=360,
                    mode=Mode.PRIVATE,
                )
                l0 = Line((-_width, 0), (_width, 0))
                l1 = ConstrainedLines(
                    c0, l0 @ 1, selector=lambda l: l.sort_by_distance((0, 0))[-1]
                )
                l2 = ConstrainedLines(
                    c0, l0 @ 0, selector=lambda l: l.sort_by_distance((0, 0))[-1]
                )
                SagittaArc(start_point=l1 @ 0, end_point=l2 @ 0, sagitta=30)
            make_face()
        extrude(amount=larg / 2, both=True)
    return f.part


if __name__ == "__main__":
    length, width, height, s = 117.0, 117.0, 5.0, 3.0
    base_dia = 112.0
    base_ea = 96.0
    base_h = 10.0
    base_holes_r = 6.6 / 2
    axe = 100

    with BuildPart() as support:
        support.color = Color("#3d2c63")
        support.label = "support yagi patch antenna"

        # Base
        Cylinder(
            radius=base_dia / 2,
            height=base_h,
            align=(Align.CENTER, Align.CENTER, Align.MIN),
        )
        fillet(support.edges().sort_by(Axis.Z)[-1], radius=3.0)
        with PolarLocations(radius=base_ea / 2, count=4, start_angle=45):
            Hole(radius=base_holes_r)
        chamfer(
            support.edges()
            .filter_by(GeomType.CIRCLE)
            .filter_by(lambda c: c.radius == 6.6 / 2)
            .sort_by(Axis.Z)[-4:],
            length=1,
        )

        # Axe support
        c_l = 80.0
        with BuildSketch(support.faces().sort_by(Axis.Z)[-1]):
            Rectangle(40, c_l)
        extrude(amount=10)
        c_y = 36.0
        with BuildSketch(support.faces().filter_by(Plane.XZ)[0]) as axe_support:
            with Locations((0, 21.0)):
                Circle(radius=26.0)
                Circle(radius=16.0, mode=Mode.SUBTRACT)
        extrude(amount=-c_l)
        chamfer(support.edges().filter_by(Plane.XZ).filter_by(GeomType.CIRCLE).sort_by(Axis.Y)[-1], length=2.0)

        ## Flang
        _l = 10.0
        add(mk_flang(15, _l))
        add(mk_flang(-15, _l))
        fillet(support.edges().filter_by(lambda e: e.length == _l), radius=6.0)

        ## Fence
        with BuildSketch(Plane.XY.offset(36)):
            Rectangle(6.0, c_l)
        extrude(amount=100, mode=Mode.SUBTRACT)
        fillet(
            support.edges().filter_by(Axis.Y).filter_by(lambda e: abs(e.length - c_l) <= 3.0),
            radius=3,
        )
        fillet(support.faces().filter_by(Plane.XZ).sort_by_distance(0,0)[:8].edges(), radius=2.0)


    ocp.show(support)

if EXPORT:
        export_stl(support.part, FILENAME + '.stl')
        export_step(support.part, FILENAME + '.step')

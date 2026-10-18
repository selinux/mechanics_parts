import sys
from build123d import *
import ocp_vscode as ocp

PARTNAME = "ptl-drawer"
WORKDIR = "ptl-storage/"
FONTPATH = WORKDIR + "fonts/"

FILENAME = WORKDIR + PARTNAME

EXPORT = True
GRIDFINITY = True

# --- PARAMÈTRES GÉNÉRAUX ---
length = 226.0  # Largeur du casier
depth = 300.0  # Profondeur du casier
height = 112.0  # Hauteur du casier
thickness = 3.0  # Épaisseur de la plaque 3D
min_distance = 12.0  # Distance MINIMALE stricte entre deux points (Disque de Poisson)
clearance = 1.8  # Épaisseur des parois entre les cellules


PTL_MODEL = {
    "meca": {"text": "meca", "color": "#30bee6"},
    "electro": {"text": "electro", "color": "#3de031"},
    "electri": {"text": "electri", "color": "#f2e824"},
    "mecael": {"text": "meca'el", "color": "#f29a41"},
    "radio": {"text": "radio", "color": "#ab34eb"},
}
model = "meca"
COLOR = Color(PTL_MODEL[model]["color"])
TEXT = PTL_MODEL[model]["text"]

TEXTURES = {}


registered_faces = FontManager().register_font(FONTPATH + "imagine_font.ttf")


def build_bin(l: float, d: float, h: float, s: float) -> Part:
    with BuildPart() as bin:
        _s_wall = s
        _s_bottom = _s_wall + 1.8 + 1.9 if GRIDFINITY else _s_wall
        # bottom
        Box(l, d, _s_bottom, align=(Align.CENTER, Align.CENTER, Align.MIN))

        # bin walls
        _top_bottom_f = bin.faces().sort_by(Axis.Z)[-1]
        extrude(_top_bottom_f, amount=h - _s_bottom)
        extrude(
            offset(_top_bottom_f, amount=-_s_wall),
            amount=h - _s_bottom,
            mode=Mode.SUBTRACT,
        )
        fillet(
            bin.edges().filter_by(Axis.Z).filter_by(lambda e: e.length == h),
            radius=2 * _s_wall,
        )
        fillet(
            bin.edges()
            .filter_by(Axis.Z)
            .filter_by(lambda e: e.length == h - _s_bottom),
            radius=_s_wall,
        )

        # bottom/top stackable champfer
        with BuildPart(mode=Mode.SUBTRACT) as cham:
            with BuildSketch(Plane.XY.offset(h)):
                with Locations((0, -_s_wall)):
                    _r = Rectangle(l, d + 2 * _s_wall)
                    fillet(_r.vertices(), radius=2 * _s_wall)
            extrude(amount=-_s_wall, taper=45)
        chamfer(bin.edges().sort_by(Axis.Z)[:4], length=_s_wall)
        # top slide
        with BuildPart() as slide:
            _s_slider_h, _s_slider_w, _s_slider_pos = _s_wall+1, 1.5, 1.0
            _s_slider_base_w, _s_slider_base_h = _s_wall, 7.0
            # base slide
            with BuildSketch(Plane.XZ.offset(d / 2 - _s_wall)):
                with Locations((l / 2 - 1.5*_s_wall, h - _s_slider_base_h / 2 - _s_wall,),
                    (-l / 2 + 1.5*_s_wall, h - _s_slider_base_h / 2 - _s_wall)):
                    Rectangle(_s_slider_base_w, _s_slider_base_h)
                # slide
                with Locations((l / 2 - 2*_s_wall + _s_slider_w/2, h - _s_wall ),
                    (-l / 2 + 2*_s_wall - _s_slider_w/2, h - _s_wall)):
                    Rectangle(_s_slider_w, _s_slider_h, align=(Align.CENTER, Align.MIN))
            extrude(amount=-(d - 3 * _s_wall))
        # bottom slide fence
        with BuildPart(mode=Mode.SUBTRACT) as slide_fence:
            with BuildSketch(Plane.XZ):
                _s_slider_depth = 8.0
                with Locations(
                    (l / 2 - _s_wall - _s_slider_w / 2 - 1, 0),
                    (-l / 2 + _s_wall + _s_slider_w / 2 + 1 , 0),):
                    Rectangle(_s_slider_w + 1, _s_slider_depth)
            extrude(amount=d/2, both=True)
            # fillet(slide.edges().filter_by(Axis.Y), radius=0.5)

        # sticker fence
        with BuildPart(mode=Mode.SUBTRACT) as sticker:
            _x_fence_pos, _y_fence_pos = 30.0, 55.0
            _x_fence_with, _y_fence_height = 100.0, 40.0
            _s_window, _s_fence = 1.0, 1.2
            with BuildSketch(Plane.XZ.offset(d / 2)):
                with Locations((_x_fence_pos, _y_fence_pos)):
                    Rectangle(_x_fence_with - 2, _y_fence_height - 2)
            extrude(amount=-_s_window)
            with BuildSketch(Plane.XZ.offset(d / 2 - _s_window)):
                with Locations((_x_fence_pos, _y_fence_pos)):
                    Rectangle(_x_fence_with + 1, _y_fence_height + 1)
            extrude(amount=-_s_fence)

            # extrude top face with angle to insert sticker
            normal_dir = Vector(0, 0, 1)  # normal
            tilted_dir = normal_dir.rotate(Axis.X, -15)
            extrude(sticker.faces().sort_by(Axis.Z)[-1], amount=40, dir=tilted_dir)
            fillet(sticker.edges().filter_by(Axis.X).sort_by(Axis.Z)[-4], radius=10)

        # PTL logo
        with BuildPart(mode=Mode.SUBTRACT) as logo:
            _x_logo_pos, _y_log_pos = _x_fence_pos - 62.0, _y_fence_pos - 42.0
            _logo_scale, _logo_depth = 0.5, _s_wall / 2
            with BuildSketch(Plane.XZ.offset(d / 2)):
                with Locations((_x_logo_pos, _y_log_pos)):
                    add(
                        import_svg(
                            "ptl-storage/ptl-logo/ptl-logo.svg",
                            align=(Align.MAX, Align.MIN),
                        )
                    )
            extrude(amount=_logo_depth, both=True)

        # PTL category
        with BuildPart(mode=Mode.SUBTRACT) as cat_text:
            _x_text_pos, _y_text_pos = _x_fence_pos + 20.0, _y_fence_pos - 42.0
            _text_size, _text_depth = 24, _s_wall / 2
            with BuildSketch(Plane.XZ.offset(d / 2)):
                with Locations(Pos(_x_text_pos, _y_text_pos)):
                    Text(
                        TEXT,
                        font_size=_text_size,
                        font="Imagine Font",
                        rotation=0,
                        align=(Align.MAX, Align.MIN),
                    )
            extrude(amount=_text_depth, both=True)

        # Gridfinity
        if GRIDFINITY:
            xc, yc = 5, 7
            with BuildPart(mode=Mode.SUBTRACT) as gridfinity:
                with BuildSketch(Plane.XY.offset(_s_wall - 0.8)) as b0:
                    with GridLocations(
                        x_count=xc, y_count=yc, x_spacing=42, y_spacing=42
                    ):
                        Rectangle(41.5 - 2 * 2.7, 41.5 - 2 * 2.7)
                        fillet(b0.vertices(), radius=0.8)
                extrude(amount=0.8, taper=-45)
                with BuildSketch(Plane.XY.offset(_s_wall)) as b1:
                    with GridLocations(
                        x_count=xc, y_count=yc, x_spacing=42, y_spacing=42
                    ):
                        Rectangle(41.5 - 2 * 1.9, 41.5 - 2 * 1.9)
                        fillet(b1.vertices(), radius=1.6)
                extrude(amount=1.8, taper=0)
                with BuildSketch(Plane.XY.offset(_s_wall + 1.8)) as b2:
                    with GridLocations(
                        x_count=xc, y_count=yc, x_spacing=42, y_spacing=42
                    ):
                        Rectangle(41.5 - 2 * 1.9, 41.5 - 2 * 1.9)
                        fillet(b2.vertices(), radius=1.6)
                extrude(amount=1.9, taper=-45)

    return bin.part


def main() -> int:

    drawer = build_bin(length, depth, height, thickness)

    # --- VISUALISATION ---
    ocp.show(drawer)

    if EXPORT:
        export_stl(drawer, FILENAME + ".stl")
        export_step(drawer, FILENAME + ".step")
    
    return 0


if __name__ == "__main__":
    sys.exit(main())  # next section explains the use of sys.exit

from datetime import date
from build123d import *
import ocp_vscode as ocp

# --- PARAMÈTRES GÉNÉRAUX ---
screw_d = 17.5  # screw stopper
coverslip = 30.0  # lamelle under tatami
width = 100.0  # Tot width
height = 25.0  # Tot height
thickness = 1.0  # coverslip thickness
screw_gap = 6.25  # coverslip thickness


def project_to_2d(
    part: Part,
    viewport_origin: VectorLike,
    viewport_up: VectorLike,
    page_origin: VectorLike,
    scale_factor: float = 1.0,
) -> tuple[ShapeList[Edge], ShapeList[Edge]]:
    """project_to_2d

    Helper function to generate 2d views translated on the 2d page.

    Args:
        part (Part): 3d object
        viewport_origin (VectorLike): location of viewport
        viewport_up (VectorLike): direction of the viewport Y axis
        page_origin (VectorLike): center of 2d object on page
        scale_factor (float, optional): part scalar. Defaults to 1.0.

    Returns:
        tuple[ShapeList[Edge], ShapeList[Edge]]: visible & hidden edges
    """
    scaled_part = part if scale_factor == 1.0 else scale(part, scale_factor)
    visible, hidden = scaled_part.project_to_viewport(
        viewport_origin, viewport_up, look_at=(0, 0, 0)
    )
    visible = [Pos(*page_origin) * e for e in visible]
    hidden = [Pos(*page_origin) * e for e in hidden]

    return ShapeList(visible), ShapeList(hidden)


def make_stopper(stopper_d):
    with BuildPart() as stopper:
        with Locations((0, -screw_d / 2 - screw_gap, 0)):
            Box(width, length, height, align=(Align.CENTER, Align.MIN, Align.MIN))
            fillet(stopper.edges().filter_by(Axis.Z), radius=10)
        bottom = Plane(stopper.faces().sort_by(Axis.Z)[0].normal_at())
        top = Plane(stopper.faces().sort_by(Axis.Z)[-1].normal_at())
        print(top.origin, top.z_dir)
        with BuildSketch(bottom):
            with GridLocations(x_count=2, y_count=1, x_spacing=70, y_spacing=0):
                Circle(radius=screw_d / 2)
        with BuildSketch(top):
            with Locations((0, stopper_d, 0)):
                Rectangle(width, coverslip, align=(Align.CENTER, Align.MIN))
        extrude(amount=height - thickness, mode=Mode.SUBTRACT)
        top_e = stopper.faces().sort_by(Axis.Z)[-1].edges()
        top_e.pop(1)
        fillet(top_e, radius=3)
    stopper.color = Color("#4287f5")
    return stopper


# Rigth one
stopper_d = 36.0
length = stopper_d + coverslip + screw_d / 2 + 3  # Tot length

stopper_right = make_stopper(stopper_d)

# Left one
# stopper_d = 22.0
# length = stopper_d + coverslip + screw_d/2 + 3     # Tot length
#
# stopper_left = make_stopper(stopper_d)
#
# out_stl = "divers/futon_stopper/futon_stopper_left.stl"
# out_step = out_stl[:-3] + "step"
# export_step(stopper_left.part, out_step)
# export_stl(stopper_left.part, out_stl)
#
# out_stl = "divers/futon_stopper/futon_stopper_right.stl"
# out_step = out_stl[:-3] + "step"
# export_step(stopper_right.part, out_step)
# export_stl(stopper_right.part, out_stl)


# --- VISUALISATION ---
ocp.show(stopper_right)

# Create a standard technical drawing border on A4 paper
border = TechnicalDrawing(
    designed_by="sinux",
    design_date=date.fromisoformat("2026-10-10"),
    page_size=PageSize.A3,
    title="Futon stopper",
    sub_title="Units: mm",
    drawing_number="BD-1",
    sheet_number=1,
    drawing_scale=1,
)
page_size = border.bounding_box().size

# Specify the drafting options for extension lines
drafting_options = Draft(font_size=3.5, decimal_precision=1, display_units=False)

# Lists used to store the 2d visible and hidden lines
visible_lines, hidden_lines = [], []

# ISO
iso_v, iso_h = project_to_2d(
    stopper_right.part,
    (100, 100, 100),
    (0, 0, 1),
    (page_size.X * 0.3, page_size.Y * 0.2),
    0.75,
)
visible_lines.extend(iso_v)
hidden_lines.extend(iso_h)

# Front Elevation
vis, hidd = project_to_2d(
    stopper_right.part,
    (0, 0, 100),
    (0, 1, 0),
    (page_size.X * -0.25, page_size.Y * 0.1),
)
visible_lines.extend(vis)
hidden_lines.extend(hidd)

# Top Elevation
vis, hidd = project_to_2d(
    stopper_right.part,
    (0, 100, 0),
    (0, 0, -1),
    (page_size.X * -0.25, page_size.Y * -0.125),
)
visible_lines.extend(vis)
hidden_lines.extend(hidd)

# Side Elevation
vis, hidd = project_to_2d(
    stopper_right.part,
    (-100, 0, 0),
    (0, 1, 0),
    (page_size.X * 0.0, page_size.Y * 0.1),
)
visible_lines.extend(vis)
hidden_lines.extend(hidd)

side_bbox = Curve(vis).bounding_box()
shaft_top_corner = vis.edges().sort_by(Axis.Y)[-1].vertices().sort_by(Axis.X)[-1]
body_bottom_corner = (side_bbox.max.X, side_bbox.min.Y)

exporter = ExportSVG(unit=Unit.MM)
exporter.add_layer("Visible", line_weight=0.5)
exporter.add_layer("Hidden", line_weight=0.25, line_type=LineType.ISO_DASH)
exporter.add_layer("Dim", line_weight=0.25)
exporter.add_layer("Caption", line_weight=0.25)
exporter.add_shape(visible_lines, layer="Visible")
exporter.add_shape(hidden_lines, layer="Hidden")
exporter.add_shape(border, layer="Caption")
exporter.write(f"divers/futon_stopper/futon_stopper_drawing.svg")

ocp.show(border, visible_lines)


with BuildPart() as stopper_flat:
    _len = 100.0
    _width = 102.0
    _height = 30.0
    Box(_len, _width, _height, align=(Align.CENTER, Align.CENTER, Align.MIN))
    fillet(stopper_flat.edges().filter_by(Axis.Z), radius=10)
    fillet(stopper_flat.edges().filter_by(Plane.XY).sort_by(Axis.Z)[-4:], radius=3)

with BuildPart() as cutter:
    with BuildSketch():
        with GridLocations(x_count=2, y_count=2, x_spacing=45, y_spacing=50):
            RegularPolygon(radius=17, side_count=6, rotation=30)
        RegularPolygon(radius=14, side_count=6)
    extrude(amount=_height - 3)

stopper_flat = stopper_flat.part# - cutter.part

ocp.show(stopper_flat)
#ocp.show(cutter.part)

out_stl = "divers/futon_stopper/futon_stopper_flat.stl"
out_step = out_stl[:-3] + "step"
export_step(stopper_flat, out_step)
export_stl(stopper_flat, out_stl)

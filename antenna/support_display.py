"""Generic display support

"""

import ocp_vscode as ocp
from build123d import *


if __name__ == "__main__":
    length, width, height, s = 117.0, 117.0, 5.0, 3.0
    axe = 100

    with BuildPart() as support:
        Box(length, width, height)
        fillet(support.edges().filter_by(Axis.Z), radius=10)
        with GridLocations(x_count=2, y_count=2, x_spacing=axe, y_spacing=100):
            Hole(radius=2.0)
        
        c_l = 80.0
        with Locations((10,0,25)):
            with BuildPart(Plane.YZ):
                Cylinder(radius=26, height=c_l)
                Cylinder(radius=16, height=c_l, mode=Mode.SUBTRACT)
            fillet(support.edges().filter_by(lambda e: e.length == c_l), radius=12)
            chamfer(support.edges().filter_by(GeomType.CIRCLE).filter_by(lambda e: e.radius==16.0), length=2.5)
            Box(c_l, 6, 40, align=(Align.CENTER, Align.CENTER, Align.MIN), mode=Mode.SUBTRACT)
            
        with Locations((0, 45, 0)):
            Box(4, 14, 2*height, mode=Mode.SUBTRACT)
        
        chamfer(support.edges().filter_by(Axis.X).sort_by(Axis.Z)[-4:], length=2)
        chamfer(support.edges().filter_by(GeomType.CIRCLE).filter_by(lambda e: e.radius == 2.0), length=0.5)


    ocp.show(support)
    export_step(support.part, "antenna/support_display.step")
    export_stl(support.part, "antenna/support_display.stl")

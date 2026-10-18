"""Generic display support

"""

import ocp_vscode as ocp
from build123d import *

BASEDIR = "antenna"
PARTNAME = "support_display"
FILENAME = BASEDIR + "/" + PARTNAME

EXPORT = True

if __name__ == "__main__":
    length, width, height, s = 117.0, 117.0, 5.0, 3.0
    axe = 100
    
    # Part
    with BuildPart() as support:
        Box(length, width, height)
        fillet(support.edges().filter_by(Axis.Z), radius=10)
        fillet(support.edges().filter_by(Plane.XY).sort_by(Axis.Z)[-1], radius=2)
        with GridLocations(x_count=2, y_count=2, x_spacing=axe, y_spacing=100):
            Hole(radius=2.0)
        
        c_l = 80.0
    
        # Base
        with BuildSketch(Plane(support.faces().sort_by(Axis.Z)[-1])):
            with Locations((-10,0)):
                Rectangle(c_l, 38)
        extrude(amount=13)

        # Axe support
        with BuildPart(Plane.YZ.offset(-10)) as axe:
            with Locations((0,33)):
                Cylinder(radius=26, height=c_l)
                Cylinder(radius=16, height=c_l, mode=Mode.SUBTRACT)
                Box(6,36, c_l, align=(Align.CENTER, Align.MIN, Align.CENTER), mode=Mode.SUBTRACT)
        ch_l = 2.0
        chamfer(axe.edges().filter_by(GeomType.CIRCLE).filter_by(lambda e: e.radius==16.0), length=ch_l)
        fillet(support.edges().filter_by(lambda e: e.length == c_l), radius=4)
        fillet(support.edges().filter_by(lambda e: e.length == c_l-2*ch_l), radius=2.5)

        with Locations((0, 45, 0)):
            Box(4, 14, 2*height, mode=Mode.SUBTRACT)
        


    #ocp.show(support)

    #if EXPORT:
    #    export_stl(support.part, FILENAME + '.stl')
    #    export_step(support.part, FILENAME + '.step')

    with BuildPart() as tube_outer:
        h_t = 100.0
        h1 = 40.0
        Cylinder(radius=16, height=h_t, align=(Align.CENTER, Align.CENTER, Align.MIN))
        Cylinder(radius=22, height=h1, align=(Align.CENTER, Align.CENTER, Align.MIN))
        chamfer(tube_outer.edges().sort_by(Axis.Z)[-1], length=3, length2=1)
            
    with BuildPart() as tube_inner:
        h_t = 100.0
        h1_i = 30.0
        d_i = 28.3

        Cylinder(radius=d_i/2, height=h1_i, align=(Align.CENTER, Align.CENTER, Align.MIN))
        with BuildSketch(Plane.XY.offset(h1_i)):
            Circle(radius=d_i/2)
        extrude(amount=3.5, taper=45)
        extrude(tube_inner.faces().sort_by(Axis.Z)[-1], h_t -3.5 - h1_i)
    
        
    tube = tube_outer.part - tube_inner.part
    tube = chamfer(tube.edges().sort_by(Axis.Z)[1], length=1, length2=3)
    
    with BuildPart() as tube_raiser:
        _r = 32.0 /2
        _s = 5.0
        _h = 50.0
        open_angle = 260
        Cylinder(radius=_r+_s, height=_h)
        Cylinder(radius=_r, height=_h, mode=Mode.SUBTRACT)
        with BuildSketch():
            with BuildLine():
                l0 = PolarLine(start=(0,0), length=_r+_s, angle=(90 - (360-open_angle)/2))
                l1 = PolarLine(start=(0,0), length=_r+_s, angle=(90 + (360-open_angle)/2))
                l2 = PolarLine(start=l0 @ 1, length=_r, angle=90)
                l3 = PolarLine(start=l1 @ 1, length=_r, angle=90)
                Line(l2 @ 1, l3 @1)
            make_face()
        extrude(amount=_h, both=True, mode=Mode.SUBTRACT)
        fillet(tube_raiser.edges().filter_by(Axis.Z), radius=2)
        fillet(tube_raiser.edges().sort_by(Axis.Z)[-1], radius=1)

    
    ocp.show(tube_raiser)
    
    if EXPORT:
        export_step(tube, BASEDIR+"/tube_support.step")
        export_step(tube_raiser.part, BASEDIR+"/tube_raiser.step")

/* ======================================================================
 *
 *       Filename:  axeX_bottom.scad
 *
 *    Description:  bottom support for X axe screw and bearing
 *
 *        Version:  1.0
 *        Created:  11 06 2016
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Sebastien Chassot (sinux), seba.ptl@sinux.net
 *
 * =====================================================================
 */


/* body X extrude */
difference(){
    intersection() {
        rotate([90, 0, 0])
            linear_extrude(height = 100, center = true, $fn=50)
                    import("axeX_bottom_profile-0.dxf");

        linear_extrude(height = 200, center = true, $fn=50)
                import("axeX_bottom_profile-2.dxf");
    }

    intersection() {
        rotate([90, 0, 0])
            linear_extrude(height = 100, center = true, $fn=50)
                    import("axeX_bottom_profile-1.dxf");

        linear_extrude(height = 200, center = true, $fn=50)
                import("axeX_bottom_profile-3.dxf");
    }
    
    /* hole axe Z */
    translate([-26, 34, 14])
        cylinder(d = 7.5, h=50, $fn = 50);
    translate([-26, -34, 14])
        cylinder(d = 7.5, h=50, $fn = 50);
}
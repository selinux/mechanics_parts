/* ======================================================================
 *
 *       Filename:  axeX_top.scad
 *
 *    Description:  top support for X axe motor and bearing
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

screw = 3.5;
nuts = 6.5;

difference(){
    /* body X extrude */
    intersection() {
        rotate([90, 0, 0])
            linear_extrude(height = 100, center = true, $fn=50)
                    import("axeX_top_profile-0.dxf");

        linear_extrude(height = 200, center = true, $fn=50)
                import("axeX_top_profile-1.dxf");
    }

    /* hole axe Z */
    translate([-26, 38, 0])
        cylinder(d = 7.5, center = true, h=50);
    translate([-26, -38, 0])
        cylinder(d = 7.5, center = true, h=50);
    
    /* motor hole */
    translate([21, 0, 0])
        cylinder(d = 25.5, center = true, h=50);
    translate([0, -20, 8])
        cube([55, 40, 40]);
    
    /* motor screw holes */
    translate([21, 0, 0]) {
        translate([15.52, 15.52, 5]) {
            cylinder(d = screw, center = true, h=50);
            cylinder(d = nuts, h = 5, $fn = 6);
        }
        translate([15.52, -15.52, 5]) {
            cylinder(d = screw, center = true, h=50);
            cylinder(d = nuts, h = 5, $fn = 6);
        }
        translate([-15.52, 15.52, 5]) {
            cylinder(d = screw, center = true, h=50);
            cylinder(d = nuts, h = 5, $fn = 6);
        }
        translate([-15.52, -15.52, 5]) {
            cylinder(d = screw, center = true, h=50);
            cylinder(d = nuts, h = 5, $fn = 6);
        }
    }
}
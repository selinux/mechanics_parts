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

include <../libs/MCAD/motors.scad>

screw = 4.5;
nuts = 8;

axeX_top();

module axeX_top() {
    difference() {
        /* body X extrude */
        intersection() {
            rotate([90, 0, 0])
                linear_extrude(height = 100, center = true, $fn=50)
                        import("../profiles/support_motor_axeX-s0.dxf");
    
            linear_extrude(height = 200, center = true, $fn=50)
                    import("../profiles/support_motor_axeX-s1.dxf");
            
            rotate([90, 0, 90])
                linear_extrude(height = 200, center = true, $fn=50)
                        import("../profiles/support_motor_axeX-s2.dxf");
        }
        /* screw holes */
        rotate([0, -90, 0]) {
            translate([33, 36.5, -47]) {
                union() {
                    cylinder(d=screw, h=100, center=true, $fn=50);
                    cylinder(d=nuts, h=100, $fn=6);
                }
            }
            translate([33, -36.5, -47]) {
                union() {
                    cylinder(d=screw, h=100, center=true, $fn=50);
                    cylinder(d=nuts, h=100, $fn=6);
                }
            }
        }
    
        /* hole axe Z */
        translate([-26, 38, 0])
            cylinder(d = 7.5, center = true, h=50);
        translate([-26, -38, 0])
            cylinder(d = 7.5, center = true, h=50);
        
        /* motor hole */
        translate([21, 0, 0])
            linear_extrude(height = 2*support_h, $fn=50)
                rotate([0, 0, 90])
                    stepper_motor_mount(17,slide_distance=3, mochup=true, 
        tolerance=0);
    }
}
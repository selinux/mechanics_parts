/* ====================================================================
 *
 *       Filename:  bearing-lme12_22x32.scad
 *
 *    Description:  linear bearing support LME12UU
 *
 *                  function diameter : 12
 *                  external diameter : 22
 *                  length            : 32
 *
 *        Version:  1.0
 *        Created:  07 06 2016
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Sebastien Chassot (sinux), seba.ptl@sinux.net
 *
 * ====================================================================
 */


bearing_len = 32.5;
bearing_dia = 22;
bearing_rad = bearing_dia/2;
depth_len = 2;
length = bearing_len + depth_len*2;
support_len = 25;

screw = 4.5;
nuts = 8;
depth_screw = 2.5;
position = 22;

//support_lin_bearing();
module support_lin_bearing() {
    difference() {
        
        /* Body */
        translate([0,0,bearing_rad]) {
            rotate([90,0,0]) {
                difference() {
                    /* outside */
                    linear_extrude(height=length, center =true, $fn=50)
                             import("../profiles/bearing-lme12-s0.dxf");                
                    /* inside */
                    linear_extrude(height=bearing_len, center = true, $fn=50)
                            import("../profiles/bearing-lme12-s1.dxf");
                }
            }
        }
    
        /* screw fixation */
        translate([position, 10, depth_screw]) {
            union() {
                cylinder(d = nuts, h = 5, $fn = 6);
                cylinder(d = screw, h = 10, center =true, $fn = 50);
            }
        }
        translate([position, -10, depth_screw]) {
            union() {
                cylinder(d = nuts, h = 5, $fn = 6);
                cylinder(d = screw, h = 10, center =true, $fn = 50);
            }
        }
        /* screw fixation */
        translate([-position, 10, depth_screw]) {
            union() {
                cylinder(d = nuts, h = 5, $fn = 6);
                cylinder(d = screw, h = 10, center =true, $fn = 50);
            }
        }
        translate([-position, -10, depth_screw]) {
            union() {
                cylinder(d = nuts, h = 5, $fn = 6);
                cylinder(d = screw, h = 10, center =true, $fn = 50);
            }
        }
    }
}
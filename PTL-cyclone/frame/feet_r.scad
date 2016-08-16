/* ====================================================================
 *
 *       Filename:  feet_r.scad
 *
 *    Description:  Ø 8 axe support
 *
 *        Version:  1.0
 *        Created:  05 07 2016
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Sebastien Chassot (sinux), seba.ptl@sinux.net
 *
 * ====================================================================
 */


feet_dia = 4.4;
screw_dia = 5.3;
axes = 20;
high = 55;

//feet_r();
module feet_r() {

    /* Body */
    difference() {
        union() { 
            /* outside */
            linear_extrude(height=high, center = false, $fn = 80)
                    import("../profiles/feet_r-s0.dxf");
        
            /* inside */
            
        }             
        cylinder(d = feet_dia, h = 3*high, center=true, $fn = 80);
        translate([0, -11, 10])
            rotate([0, 90, 0])
                cylinder(d = screw_dia, center=true, h = 30, $fn = 80);        
        translate([11, 0, 10])
            rotate([90, 0, 0])
                cylinder(d = screw_dia, center=true, h = 30, $fn = 80);    
        translate([11, 0, 10+axes])
            rotate([90, 0, 0])
                cylinder(d = screw_dia, center=true, h = 30, $fn = 80);    

       rotate([-30, 0, 0])
           translate([0, -47, 0])
                cube([50,50,200], center=true);
       }

}
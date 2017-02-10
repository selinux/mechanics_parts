/* ======================================================================
 *
 *       Filename:  axeZ_bottom-main.scad
 *
 *    Description:  motors mount 
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


support_h = 9;
bearing_d = 15;
axe_pos = 76;

axeZ_bottom();

module axeZ_bottom() {
    
    difference(){
        union(){
        /* motor mount */
            linear_extrude(height = support_h, $fn=50)
                import("../profiles/axeZ_bottom-s0.dxf");
            translate([axe_pos/2, 0, support_h])
                cylinder(d1 = 22, d2 = 21, h = 10, $fn = 80);
            translate([-axe_pos/2, 0, support_h])
                cylinder(d1 = 22, d2 = 21, h = 10, $fn = 80);
        }
        
        translate([26.5, -10, support_h/2])
            rotate([90, 0, 0])
            cylinder(d = 3, h = 20, center = true, $fn = 80);
        translate([-26.5, -10, support_h/2])
            rotate([90, 0, 0])
            cylinder(d = 3, h = 20, center = true, $fn = 80); 
        
        translate([axe_pos/2, 0, 0])
            cylinder(d = bearing_d, h = 50, center = true, $fn = 80);
        translate([-axe_pos/2, 0, 0])
            cylinder(d = bearing_d, h = 50, center = true, $fn = 80);
    }
}

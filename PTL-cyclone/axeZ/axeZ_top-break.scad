/* ======================================================================
 *
 *       Filename:  axeZ_top_break.scad
 *
 *    Description:  spindle mount 
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
bearing_d = 16.3;
axe_pos = 76;

//axeZ_top_break();

module axeZ_top_break() {
    
    difference(){

        /* motor mount */
            linear_extrude(height = support_h, $fn=50)
                import("../profiles/axeZ_top-s3.dxf");
        
        translate([26.5, -10, support_h/2])
            rotate([90, 0, 0])
            cylinder(d = 3, h = 50, center = true, $fn = 80);
        translate([-26.5, -10, support_h/2])
            rotate([90, 0, 0])
            cylinder(d = 3, h = 50, center = true, $fn = 80); 
        
    }
}

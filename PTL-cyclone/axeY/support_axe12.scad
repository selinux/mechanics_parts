/* ========================================================================
 *
 *       Filename:  support_axe12.scad
 *
 *    Description:  eccentric support for Ø12 axes
 *                   
 *                  eccentric adjustment (rotation) for Y axe mounted on
 *                  20x20 type 5 profile
 * 
 *        Version:  1.0
 *        Created:  07 06 2016
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Sebastien Chassot (sinux), seba.ptl@sinux.net
 *
 * ========================================================================
 */


axe_dia = 12;
ext_dia = 20;
length = 15;
support_depth = 5;

resolution = 100;

support_axe12();

module support_axe12() {
    
    difference() {
        union(){
            linear_extrude(height=support_depth, scale = 0.97, $fn=resolution)
                                import("../profiles/suport_axe12-s0.dxf");
            
            cylinder(d1 = ext_dia+3, d2 = ext_dia, h = length, $fn = 80);
            
            translate([-15,15.4,0])
                cube([30,3,11]);
        }
                                
        linear_extrude(height=support_depth*3, center =true, $fn = resolution/2)
                                import("../profiles/suport_axe12-s1.dxf");        
    
        cylinder(d = axe_dia, h = length*2.5, center =true, $fn = 80);
        
        translate([9.5, 20, 8])
            rotate([90, 0, 0])
                cylinder(d = 2, h = 10, $fn=80);
        
        translate([-9.5, 20, 8])
            rotate([90, 0, 0])
                cylinder(d = 2, h = 10, $fn=80);
        
    }
}
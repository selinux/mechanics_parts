/* ====================================================================
 *
 *       Filename:  axeY_nuts_support.scad
 *
 *    Description:  support for home made nuts
 **
 *        Version:  1.0
 *        Created:  13 08 2016
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Sebastien Chassot (sinux), seba.ptl@sinux.net
 *
 * ====================================================================
 */



nuts_dia = 17.8;
length = 60;

position = 19.5;

axeY_nuts_support();


            
module axeY_nuts_support() {
    difference() {
        
        /* Body */

        /* outside */
        union() {
            linear_extrude(height=length, center =true, $fn=100)
                     import("../profiles/axeY_nuts_support-s0.dxf");

            linear_extrude(height=6, center =true, $fn=100)
                     import("../profiles/axeY_nuts_support-s1.dxf");
            translate([0,0,length/2])
            linear_extrude(height=6, center =true, $fn=100)
                     import("../profiles/axeY_nuts_support-s1.dxf");
            translate([0,0,-length/2])
            linear_extrude(height=6, center =true, $fn=100)
                     import("../profiles/axeY_nuts_support-s1.dxf");
        }
        
        cylinder(d=nuts_dia, h=100, center=true, $fn=80);
        
        translate([position, 18, 15]) 
            rotate([90, 0, 0])
                cylinder(d = 4, h = 20, center=true, $fn = 80);
        
        translate([position, 18, -15]) 
            rotate([90, 0, 0])
                cylinder(d = 4, h = 20, center=true, $fn = 80);

       translate([-position, 18, 15]) 
            rotate([90, 0, 0])
                cylinder(d = 4, h = 20, center=true, $fn = 80);
        
        translate([-position, 18, -15]) 
            rotate([90, 0, 0])
                cylinder(d = 4, h = 20, center=true, $fn = 80);

    }
}
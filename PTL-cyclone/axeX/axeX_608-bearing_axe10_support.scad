/* ====================================================================
 *
 *       Filename:  axeX_608-bearing_axe10_support.scad
 *
 *    Description:  608 bearing support
 *
 *                  external diameter : 22
 *                  in diameter       : 8 
 *                  length            : 7
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


bearing_len = 7;
bearing_dia = 22;
shoulder_dia = 19.5;

depth_len = 5;

axeX_bearing_axe10();
module axeX_bearing_axe10() {

    /* Body */
    difference() {
        union() { 
            /* outside */
            linear_extrude(height=depth_len, center = false, $fn = 80)
                    import("../profiles/support_axe10_bearing-s0.dxf");
            translate([0, 0, depth_len])
                cylinder(d1 = 28, d2 = 27.5,  h = 3, $fn = 80);
            
            translate([20, -19, depth_len])
                cylinder(d1 = 18, d2 = 17, h = 5, $fn = 80);
        }             

        /* inside */
        cylinder(d = shoulder_dia, center = true, h = bearing_len*10, $fn = 80);

        translate([0, 0, 2.5])
            cylinder(d1 = bearing_dia, d2 = bearing_dia+0.8, h = 15, $fn = 80);
        
        translate([20, -19, 0])
            cylinder(d = 10, h = 50, center = true, $fn = 80);
        
    }
}
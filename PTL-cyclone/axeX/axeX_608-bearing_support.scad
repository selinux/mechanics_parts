/* ====================================================================
 *
 *       Filename:  axeX_608-bearing_support.scad
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
bearing_dia = 22.5;
shoulder_dia = 19.5;

depth_len = 5;

//axeX_608_bearing();
module axeX_608_bearing() {

    /* Body */
    difference() {
        union() { 
            /* outside */
            linear_extrude(height=depth_len, center = false, $fn = 80)
                    import("../profiles/axeX_bearing-608-s0.dxf");
            translate([0, 0, depth_len])
                cylinder(d1 = 28, d2 = 27.5,  h = 3, $fn = 80);
        }             

        /* inside */
        cylinder(d = shoulder_dia, center = true, h = bearing_len*10, $fn = 80);

        translate([0, 0, 2.5])
            cylinder(d1 = bearing_dia, d2 = bearing_dia+0.8, h = 15, $fn = 80);
        
    }
}
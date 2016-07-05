/* ====================================================================
 *
 *       Filename:  axeX_axe-8_support.scad
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


axe_dia = 8;

depth_len = 5;

//axeX_axe8_bearing();
module axeX_axe8_bearing() {

    /* Body */
    difference() {
        union() { 
            /* outside */
            linear_extrude(height=depth_len, center = false, $fn = 80)
                    import("../profiles/support_axe8-s0.dxf");
            translate([0, 0, depth_len])
                cylinder(d1 = 14, d2 = 13.5,  h = 3, $fn = 80);
        }             

        /* inside */
        cylinder(d1 = axe_dia, d2 = axe_dia+0.5, h = 15, $fn = 80);
        
    }
}
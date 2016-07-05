/* ====================================================================
 *
 *       Filename:  axeX_axe-10_support.scad
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


axe_dia = 10;

depth_len = 5;

//axeX_axe10_bearing();
module axeX_axe10_bearing() {

    /* Body */
    difference() {
        union() { 
            /* outside */
            linear_extrude(height=depth_len, center = false, $fn = 80)
                    import("../profiles/support_axe10-s0.dxf");
            translate([0, 0, depth_len])
                cylinder(d1 = 16, d2 = 15.5,  h = 3, $fn = 80);
        }             

        /* inside */
        cylinder(d1 = axe_dia, d2 = axe_dia+0.5, h = 15, $fn = 80);
        
    }
}
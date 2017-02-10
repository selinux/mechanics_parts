/* ====================================================================
 *
 *       Filename:  endstop_support.scad
 *
 *    Description:  Ø 8 axe support
 *
 *        Version:  1.0
 *        Created:  23 08 2016
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Sebastien Chassot (sinux), seba.ptl@sinux.net
 *
 * ====================================================================
 */


high = 30;


endstop_support();

module endstop_support() {

    /* Body */
    linear_extrude(height=high, center = false, $fn = 80)
        import("../profiles/endstop_support-s0.dxf");



}
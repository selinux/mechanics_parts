/* ======================================================================
 *
 *       Filename:  axeY_motor_support.scad
 *
 *    Description:  608 bearing support for Y axe screw
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

support_h = 3;


linear_extrude(height = support_h, $fn=50)
            import("axeY_motor_support.dxf");


/* =====================================================================================
 *
 *       Filename:  profile_20.scad
 *
 *    Description:  Profile 5 20x20
 *
 *        Version:  1.0
 *        Created:  02 04 2016
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Sebastien Chassot (sinux), seba.ptl@sinux.net
 *
 * =====================================================================================
 */

//profile2060(100);
//profile2020(200);

/* profile 20x20 mod5 */
module profile2020(length) {
    linear_extrude(height=length, $fn=50)
                import("profile_20x20_5.dxf");
}

/* profile 20x60 mod5 */
module profile2060(length) {
    linear_extrude(height=length, $fn=50)
                import("profile_20x60_5.dxf");
}
/* ======================================================================
 *
 *       Filename:  ptl-cyclone_logo.scad
 *
 *    Description:  Logo for PTL-Cyclone
 *
 *        Version:  1.0
 *        Created:  12 03 2017
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Sebastien Chassot (sinux), seba.ptl@sinux.net
 *
 * =====================================================================
 */



ptl_cyclone_logo();

/* body X extrude */
module ptl_cyclone_logo() {

               
    linear_extrude(height = 2, center = false, $fn=80)
        import("./ptl-cyclone_logo.dxf");
    
}
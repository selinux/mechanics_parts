/* =====================================================================
 *
 *       Filename:  dremel.scad
 *
 *    Description:  
 *
 *
 *        Version:  1.0
 *        Created:  07 06 2016
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Sebastien Chassot (sinux), seba.ptl@sinux.net
 *
 * =====================================================================
 */

//dremel();
module dremel() {

    color([0.2,0.2,0.2]) %cylinder(r1=30/2, r2=50/2, h=40, $fn=80);
    translate([0,0,40])
        color([0.2,0.2,0.2]) %cylinder(d=50, h=90, $fn=80);
    translate([0,0,50+80])
        color([0.2,0.2,0.2]) %cylinder(d1=50, d2=30, h=10, $fn=80);
    translate([0,0,-20])
        color([0.4,0.4,0.4]) %cylinder(d1=12, d2=10, h=20, $fn=80);
    translate([0,0,-20-20])
        color([0.9,0.9,0.9]) %cylinder(d1=0.5, d2=3, h=20, $fn=80);
}
 
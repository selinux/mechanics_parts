/* =====================================================================
 *
 *       Filename:  PTL-cyclone.scad
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

use <./profile/profile_20.scad>
use <./support_axeY-12/support_axe12.scad>
profile = 20;
cyclone_L = 600;
cyclone_l = 300;
cyclone_h = 300;

//profile2020(120);


union(){
    
    /* rear */
    translate([(cyclone_l+profile)/2, cyclone_L, cyclone_h+3.5*profile])
        rotate([90, 0,0])
            profile2020(cyclone_L-cyclone_h+100);
    translate([-(cyclone_l+profile)/2, cyclone_L, cyclone_h+3.5*profile])
        rotate([90, 0,0])
            profile2020(cyclone_L-cyclone_h+100);
    
    /* X axe support */
    translate([(cyclone_l+profile)/2, 350, 3*profile])
            profile2060(cyclone_h);
    translate([-(cyclone_l+profile)/2, 350, 3*profile])
            profile2060(cyclone_h);
    
    /* top */
    translate([(cyclone_l+profile)/2, cyclone_L-0.5*profile, 3*profile])
            profile2020(cyclone_h);
    translate([-(cyclone_l+profile)/2, cyclone_L-0.5*profile, 3*profile])
            profile2020(cyclone_h);
    translate([-(cyclone_l)/2, cyclone_L-0.5*profile, cyclone_h+3.5*profile])
            rotate([0, 90, 0])
                profile2020(cyclone_h);
    translate([-(cyclone_l)/2, 220-0.5*profile, cyclone_h+3.5*profile])
            rotate([0, 90, 0])
                profile2020(cyclone_h);
    
    /* base */  
    translate([(cyclone_l+profile)/2, cyclone_L, 1.5*profile])
        rotate([90, 0,0])
            profile2060(cyclone_L);
    translate([-(cyclone_l+profile)/2, cyclone_L, 1.5*profile])
        rotate([90, 0,0])
            profile2060(cyclone_L);
            
    translate([-cyclone_l/2, 80, 1.5*profile])
        rotate([90, 0, 90])
            profile2060(cyclone_l);
            
    translate([-cyclone_l/2, 530, 1.5*profile])
        rotate([90, 0, 90])
            profile2060(cyclone_l);
}
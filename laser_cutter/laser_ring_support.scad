
/* =====================================================================================
 *
 *       Filename:  laser_ring_support.scad
 *
 *    Description:  support for two laser beam (red)
 *
 *        Version:  1.0
 *        Created:  04 08 2015
 *       Revision:  none
 *
 *       Compiler:  gcc
 *         Author:  Sebastien Chassot (sinux), sebastien.chassot@etu.hesge.ch
 *        Company:  HES-SO hepia section ITI (soir)
 *
 * ===================================================================================== */


difference(){
    /* main part */
    
    linear_extrude(height=11, center=true, $fn=50)
        import("laser_ring_support.dxf");
                        
    rotate([0,90,0]){
    
        cylinder(h=50, d=2, center=true, $fn=50){}
        }
    

}
 
 
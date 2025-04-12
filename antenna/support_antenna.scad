/* =====================================================================================
 *
 *       Filename:  support_antenna.scad
 *
 *    Description:  support antenna for NOAA HRTP 1.7GHz parabole
 *
 *        Version:  1.0
 *        Created:  23 08 2017
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Sebastien Chassot (sinux), sebastien.chassot@etu.hesge.ch
 *        Company:  HES-SO hepia section ITI (soir)
 *
 * =====================================================================================
 */

length = 157;      // case length
thickness = 2;     // case thickness
diam = 10;

support_antenna();

module support_antenna(){
    intersection(){
        
        /* union of base, 2 side and 6 supports*/
        union(){
            rotate([30,0,0]){
                /* base extrusion */
                linear_extrude(height=34, $fn=50)
                    import("support_profil.dxf");
                rotate([0,90,0])
                    translate([-34,9.15,25])
                        cylinder(d=17,h=4, $fn=100);
            }
            cube([48.3,78,3]);
            translate([2,3.4,0])
                cube([44,3,40]);
        }
        rotate([90,0,90])
            linear_extrude(height=100, center=true)
                import("support_ext.dxf");
    }
    
}
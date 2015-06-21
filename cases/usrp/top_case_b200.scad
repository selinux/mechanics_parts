/* =====================================================================================
 *
 *       Filename:  top_case.scad
 *
 *    Description:  Top case for an USRP B200 (sdr card)
 *
 *        Version:  1.0
 *        Created:  02 06 2015
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Sebastien Chassot (sinux), sebastien.chassot@etu.hesge.ch
 *        Company:  HES-SO hepia section ITI (soir)
 *
 * =====================================================================================
 */
include <Write.scad>


length = 157;      // case length
thickness = 2;     // case thickness
diam = 10;


top_case_b200();


module top_case_b200(){
    difference(){
        /* union of base, 2 side and 6 supports*/
        union(){
            rotate([0,-90,0]){
                /* base extrusion */
                linear_extrude(height=length, $fn=50)
                    import("2d-sections/top_case_sec.dxf");
                
                translate([0,0,-thickness]){
                    /* */    
                    linear_extrude(height=thickness, $fn=50)
                        import("2d-sections/top_usb_side.dxf");
                }
                
                translate([0,0,length]){
                    /* */    
                    linear_extrude(height=thickness, $fn=50)
                        import("2d-sections/top_antenna_side.dxf");
                }
            }
            translate([-15.5,0,0]){
                for(i=[0:1]){
                    translate([-120*i,46.5,2]){
                        difference(){
                            cylinder(d=7, h=17.5, $fn=50);
                            cylinder(d=1.5, h=15, $fn=50);
                        }
                    }
                    translate([-120*i,-46.5,2]){
                        difference(){
                            cylinder(d=7, h=17.5, $fn=50);
                            cylinder(d=1.5, h=15, $fn=50);
                        }
                    }
                }
            }
        }
        
        /* two hole for reset buttons */
        translate([-16.5,17,0]){
            cylinder(d=6, h=30, $fn=50);
        }
        translate([-21.5,-27.5,0]){
            cylinder(d=6, h=30, $fn=50);
        }
        
        /* remove support overstep */
        rotate([0,-90,0]){
            linear_extrude(height=length, $fn=50)
                import("2d-sections/top_outside_remove.dxf");
        }
        translate([-97,22,15]){
            write("sinux", h=10, t=10);
        }

        scale([1.25,1.25,1]){
        translate([-63,-12,0]){
            linear_extrude(height = 302, center = false, convexity = 10)
                import (file = "logo_PTL_reduit.dxf");
        }
    }
    }

}
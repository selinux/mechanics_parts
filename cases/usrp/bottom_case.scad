/* =====================================================================================
 *
 *       Filename:  bottom_case.scad
 *
 *    Description:  Bottom case for an USRP B200 (sdr card)
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

length = 157;      // case length
thickness = 2;     // case thickness
diam = 10;

bottom_case();

module bottom_case(){
    difference(){
        
        /* union of base, 2 side and 6 supports*/
        union(){
            rotate([0,-90,0]){
                /* base extrusion */
                linear_extrude(height=length, $fn=50)
                    import("2d-sections/bottom_case_sec.dxf");
                
                translate([0,0,-thickness]){
                    /* */    
                    linear_extrude(height=thickness, $fn=50)
                        import("2d-sections/bottom_usb_side.dxf");
                }
                
                translate([0,0,length]){
                    /* */    
                    linear_extrude(height=thickness, $fn=50)
                        import("2d-sections/bottom_antenna_side.dxf");
                }
            }
            
            /* 3 support (middle one is unused) */
            translate([-15.5,48.5,-7]){
                for(i=[0:2]){
                    translate([-60*i,0,0]){
                        difference(){
                            union(){
                                cylinder(d=diam,h=7, $fn=50);
                            
                                translate([-diam/2,0,0]){
                                    cube([diam,4,7], center=false);
                                }
                            }
                            cylinder(d=2,h=7, $fn=50);
                        }
                    }
                }
            }
            translate([-15.5,-48.5,-7]){
                for(i=[0:2]){
                    translate([-60*i,0,0]){
                        difference(){
                            union(){
                                cylinder(d=diam,h=7, $fn=50);
                            
                                translate([-diam/2,-4,0]){
                                    cube([diam,4,7], center=false);
                                }
                            }
                            cylinder(d=2,h=7, $fn=50);
                        }
                    }
                }
            }
        }
        
        /* remove support overstep */
        rotate([0,-90,0]){
            linear_extrude(height=length, $fn=50)
                import("2d-sections/bottom_outside_remove.dxf");
        }
    }
}
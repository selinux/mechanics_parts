/* ======================================================================
 *
 *       Filename:  case_main.scad
 *
 *    Description:  case for Arduino Uno with lora transmitter shield
 *
 *        Version:  1.0
 *        Created:  12 03 2017
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Sebastien Chassot, sebastien.chassot@@etu.hesge.ch
 *
 * =====================================================================
 */

encoder_d = 9.3;
toth = 34.5;
border = 2.5;
antenna_d = 8;

//case_main();

/* body X extrude */
module case_main() {

    difference() {
            
        linear_extrude(height = toth, center = false, $fn=80)
            import("./sec_base.dxf");

        translate([0,0,border])
            linear_extrude(height = toth, center = false, $fn=80)
                import("./sec_in0.dxf");
        
        translate([0,0,border+0.5])
            linear_extrude(height = toth, center = false, $fn=80)
                import("./sec_in1.dxf");

        translate([0,0,toth-border])
            linear_extrude(height = border+1, center = false, $fn=80)
                import("./sec_cover.dxf");
        
        /* hole */
        translate([12.5, 4.8, -1])
            cylinder(d=encoder_d, h=toth+2, $fn=100);
    
        translate([30, -50, 31.5])
            cube([20,100,10]);
    
        translate([74, 12.8, 8]) {
            rotate([0,-90,0]) {
                linear_extrude(height=2*border, center=true) {
                    circle(d=antenna_d, $fn=100);
                    translate([0,-antenna_d/2,0])
                        square([150,antenna_d]);
                }
            }
        }
        translate([border+1, -18.7, 16])
            rotate([0, 270, 0])
                linear_extrude(h=2*border)
                    square([25, 14]);
    
        translate([border+1, 13.8, 17])
            rotate([0, 270, 0])
                linear_extrude(h=2*border)
                    square([25, 10]);

    }
                
}
/* ======================================================================
 *
 *       Filename:  case_cover.scad
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

border = 2.5;
hole_d = 1.5;

//case_cover();

/* body X extrude */
module case_cover() {

    difference() {
                
        union() {
                
            linear_extrude(height = border, center = false, $fn=80)
                import("./sec_base_cover.dxf");
    
            /* connector USB */
            translate([-3.5, -17.7, -4])
                cube([7, 12, 4]);
            
            /* connector alim */        
            translate([0, 14.3, -4])
                cube([border, 9, 4]);
            
            /* connector antenna */        
            translate([69.75+border, 9.3, -20])
                cube([border, 7, 20]);
        }
        translate([0, 4.8, 0])
        cylinder(d=hole_d, h=10, center=true, $fn=100);
        translate([72, -22, 0])
            cylinder(d=hole_d, h= 10, center=true, $fn=100);
    }   
}
/* =====================================================================================
 *
 *       Filename:  rpi_holer.scad
 *
 *    Description:  rpi zero holder
 *
 *        Version:  1.0
 *        Created:  29 05 2020
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Sebastien (sinux), seba.ptl@sinux.net
 *
 * =====================================================================================
 */

/* mobile rpi holder */
module mobile(){
  translate([0, 25, 2]) difference(){
    union() {
      rotate([0,90,0])  cylinder(d=8,h=38, center=true, $fn=50);
      translate([0,0,-3]) cube([38,8,5], center=true);
    }
    cube([30,20,20], center=true);
    rotate([0,90,0]) cylinder(d=3.5,h=50, center=true, $fn=50);
  }


  difference(){
    union(){
      translate([-15, 0, -3.5]) cube([30,20,3.5]);
      // base
      difference() {
        translate([-19,0,-3.5]) cube([38,29,1.5]);
        // opening
        translate([-19,0,-3.5]) cube([3,9,20], center=true);
        translate([19,0,-3.5]) cube([3,9,20], center=true);
      }
  
      // rotation
      rotate([90,0,0]) rotate_extrude($fn=100) union(){
        translate([0,-0.75,6]) square([22,1.5]);
        translate([21.5,-2,6]) square([1.5,4]);
      }
    }
    translate([-50,-20,-53.5]) cube([100, 100, 50]);
    translate([1,0,6]) cube([32,60,12], center=true);
    translate([11.6,14,0]) cylinder(d=5.5,h=5, center=true, $fn=50);
    translate([-11.6,14,0]) cylinder(d=5.5,h=5, center=true, $fn=50);
    translate([-12,-5,0]) cube([24,10,15]);
    translate([-15,-2,-2]) cube([7,12.5,5]);
  }
}

/* support */
module support(){
  union() { 
    translate([0,6,0]) difference(){
      translate([0,0,-4]) cylinder(d=50, h=8, $fn=100);
      rotate_extrude($fn=100) union(){
        translate([0,-1,0]) square([22,2]);
        translate([21.25,-2.5,0]) square([2,5]);
      }
      translate([0,0,-5]) cylinder(d=35, h=10, $fn=100);
      translate([-50,0,-5]) cube([100,60,10]); 
    }

    difference() {translate([23.5,3,-9]) cube([20,3,18]);
      rotate([90,0,0]) translate([35,0,-9]) cylinder(d=7, h=30, center=true, $fn=50);}
    difference() {translate([-43.5,3,-9]) cube([20,3,18]);
      rotate([90,0,0]) translate([-35,0,-9]) cylinder(d=7, h=30, center=true, $fn=50);}

    //translate([35.5,0,-4]) cube([8,26,8]);
    //translate([-43.5,0,-4]) cube([8,26,8]);
  }
}

/* cam holder */
module cam(){
  union(){
    difference() {
      translate([-15,0,0]) cube([30,24,1.5]);
      translate([-7.5,4,0])cube([15,22,5]);
      translate([10.5,9.5,0]) cylinder(d=2.5, h=10, $fn=50);
      translate([-10.5,9.5,0]) cylinder(d=2.5, h=10, $fn=50);
      translate([10.5,21.5,0]) cylinder(d=2.5, h=10, $fn=50);
      translate([-10.5,21.5,0]) cylinder(d=2.5, h=10, $fn=50);
    }
    
    translate([-15,0,0]) union() {
      difference() { 
        hull(){
          translate([0,-5,0]) cube([3,10,1.5]);
          translate([1.5,-10,11]) rotate([90,0,90]) cylinder(d=6, h=3, center=true, $fn=50);
        }
        translate([1,-10,11]) rotate([90,0,90]) cylinder(d=2.5, h=10, center=true, $fn=50);
      }
    } 
    translate([12,0,0]) union() {
      difference() { 
        hull(){
          translate([0,-5,0]) cube([3,10,1.5]);
          translate([1.5,-10,11]) rotate([90,0,90]) cylinder(d=6, h=3, center=true, $fn=50);
        }
        translate([1,-10,11]) rotate([90,0,90]) cylinder(d=2.5, h=10, center=true, $fn=50);
      }
    }
  }
}

//rotate([0,-45,0]) {
  mobile();
//  translate([0,38,9]) rotate([20,180,0]) cam();
//}
//translate([0,0,6]) rotate([-90,0,0]) support();

//mobile();


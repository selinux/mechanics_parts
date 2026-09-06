/* =====================================================================================
 *
 *       Filename:  
 *
 *    Description:  tripod support for 868Mhz Yagi antenna
 *
 *        Version:  1.0
 *        Created:  06 09 2026
 *       Revision:  none
 *       Compiler:  openscad
 *
 *         Author:  Sebastien Chassot (sinux)
 *
 * =====================================================================================
 */


label = "sinux";

Lt = 42;
Hb = 10;

difference(){
  union(){
    base();
    support();
  }
  inner();
}

module support(){
  d1=40; e=5; s=d1-8;
  translate([0,0,22])
    rotate([90,0,0])
      cylinder(h=Lt, d=d1, $fn=50, center=true);
  translate([0,0,(Hb+e)/2])
  cube([s,Lt,e], center=true);
//  cube([8,Lt,Hb+2],center=true);
}


module inner(){
  sq=22;
  cube([4, Lt+1, Hb+15], center=true);
  translate([0,0,22])
    cube([sq,Lt+1,sq], center=true);
}

module base(){

  difference(){
    cube([Lt, Lt, Hb], center=true);

    // slider
    translate([32/2,-(Lt+1)/2,0]){
      rotate([0,45,0]){
        cube([Hb*2, Lt+1, Hb*2]);}}
    rotate([0,0,180])
      translate([32/2,-(Lt+1)/2,0]){
        rotate([0,45,0]){
          cube([Hb*2, Lt+1, Hb*2]);}}
  }
}
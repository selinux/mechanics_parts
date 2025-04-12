/* =====================================================================================
*
*       Filename:
*
*    Description:  pasta stand for camera mount tripod
*
*        Version:  1.0
*        Created:  30 03 2025
*       Revision:  none
*       Compiler:  gcc
*
*         Author:  Sebastien Chassot (sinux), seba.ptl@sinux.net
*
* =====================================================================================
*/

// number of support
N=6;

// support diameter
d1=10;

// loose
e1=1;

// external size
d0=50;
h0=d1*N/2+d1;


union(){
  translate([0,0,d1/2+3])
    difference(){
      body();
      for(i = [1:1:N/2]) holes(i);
    }
  base();
}



//
module body() {
  difference(){
    translate([0,0,-(d1/2+4)])
      cylinder(h=h0, d=d0, center=false, $fn=100);
      translate([0,0,-d1])
        cylinder(h=2*h0,d=d0-20, center=false, $fn=100);
  }
}

// N fences
module holes(pos){
  // angle depending on pos
  ang=pos*(360/N);
  translate([0,0,(pos-1)*(d1+e1)]){
    rotate([0,270,ang]){
      linear_extrude(2*h0, center=true){
        // last hole is not a fence
        lon = (pos == N/2 ) ? 0 : h0;
        hull(){
          translate([lon,0,0]) circle(d=d1+e1, $fn=100);
          circle(d=d1+e1, $fn=100);
        }
      }
    }
  }
}

// arca-swiss mount
module base(){
  s1=42; s2=d0; h=10;
  
  intersection(){
    cylinder(h=2*h, d=d0, center=true, $fn=100);
    difference(){
      off=-(h/2-2);
      translate([0,0,off])
        cube([s2,s1,h], center=true);
      translate([0,s1/2,off])
        rotate([45,0,0])
          cube([s2+10,h/sqrt(2),h/sqrt(2)], center=true);
      translate([0,-s1/2,off])
        rotate([45,0,0])
          cube([s2+10,h/sqrt(2),h/sqrt(2)], center=true);
    }
  }
}


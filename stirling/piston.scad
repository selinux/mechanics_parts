// cylinderplates for stirling engine (CNC)
// Sebastien C.
//


h=10;

difference(){
    cylinder(h, d=115, $fn=200);

    translate([0,0,h/2+1]) cylinder(h, d=1.3,center=true, $fn=100);

}
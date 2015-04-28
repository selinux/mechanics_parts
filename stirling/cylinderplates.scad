// cylinderplates for stirling engine (CNC)
// Sebastien C.
//


h=2;

difference(){
    cylinder(h, d=125,center=true, $fn=100);

    translate([0,50,0]) {
        translate([-6,0,0]) cylinder(2*h, d=2,center=true, $fn=100);
        cylinder(2*h, d=6,center=true, $fn=100);
        translate([6,0,0]) cylinder(2*h, d=2,center=true, $fn=100);
    }
    cylinder(2*h, d=5,center=true, $fn=100);
    translate([0,-40,0]) cylinder(2*h, d=3,center=true, $fn=100);
}
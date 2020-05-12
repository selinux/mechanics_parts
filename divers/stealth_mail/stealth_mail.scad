
module boitier() {
    ra = 3;
    color("Black")
    minkowski(){
        cube([70-2*ra,300-2*ra,9-2*ra], center=true);
        sphere(r = 3, $fn=100);
    }
}

module button() {
    color("Gray")
    union(){
        hull(){
            translate([0,4,0]) cylinder(r=1.5, h=7+2, $fn=50, center=true);
            cylinder(r=1.5, h=7+2, $fn=50, center=true);
        }
    }
}

boitier();
translate([-32,0,1]) button();
translate([-32,-50,1]) button();
translate([-32,50,1]) button();
translate([-32,-100,1]) button();
translate([-32,100,1]) button();

translate([2,0,4.6]) color("Yellow") cube([62,295,0.3], center=true);

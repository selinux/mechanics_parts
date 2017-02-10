d = 180;
h = 120;
l = 176;
L = 48;
s = 5;
$fn = 50;
difference(){
    hull(){
        rotate([45,0,0]) cylinder( d = d+2*s, h = 0.1);
        translate([-(l+2*s)/2,-L-s-40,0]) cube([l+2*s,L+2*s,h], center = false);  
    } 
    hull(){
        rotate([45,0,0]) cylinder( d = d, h = 0.1);
        translate([-l/2,-L-40,0.1]) cube([l,L,h], center = false);  
    } 
}
difference(){
    union(){
        translate([-(l+2*s)/2,-L-s-40,h]){
            cube([l+2*s,L+2*s,90]);
            linear_extrude(height=10, center = true, scale = [1.1,1.1])
                square([l+2*s,L+2*s]);
            linear_extrude(height=10, center = true, scale = [1.1,1.1])
                square([l+2*s,L+2*s]);
        }
    }
    translate([-l/2,-L-40,h]) cube([l,L,100]);
}
rotate([45,0,0])
difference(){
    union(){
        translate([0,0,-40]) cylinder(d = d+2*s, h = 40);
        translate([0,0,-40]) cylinder(d = d+3*s, h = 10);
    }
    translate([0,0,-40]) cylinder(d = d, h = 40);
 }
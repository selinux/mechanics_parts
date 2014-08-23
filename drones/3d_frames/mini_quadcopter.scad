entraxe = 88;
thickness = 1;
plate = 33;



difference(){
	cylinder(h=1, r=plate/2);
	translate([0,0,-2.5])
		cylinder(h=5, r= 8);
	for( i = [ 0:90:360 ]){
		rotate([0,0,i+45]){
			translate([-6,12-thickness,-3]){
				cube([12,2*thickness,10]);
			}
		}
	}
}

pattes = 5;

// les 4 pattes
for( i=[0:90:360]){
	rotate([0,0,i]){
		translate([plate/2-3,-pattes/2,0]){
			difference() {							// nervure dans les pattes
				cube([entraxe/2-(plate/2), pattes, thickness*2]);
				translate([2,thickness,thickness])
					cube([entraxe/2-23, pattes - 2*thickness, 3*thickness]);
			}
		}
		translate([entraxe/2,0,0]){					// le cone support moteurs
			difference() {
				cylinder(h=5, r1 = 5, r2= 4);
				translate([0,0,-thickness])
					cylinder(h=5+2*thickness, r = 3.5);
			}
		}
	}
}


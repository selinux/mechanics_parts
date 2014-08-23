entraxe = 88;
thickness = 1;
plate = 33;



difference() {
	cylinder(h=5, r1 = 5, r2= 4, $fn=50);
	translate([0,0,-thickness])
		cylinder(h=5+2*thickness, r = 3.5, $fn=50);
}


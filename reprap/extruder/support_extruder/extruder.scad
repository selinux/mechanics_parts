difference(){
	translate( [-22,-10,0] )
		cube(size=[64.5,40,10]);

	translate([0,0,3.8])
		cylinder(h=10, r=9, $fn=50);

	translate([0,0,-1])
		cylinder(h=20,r=6.1, $fn=50);

	translate([0,-10,-1])
		cube([12.2,20,25], center=true);

	translate([0,-10,8.8])
		cube([18.2,20,10], center=true);

	translate([34.5,0,-1])
		cylinder(h=20,r=1.5, $fn=50);

	translate([34.5,22,-1])
		cylinder(h=20,r=1.5, $fn=50);

	translate([-23,12,-5])
		cube([45,22,20], center=false);

	translate([-29.5,-20,-5])
		cube([17,20,20], center=false);

	translate([12.5,-20,-5])
		cube([7,20,20], center=false);
}

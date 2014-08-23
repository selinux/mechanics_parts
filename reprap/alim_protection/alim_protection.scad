EP = 2;

L = 98.6;
H = 50.3;
P_ext = 46;

L_in = L + .4;
H_in = H + .4;
P_in = 100;

L_ext = L_in + 2*EP;
H_ext = H_in + 2*EP;

difference(){
    translate([0,0,P_ext/2])
        cube([L_ext,H_ext,P_ext], center=true);

    translate([0,0,P_in/2 + EP])
        cube([L_in,H_in,P_in], center=true);

    translate([32.3,-12,0])
    cylinder(d=8, h=100, $fn=50, center=true);

	for( i = [ 	[-8,-12,0],
                [-17,-12,0],
            	[-27,-12,0] ]){

		translate(i)
                cylinder(d=6, h=100, $fn=50, center=true);
        
	}

    translate([0,13.5,P_ext-9])
        rotate([0,90,0])
            cylinder(d=3, h = 200, center=true, $fn=50);

    translate([0, -H_ext/2, 30/2+P_ext-15])
        cube([L-1.5*EP, 30, 30], center=true);

}


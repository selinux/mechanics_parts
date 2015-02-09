// mudflat support for a Cannondal Hooligan 2015 (mono fourche)
// Sebastien C.
//

sup_mudlfat();

thick = 20;

union($fn=50){

	// nervures
	translate([-6,-26.5,3]){
		rotate([0,-90,180]){
			linear_extrude(height = 5)
				polygon(points = [[0,0],[16,0], [0,62]]);
		}
	}
	// nervure
	translate([10,-26.5,3]){
		rotate([0,-90,180]){
			linear_extrude(height = 5)
				polygon(points = [[0,0],[16,0], [0,62]]);
		}
	}

	// pince
	linear_extrude(height = thick, $fn=50)
	                import("2d-sections/mud_flat_hooligan-2015_v1.dxf");
	// support
	linear_extrude(height = thick/3, $fn=50)
	                import("2d-sections/mud_flat_hooligan-2015-1_v1.dxf");

}
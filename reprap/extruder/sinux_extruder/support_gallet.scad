
include </usr/share/openscad/libraries/MCAD/bearing.scad>

//bearing(pos=[-mot_pos-11-thread_diam/2,0,thread_elev-7/2]);

thickness = 2.5;	// epaisseur piece
chamfer = 0.8;

//  Printer variables
//
thread_diam = 3;	// material diameter
wheel_diam = 10;		// dragging diameter
thread_elev = 7.5;   // thread position from motor

//  Motor variables
//
motor_l = 42.3;	// H/L motor
axes = 31;			// entre-axes screw
motor_d = 22;		// epaulement diam
motor_dh = 2;		// epaulement H
motor_w = 35;		//	each motor as a different width
screw_diam = 3;	// screw diameter

mot_pos = thread_diam/2 + wheel_diam/2;


//bearing(pos=[axes/2-mot_pos-11+1.5,-axes/2,1]);
//sup_gallet();

module sup_gallet(){

    sup_thick = 1;
    inside_height = 7+1;

    ep_h = 3;       // hauteur epaulement


    difference(){
        union(){
            linear_extrude(height = sup_thick)
                import("2d-sections/support_gallet_section2d-0.dxf");
            
            translate([0,0,inside_height+sup_thick*3]){
                linear_extrude(height = sup_thick)
                    import("2d-sections/support_gallet_section2d-2.dxf");
            }
        
        
            translate([0,0,sup_thick]){
                linear_extrude(height = sup_thick*2+inside_height)
                    import("2d-sections/support_gallet_section2d-1.dxf");
            }
            translate([0,0,-ep_h])
                cylinder(r = 4, h = ep_h, $fn=50 );
        }

        translate([0,0,-ep_h*2])
            cylinder(d = 2, h = 100, $fn=50 );
    }




}

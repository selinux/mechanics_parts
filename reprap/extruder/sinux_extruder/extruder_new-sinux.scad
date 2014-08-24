include <MCAD/motors.scad>
include <MCAD/bearing.scad>
include <MCAD/nuts_and_bolts.scad>
include <ruler/ruler.scad>
include <write/Write.scad>
include <support_gallet.scad>
//  Part variables
//
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

translate([-35,-60,0])
    ruler(lenght = 20, t=[5,0,0], r=[0,90,-90]);
translate([-35,-45,0])
    write("by sinux @",h=6,t=3);
translate([-35,-52,0])
    write("Post Tenebras Lab",h=5,t=3);

color("Purple", 1.0){
    translate([-axes/2,-axes/2,1.5])
        rotate([0,0,189])
            sup_gallet();
}


support();
extruder();

translate([0,0,thread_elev])
    gallet();

//color("Blue", 1.0)
//    translate([0,0,-thickness*3])
//        rotate([0,0,90])
//            stepper_motor_mount(17, 3); 
translate([0,0,-thickness])
    motor();

bearing(pos=[-mot_pos-11-thread_diam/2,0,thread_elev-7/2]);
//=============================
// support motor
//=============================
module support(){
	
    // local variables
    h_cube = 7;
    a = thread_diam+2*thickness;


	difference(){
        union(){

        // base support
        // -------------
            translate([-3.5,0,-thickness/2])
        		cube([motor_l+5+7,motor_l, thickness], center=true);

        // extruder support
        // -----------------
            translate([-3.5,motor_l/2+thickness/2,10-thickness])
                cube([motor_l+12,thickness,20], center=true);
            
        // thread guide (part of support)
        // -------------------------------
           	translate([-mot_pos,motor_l/2,thread_elev]){
            	rotate([90,0,0]){
            		difference(){
            			union(){
            				cylinder(d=a, h= motor_l, $fn=50);
            				translate([-a/2,-thread_elev,0])
            					cube([a, thread_elev, motor_l]);
            			}
            			cylinder(d=thread_diam, h=motor_l*4, center=true, $fn=50);
                        translate([0,0,motor_l/4])
                            cube([motor_d,motor_d, motor_d*2], center=true );
            		}
            
                }
            }

        // screw support
        // --------------
            translate([-24,17,thread_elev]){
                rotate([12,-90,0]){
                    translate(0,0,h_cube/2){
                        difference(){
                            cube([10,11,h_cube], center=true);
                            translate([0,0,-h_cube/2-1])
                                cylinder(r=3.2, h=h_cube/2+1, $fn = 6);  // tips = 6 pans
                            cylinder(r=1.5,h=h_cube*4, $fn=50);
                        }
                    }
                }
            }
        }

        // motor hole with clearance
        // ---------------------------
        translate([-1.5,0,0])
        	cylinder(d=motor_d+1, h=thickness*50, center=true, $fn=100);
        translate([1.5,0,0])
        	cylinder(d=motor_d+1, h=thickness*50, center=true, $fn=100);
        	cube([3,motor_d+1,thickness*2], center=true);


        translate([-mot_pos,motor_l/2,thread_elev+thickness/2])
        rotate([-90,0,0]){
            union(){
                cylinder(d=20, h=6, center=true);
                translate([0,-10,0])
                    cube([20,20,6], center=true);
            }
        }

        // motor's screw with clearence (3mm)
        // -----------------------------------
		for( i = [ 	[axes/2,axes/2,-thickness],
					[-axes/2,axes/2,-thickness],
					[axes/2,-axes/2,-thickness],
					[-axes/2,-axes/2,-thickness] ])
        {
			translate(i){
                union(){
                translate([1.5,0,0])
    				cylinder(d=screw_diam*1.1, h=thickness*20, center=true, $fn=50);
                translate([-1.5,0,0])
    				cylinder(d=screw_diam*1.1, h=thickness*20, center=true, $fn=50);
                cube([3,screw_diam*1.1,thickness*50], center=true);
                }
            }
		}

	}


}


// =========================
// extruder 
// =========================
module extruder(){

    translate([-mot_pos, motor_l/2+thickness+1,thread_elev]){
        rotate([90,0,0]){
            color( "Brown" , 1.0){
    
                rotate_extrude(convexity = 10, $fn = 50)
                    import("2d-sections/extruder_section2d.dxf");
            }
        }
    }

}


// =========================
// gallet
// =========================
module gallet(){


    color("YellowGreen", 1.0){
        rotate_extrude(convexity = 10, $fn = 50)
            import("2d-sections/gallet_section2d.dxf");

    }
}


// =========================
// motor
// =========================
module motor(){

    axe = 5;
    axe_l = 15;

    color("Blue", 1.0){

        union(){

        cylinder(d=motor_d, h=2, $fn=50);
        cylinder(d=axe, h=axe_l-chamfer, $fn=50);
        translate([0,0,axe_l-chamfer])
            cylinder(d1=axe, d2=axe-(2*chamfer), h=chamfer, $fn=50);

        translate([0,0,-motor_w])
            linear_extrude(height = motor_w)
                import("2d-sections/motor_section2d.dxf");

        }
    }
}

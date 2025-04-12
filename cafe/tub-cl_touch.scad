/* =====================================================================================
 *
 *       Filename:  tub-cl_touch.scad
 *
 *    Description:  tub for Cl Touch coffee machine
 *
 *        Version:  1.0
 *        Created:  17 04 2022
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Sebastien Chassot (sinux), seba.ptl@sinux.net
 *
 * =====================================================================================
 */


label = "sinux";

h_e = 100;
w_e = 153;
l_e = 160;


translate([0,0,h_e])rotate([180,0,0]) tub_cl();

module tub_cl(){

    difference(){
    
        h_b=4; th_b=4; r_b=7; r_e = 2;
        union(){
            /* base */
            translate([0,0,-h_b]){cube_d(h_b+h_e, w_e-th_b, l_e-th_b, r_b);};

            /* main shape */
            translate([0,0,0]){cube_d(h_e, w_e, l_e, r_e);}
        }
        
        /* inner through */
        th_t = 6; r_t = 6;
        translate([0,0,-5]){ cube_d(h_e*2, w_e-th_t, l_e-th_t, r_t);}
        /* inner up */
        th_u = 6; h_u = 3; r_u = 1;
        translate([0,0,h_u]){ cube_d(h_e, w_e-th_u, l_e-th_u, r_u);}
        
        /* notch */
        translate([-7,0,-h_b]){cube([6, l_e*2, 2*h_b], center=true);};
    
        rotate([90,0,180]){
            translate([0,h_e/2,l_e/2-1]){linear_extrude(2){text(label, size=15, halign="center", valign="center");};};
        }
    }
}

module cube_d(h0, w0, l0, r0, a0=1){
    translate([0, 0, h0/2]){
        linear_extrude(h0, center=true, scale=a0, $fn=100){
                minkowski(){
                    square([w0-2*r0, l0-2*r0], center = true);
                    circle(r=r0, $fn=1000);
                }
        }
    }
}

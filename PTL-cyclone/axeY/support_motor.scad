/* ======================================================================
 *
 *       Filename:  motor_support.scad
 *
 *    Description:  motors mount 
 *
 *        Version:  1.0
 *        Created:  11 06 2016
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Sebastien Chassot (sinux), seba.ptl@sinux.net
 *
 * =====================================================================
 */


include <../libs/MCAD/motors.scad>

support_h = 4;

//support_motorY();


module support_motorY() {
    
    difference(){
        
        /* motor mount */
        linear_extrude(height = support_h, $fn=50)
                import("../profiles/support_motorY-s0.dxf");
        /* motor holes */
        linear_extrude(height = 2*support_h, $fn=50)
            rotate([0, 0, 90])
                stepper_motor_mount(17,slide_distance=3, mochup=true, tolerance=0);
    }
}

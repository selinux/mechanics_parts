/* =====================================================================================
 *
 *       Filename:  support_axe12.scad
 *
 *    Description:  eccentric support for Ø12 axes
 *                   
 *                  eccentric adjustment (rotation) for Y axe mounted on
 *                  20x20 type 5 profile
 * 
 *        Version:  1.0
 *        Created:  07 06 2016
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Sebastien Chassot (sinux), seba.ptl@sinux.net
 *
 * =====================================================================================
 */


axe_dia = 12;
ext_dia = 18;
length = 15;
support_depth = 5;

resolution = 100;

difference() {
    union(){
        linear_extrude(height=support_depth, scale = 0.97, $fn=resolution)
                            import("section_0.dxf");
        
        cylinder(d = ext_dia, h = length, $fn = resolution/2);
    }
                            
    linear_extrude(height=support_depth*3, center =true, $fn = resolution/2)
                            import("section_1.dxf");        

    cylinder(d = axe_dia, h = length*2.5, center =true, $fn = resolution/2);
}

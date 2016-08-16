/* ====================================================================
 *
 *       Filename:  angle_top.scad
 *
 *    Description:  Ø 8 axe support
 *
 *        Version:  1.0
 *        Created:  02 08 2016
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Sebastien Chassot (sinux), seba.ptl@sinux.net
 *
 * ====================================================================
 */


feet_dia = 4.4;
screw_dia = 5.3;
high = 20;

angle=43;

angle_top();

module angle_top() {

    /* Body */
    difference() {
        /* outside */
        union() {
            linear_extrude(height=high, center = true, $fn = 80)
                import("../profiles/angle_top-s0.dxf");
            
            rotate([0,90,0])
                translate([0, 10, 0])
                    linear_extrude(height = 4, $fn=50)
                        import("../profiles/profile_20x20_negatif.dxf");
        
            rotate([0,90,-(90+angle)])
                translate([0, -11.7, 31])
                    linear_extrude(height = 4, $fn=50)
                        import("../profiles/profile_20x20_3_negatif.dxf");
            
        }
        
        rotate([0,0,angle+180])
            translate([15, -7, -2.75])
                cube([40, 20, 5.5], center=false);

        translate([-28, 5, -5])
            cube([20, 20, 10], center=false);
        
        translate([0,10,0])
            rotate([0,-90,0])
                cylinder(d=5.3, h=50, center=true, $fn=80);        

       }

}
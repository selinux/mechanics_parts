/* ======================================================================
 *
 *       Filename:  axeX_bottom.scad
 *
 *    Description:  bottom support for X axe screw and bearing
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

bottom_axeX();

/* body X extrude */
module bottom_axeX() {
    
            difference(){
                /* body X extrude */
                intersection() {
                    rotate([90, 0, 0])
                        linear_extrude(height = 100, center = true, $fn=50)
                                import("../profiles/axeX_bottom-s0.dxf");
        
                linear_extrude(height = 200, center = true, $fn=50)
                        import("../profiles/axeX_bottom-s2.dxf");
            }
        
            intersection() {
                rotate([90, 0, 0])
                    linear_extrude(height = 100, center = true, $fn=50)
                            import("../profiles/axeX_bottom-s1.dxf");
        
                linear_extrude(height = 200, center = true, $fn=50)
                        import("../profiles/axeX_bottom-s3.dxf");
            }
    
            /* hole axe Z */
            translate([-26, 38, 0])
                cylinder(d = 7.5, center = true, h=50);
            translate([-26, -38, 0])
                cylinder(d = 7.5, center = true, h=50);
            /* bottom hole */
            translate([24, 0, 0])
                rotate([0,15,0])
                cylinder(d = 20, h = 70, center = true, $fn = 50);

        }
}

/* =====================================================================================
 *
 *       Filename:  helix_1700MHz.scad
 *
 *    Description:  Support for a 1700MHz helix antenna
 *
 *        Version:  1.0
 *        Created:  25 07 2017
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Sebastien Chassot (sinux), seba.ptl@sinux.net
 *        Company:  HES-SO hepia section ITI (soir)
 *
 * =====================================================================================
 */
include <Write.scad>


d_antenna = 66;     // helix diameter
d_wire = 2;         // hole diameter (>wire)
STEP = 45;          // helix step
REVOLUTION = 4;     // nb of helix revolution
thickness = 2;      // case thickness
NB_OF_SUPPORT = 4;
HOLES_OFFSET=10;

note = "NOAA 1.7GHz";


support(nb=NB_OF_SUPPORT, ho=HOLES_OFFSET, st=STEP, rev=REVOLUTION);



module support(nb=3, ho=20, st=45, rev=3){   
    s = STEP/nb;    // 
    x_pos = -8;
    y_pos = 10;
    
    for( n = [0:nb-1])
        translate([n*x_pos, n*y_pos])
            helix_support(y_offset=n*s+ho, step=st, revolution=rev);
}

module helix_support(y_offset=15, step=45, revolution=3){

    width = 10;
    base = 6;
    d_int = d_antenna+d_wire/2-width/2;
    d_ext = d_antenna-d_wire/2+width/2;
    h = y_offset+(step*(revolution-1))+d_wire/2+base;
    shape = [[1, 0], [1, base], [d_int/2, base], [d_int/2, h], [d_ext/2,h], [d_ext/2, 0]];

    difference(){
        union(){
            linear_extrude(thickness)
                polygon(shape);
            translate([1,0,thickness/2])
                cube([(d_ext/2)-1,1,5]);
        }
        translate([d_antenna/2, y_offset, -1])
            for ( a=[0:revolution-1] ){
                translate([0,a*step])
                cylinder(d=d_wire, h=2*thickness, center=false, $fn=50);
            }
        translate([5, 1.5, thickness/2]){
            write(note, h=3, t=thickness*2);
        }
   }
}
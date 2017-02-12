/* ======================================================================
 *
 *       Filename:  case_cover.scad
 *
 *    Description:  case for Arduino Uno with lora transmitter shield
 *
 *        Version:  1.0
 *        Created:  12 03 2017
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Sebastien Chassot, sebastien.chassot@@etu.hesge.ch
 *
 * =====================================================================
 */


use <case_main.scad>
use <case_cover.scad>

translate([0, 0, 32])
rotate([0,0,0])
    color([0,1,0]) case_cover();

color([0,0,1]) case_main();
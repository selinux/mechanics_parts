/* =====================================================================================
 *
 *       Filename:  case.scad
 *
 *    Description:  Top case for an USRP B200 (sdr card)
 *
 *        Version:  1.0
 *        Created:  02 06 2015
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Sebastien Chassot (sinux), sebastien.chassot@etu.hesge.ch
 *        Company:  HES-SO hepia section ITI (soir)
 *
 * =====================================================================================
 */

include <top_case.scad>
include <bottom_case.scad>

top_case();
bottom_case();
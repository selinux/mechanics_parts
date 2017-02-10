( Made using CamBam - http://www.cambam.co.uk )
( vacuum table20x20 9/15/2016 4:37:54 PM )
( T0 : 6.0 )
G21 G90 G64 G40
G0 Z50.0
( T0 : 6.0 )
T0 M6
( vacuum_contour )
G17
M3 S8000
G0 X-90.0 Y-70.0
G0 Z1.0
G1 F300.0 Z-3.5
G1 F800.0 X90.0
G1 Y70.0
G1 X-90.0
G1 Y-70.0
G1 F300.0 Z-7.0
G1 F800.0 X90.0
G1 Y70.0
G1 X-90.0
G1 Y-70.0
G1 F300.0 Z-10.0
G1 F800.0 X90.0
G1 Y70.0
G1 X-90.0
G1 Y-70.0
G0 Z50.0
M5
M30

include <BOSL2/std.scad>
include <BOSL2/gears.scad>

pinDiameter = 2.5;

crownOuterDiameter = 16;
crownFaceWidth = 1.5;
crownInnerDiameter = crownOuterDiameter - 2 * crownFaceWidth;
numberOfCrownTeeth = 30;
crownMod = crownInnerDiameter / numberOfCrownTeeth;

spurDiameter = 5.4;
numberOfSpurTeeth = 10;
spurMod = spurDiameter / numberOfSpurTeeth;

module compoundGear() {
crown_gear(mod=crownMod, teeth=numberOfCrownTeeth, backing=2.5, face_width=crownFaceWidth, pressure_angle=15);
translate([0,0,-4.4])
    spur_gear(mod=spurMod, teeth=numberOfSpurTeeth, thickness=3, pressure_angle=14.5,anchor=CENTER,profile_shift=0);
}

$fn = 50;
rotate([0,180,0])
    difference() {
        compoundGear();
        cylinder(h=20,d=pinDiameter,center=true);
    }


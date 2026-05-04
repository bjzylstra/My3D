include <BOSL2/std.scad>
include <BOSL2/gears.scad>

$fn = 50;

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
    // Rev A used backlash = 0, backing 2.5, spur thickness 3
    crown_gear(mod=crownMod, teeth=numberOfCrownTeeth,
        backing=2, face_width=crownFaceWidth,
        pressure_angle=15, backlash = 0.1);
    translate([0,0,-4.2])
        spur_gear(mod=spurMod, teeth=numberOfSpurTeeth, thickness=3.5, pressure_angle=14.5,anchor=CENTER,profile_shift=0);
}

module gear() {
    difference() {
        compoundGear();
        cylinder(h=20,d=pinDiameter,center=true);
    }
}

//translate([50,0,6])
//    gear();

batteryDoorThickness = 3;
batteryDoorLength = 41.5;
batteryDoorWidth = 16.5;

ribLength = 27.6;
ribWidth = 1.4;
ribThickness = 1.8;

module rib() {
    translate([0,0,ribThickness/2])
        cube([ribWidth,ribLength,ribThickness],center = true);
}

tabLength = 4;
tabWidth = 2.9;
tabThickness = 1.2;

module tab() {
    translate([0,0,tabThickness/2])
        cube([tabWidth,tabLength,tabThickness],center = true);
}

clipWidth = 12.4;
clipEndWidth = 8.5;
clipThickness = 1.5;
screwHoleDiameter = 2.5;
screwHeadDiameter = 4;

module clip() {
    rotate([-90,0,270]) {
        linear_extrude(clipWidth) {
            path = turtle(["turn", 90, "move", 1, "arcright", 3, 90,
                "move", 2, "arcright", 3, 95,
                "move", 6, "arcleft", 1.5, 180,
                "move", 6, "xmove", 6.5]);
            stroke(closed = false, path, 
                width = clipThickness);
        }
    }
    translate([batteryDoorWidth/2,-15,-clipThickness])
        cylinder(h=2*clipThickness,
            d1 = 2*screwHeadDiameter,
            d2 = 2*screwHoleDiameter);
}

module trimmedClip() {
    difference() {
        clip();
        translate([batteryDoorWidth/2, -15, -5])
            cylinder(h = 10, d = screwHoleDiameter);
        translate([batteryDoorWidth/2, -15, -5])
            cylinder(h = 6, 
                d = screwHeadDiameter);
        translate([-0.1, -26, -5])
            cube([4,20,20]);
    }
}

trackPinDiameter = 4;
trackPinOffset = 3;

module trackPin(trackPinDepth) {
    translate([trackPinOffset,0,-(trackPinDepth-batteryDoorThickness)])
            cylinder(h = trackPinDepth, 
                d = trackPinDiameter);
    translate([
        -trackPinOffset,-trackPinDiameter/2,0])
        cube([2*trackPinOffset, trackPinDiameter,  batteryDoorThickness]);
}

ribSideOffset = 1.6;
ribBackOffset = 8.8;
tabSideOffset = 1.2;
tabBackOffset = -2.2;

module batteryDoor() {
    translate([0,0,batteryDoorThickness/2])
        cube([batteryDoorWidth,batteryDoorLength,
            batteryDoorThickness], center = true);
    translate([(batteryDoorWidth-ribWidth)/2 - ribSideOffset,
        (batteryDoorLength-ribLength)/2 - ribBackOffset,
        batteryDoorThickness])
        rib();
    translate([-(batteryDoorWidth-ribWidth)/2 + ribSideOffset,
        (batteryDoorLength-ribLength)/2 - ribBackOffset,
        batteryDoorThickness])
        rib();
    translate([(batteryDoorWidth-tabWidth)/2 - tabSideOffset,
        (batteryDoorLength-tabLength)/2 - tabBackOffset,
        batteryDoorThickness])
        tab();
    translate([-(batteryDoorWidth-tabWidth)/2 + tabSideOffset,
        (batteryDoorLength-tabLength)/2 - tabBackOffset,
        batteryDoorThickness])
        tab();
    translate([-batteryDoorWidth/2,-(batteryDoorLength/2-0.75),batteryDoorThickness])
        trimmedClip();
    translate([batteryDoorWidth/2,3*batteryDoorLength/8,-1])
        trackPin(14);
    translate([batteryDoorWidth/2,-3*batteryDoorLength/8,-1.9])
        trackPin(12);
}

batteryDoor();

$fa = 5;

holeDiameter = 14;
holeDepth = 9.5;
boltDiameter = 6.5;
bolTHeadDiameter = 11.5;
lowerFlangeDiameter = 24;
lowerFlangeThickness = 2.5;
topmostFlangeDiameter = 27.4;
topmostFlangeThickness = 2.5;
topInnerFlangeDiameter = 24;
topInnerFlangeThickness = 3.9;
upperBoltOffset = (145 - 140)/2;

module lowerFlange() {
    // Working from center to get them all concentric
    // but then each needs to get moved up to compensate for
    // z direction centering.
    difference() {
        union() {
            translate([0,0,lowerFlangeThickness/2])
                cylinder(h = lowerFlangeThickness,
                    d = lowerFlangeDiameter, center = true);
            translate([0,0,lowerFlangeThickness+holeDepth/4-0.1])
                cylinder(h = holeDepth/2, 
                    d = holeDiameter, center = true);
        }
        translate([0, 0, (lowerFlangeThickness + holeDepth/2)/2])
            cylinder(h = lowerFlangeThickness + holeDepth/2 + 0.1,
                d = boltDiameter, center = true);
    }
}

module upperFlange() {
    // Building it upside down
    difference() {
        union() {
            translate([0,0,topmostFlangeThickness/2])
                cylinder(h = topmostFlangeThickness,
                    d = topmostFlangeDiameter, center = true);
            translate([0,0,topmostFlangeThickness+topInnerFlangeThickness/2])
                cylinder(h = topInnerFlangeThickness,
                    d = topInnerFlangeDiameter, center = true);
            translate([upperBoltOffset,0,
                topmostFlangeThickness+topInnerFlangeThickness+
                holeDepth/4])
                cylinder(h = holeDepth/2,
                    d = holeDiameter, center = true);
        }
        translate([upperBoltOffset, 0, 
            (topmostFlangeThickness+topInnerFlangeThickness+
                holeDepth/2)/2])
            cylinder(h = topmostFlangeThickness+topInnerFlangeThickness+
                holeDepth/2 + 0.1,
                d = boltDiameter, center = true);
    }
}

upperFlange();

translate([30, 0, 0])
    lowerFlange();
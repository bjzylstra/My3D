thickness = 2.2;
openingWidth = 62;
openingLength = 207;
ridgeWidth = 7;
screwDiameter = 4.5;

module base () {
    outerWidth = openingWidth + 27;
    outerLength = openingLength/2 - openingWidth/2;
    outerThickness = thickness + 2;
    cylinder(h = outerThickness, r = outerWidth/2);
    translate([0, -outerWidth/2, 0])
        cube([outerLength, outerWidth, outerThickness]);
}

module chamfer() {
    chamferWidth = openingWidth + ridgeWidth;
    chamferLength = openingLength;
    chamferThickness = thickness + 0.1;
    cylinder(h = chamferThickness, r = chamferWidth/2);
    translate([0, -chamferWidth/2, 0])
        cube([chamferLength, chamferWidth, chamferThickness]);
    
}

module hole() {
    holeWidth = openingWidth;
    holeLength = openingLength;
    holeThickness = thickness + 5;
    cylinder(h = holeThickness, r = holeWidth/2);
    translate([0, -holeWidth/2, 0])
        cube([holeLength, holeWidth, holeThickness]);
}

module screwHole(x,y) {
    translate([x,y,-0.1])
        cylinder(h = 5, r = screwDiameter / 2);
}

module collar() {
    difference() {
        base();
        translate([0, 0, -0.1])
            chamfer();
        translate([0, 0, -0.1])
            hole();
        for (angle = [-60:30:60]) {
            radius = openingWidth/2 + 8;
            screwHole(-radius*cos(angle), -radius*sin(angle));
        }
        for (x = [0:20:60]) {
            screwHole(x, -(openingWidth/2 + 8));
            screwHole(x, (openingWidth/2 + 8));
        }
    }
}

translate([0, 0, thickness + 2])
    rotate([180, 0, 0])
        collar();
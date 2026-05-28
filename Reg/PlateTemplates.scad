include <BOSL2/std.scad>
include <BOSL2/joiners.scad>

module pinInches(boltWidthInches, boltLengthInches,
    xInches, yInches) {
    pinMetric(boltWidthInches * 25.4, 
        boltLengthInches * 25.4,
        xInches * 25.4,
        yInches * 25.4);
}

module pinMetric(boltWidth, boltLength, x, y) {
    // Use the top of a snap pin for the pin.
    translate([x,y,0])
        difference() {
            snap_pin("tiny", anchor=CENTER, orient=UP, 
                thickness = 1.5, $fn=40, pointed = false, 
                diameter = boltWidth, length = boltLength*2,
                snap = 0.5);
            translate([0,0,-boltLength])
                cylinder(h = boltLength*2, 
                    d=2*boltWidth, center = true);
        };
}

module plateInches(xInches, yInches, overhangInches, thicknessInches) {
    plateMetric(xInches * 25.4,
        yInches * 25.4,
        overhangInches * 25.4,
        thicknessInches * 25.4);
}

// Plate is anchored on the bottom left pin.
// xSize, ySize, is the distance to the farthest hole in mm
// overhang is how much to extend the size of the plate past
// the centers of the limit holes.
module plateMetric(xSize, ySize, overhang, thickness) {
    translate([-overhang, -overhang, 0])
        cube([xSize + 2 * overhang,
            ySize + 2 * overhang,
            thickness]);
}

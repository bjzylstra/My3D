include <PlateTemplates.scad>

overhangInches = 3/8;
thicknessInches = 3/16;
xBoltCentersInches = 3.146 + 3.146;
yBoltCentersInches = 2.933;
boltWidthInches = 3/8;
boltLengthInches = 1/2 + thicknessInches;

// Plate is anchored on the bottom left pin at 0,0.
// xBoltCenters, yBoltCenters is the distance to 
// the farthest hole. The overhang is how much to extend
// the size of the plate past the centers of the limit holes
// on all sides of the plate.
plateInches(xBoltCentersInches, yBoltCentersInches, overhangInches, thicknessInches);
pinInches(boltWidthInches, boltLengthInches, 0, 0);
pinInches(boltWidthInches, boltLengthInches, 3.146, 0);
pinInches(boltWidthInches, boltLengthInches, 3.146 + 3.146, 0);
pinInches(boltWidthInches, boltLengthInches, 0, 2.933);
pinInches(boltWidthInches, boltLengthInches, 3.146, 2.933);
pinInches(boltWidthInches, boltLengthInches, 3.146 + 3.146, 2.933);
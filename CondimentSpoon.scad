$fn = 10;
rimThickness = 4 + 2; // Add 2x of the offset
gap = 3.8;
spoonInnerLength = 100;
scoopWidth = 40;
scoopLength = 60;
scoopDepth = 10;
wallThickness = 2.5;
handleWidth = 10;
// Handle goes half through the scoop.
handleLength = spoonInnerLength + wallThickness - scoopLength/2;
hookLength = 10;

module handle() {
    // Remove the 2x offset from the wall thickness
    adjWallThickness = wallThickness - 2;
    translate([wallThickness/2-0.25,0,0])
        linear_extrude(height = handleWidth, center = true)
            offset(r = 1)
                polygon([[0,0],
                    [0,handleLength],
                    [2*adjWallThickness+rimThickness,handleLength],
                    [2*adjWallThickness+rimThickness,handleLength-hookLength],
                    [adjWallThickness+rimThickness,handleLength-hookLength],
                    [adjWallThickness+rimThickness,handleLength-adjWallThickness],
                    [adjWallThickness,handleLength-adjWallThickness],
                    [adjWallThickness,0]
                    ]);
}

module spoon() {
    difference() {
        union() {
            rotate([0,-90,0])
                handle();
            scale([scoopWidth/scoopLength,1,
                2*scoopDepth/scoopLength])
                sphere(d = scoopLength);
        }
        translate([0,0,-scoopLength/2])
            cube([scoopLength,scoopLength,scoopLength],
                center = true);
        scale([scoopWidth/scoopLength,1,
            2*scoopDepth/scoopLength])
            sphere(d = scoopLength-2*wallThickness);
    }
}

spoon();

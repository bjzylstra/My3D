wallThickness = 2;
flangeWidth = 14;
depth = 72;
upperDiameter = 111;
extensionLength = 39;
bottomSetback = 14;

module upperOutline(outerDiameter, innerDiameter) {
    difference() {
        union() {
            circle(d = outerDiameter);
            translate([0,extensionLength/2,0])
                square([outerDiameter,extensionLength], center = true);
        }
        union() {
            circle(d = innerDiameter);
            translate([0,2*extensionLength/2,0])
                square([innerDiameter,2*extensionLength], center = true);
        }
    }
}

module flange() {
    difference() {
        translate([0,0,wallThickness/2])
            linear_extrude(height = wallThickness, center = true)
                upperOutline(upperDiameter + 2*flangeWidth,
                    upperDiameter - wallThickness);
        // Not clear to me why the translate is so fudgy
        translate([0, extensionLength+flangeWidth+5.5, wallThickness-0.1])
            cube([upperDiameter + 2*flangeWidth+0.1, extensionLength, wallThickness*2], center = true);
    }
}

ratio = (upperDiameter+bottomSetback)/upperDiameter;
translate([0,0,depth/2])
    linear_extrude(height = depth, center = true, 
        scale = ratio)
        upperOutline(upperDiameter,upperDiameter-2*wallThickness);
flange();
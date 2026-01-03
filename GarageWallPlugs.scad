$fn = 100;
overlap = 1;
wallThickness = 1.5;
inset = 15;
gap = 0.1;

module plug(diameter) {
    difference() {
        translate([0,0,(wallThickness + inset)/2])
        cylinder(h = wallThickness + inset, d = diameter, center = true);
        translate([0,0,wallThickness + (inset + gap)/2])
            cylinder(h = inset + gap, d = diameter - 2*wallThickness, center = true);
    }
    translate([0,0,overlap/2])
        cylinder(h = overlap, d = diameter + 2 * overlap,
            center = true);
}

//plug(76);
//translate([100, 0, 0])
//    plug(64);
translate([0, 100, 0])
    plug(64);
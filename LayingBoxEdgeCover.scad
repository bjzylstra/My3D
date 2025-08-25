rotate([90, 0, 0])
    difference() {
        cylinder(h = 230, r = 5);
        translate([-1.25, -5, -0.1])
            cube([2.5, 7.5, 235]);
        translate([-6, -8, -0.1])
            cube([12, 5, 235]);
    }
module switchOuter() {
    linear_extrude(23, scale=0.9) {
        hull() {
            translate([-(26.8-9)/2,0,0])
                circle(d = 9);
            translate([(26.8-9)/2,0,0])
                circle(d = 9);
        }
    }
}

module switchInner() {
    linear_extrude(15, scale=0.92) {
        square([24,2.5], center = true);
    }
}

module switchBody() {
    difference() {
        switchOuter();
        translate([0,0,-0.1]) {
            switchInner();
        }
    }
}

switchBody();
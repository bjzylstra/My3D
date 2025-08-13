module domeSegment2d(radius, endAngle) {
    points = [
        [0, radius * cos(endAngle)],
        for (angle = [0 : 1 : endAngle])
            [radius * sin(angle),radius * cos(angle)]
    ];
    polygon(points);
}
    
$fn = 60;
module cup(radius, endAngle) {
    rotate_extrude(angle = -180)
    difference() {
        domeSegment2d(radius, endAngle);
        domeSegment2d(radius-2, endAngle-3);
    }
}

module cupAssembly(radius, endAngle, armLength, armCross) {
    translate([-(radius * sin(endAngle) + armLength), 
        -armCross/2, 
        -radius * cos(endAngle)]) 
        difference() {
            union() {
                translate([0,armCross,0])
                    rotate_extrude(angle = -180)
                        domeSegment2d(radius, endAngle);
                translate([radius * sin(endAngle), 
                0, 
                radius * cos(endAngle)]) {
                    cube([armLength, armCross, armCross]);
                    // Need a bit of fill to connect to the arc
                    translate([-armCross/2, 0, 0])
                        cube([armLength, armCross, armCross/3]);
                }
            }
            translate([0,armCross+0.1,0])
                rotate_extrude(angle = -180)
                    domeSegment2d(radius-2, endAngle-3);
        }
}

module mount() {
    difference() {
        cylinder(20, 10, 12);
        translate([0, 0, 20-15])
            cylinder(15.1, 2.55, 2.6);
    }
    translate([0, 0, 19.9])
        difference() {
            cylinder(20, 12, 20);
            cylinder(20.1, 10, 18);
        }
}

radius = 20;
endAngle = 135;
armLength = 20;
armCross = 5;
union() {
    cupAssembly(radius, endAngle, armLength, armCross);
    rotate(a = 360/3, v = [0, 0, 1])
        cupAssembly(radius, endAngle, armLength, armCross);
    rotate(a = -360/3, v = [0, 0, 1])
        cupAssembly(radius, endAngle, armLength, armCross);
    mount();
}

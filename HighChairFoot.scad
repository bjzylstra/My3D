$fa = 5;
radius = 35;
angle = 72;
chord = 18;
tubeDiameter = 29.2;

module partSphere() {
    translate([0,0,chord-radius])
    difference() {
        sphere(radius);
        translate([0,0,-chord])
            cube(radius*2, center = true);
    }
}

difference() {
    partSphere();
    rotate([0,90-angle,0])
        cylinder(h=2*radius, d = tubeDiameter, center=true);
}

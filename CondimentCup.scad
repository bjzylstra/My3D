diameter = 74;
depth = 111;
wallThickness = 2;

difference() {
    translate([0,0,depth/2])
        cylinder(h = depth, d = diameter, center = true);
    translate([0,0,depth/2+wallThickness])
        cylinder(h = depth, d = diameter - 2 * wallThickness,
        center = true);
}
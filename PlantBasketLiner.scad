$fn = 50;
upperDiameter = 6.625 * 25.4;
lowerDiameter = 5.625 * 25.4;
height = 3.625 * 25.4;
wallThickness = 2.5;

difference() {
    translate([0,0,height/2])
        cylinder(h = height, d1 = lowerDiameter, 
            d2 = upperDiameter, center = true);
    translate([0,0,height/2+wallThickness])
        cylinder(h = height-wallThickness, 
            d1 = lowerDiameter - 2*wallThickness, 
            d2 = upperDiameter - 2*wallThickness, 
            center = true);
}
wallThickness=2;
cupLength = 25;
cupDiameter1 = 35;
cupDiameter2 = 33;
riser=175;
wallTopWidth=20;
wallTopFlange=30;
holeDiameter=3;

module cup() {
    difference() {
        cylinder(h=cupLength+wallThickness,
            d1=cupDiameter1 + 2 * wallThickness,
            d2=cupDiameter2 + 2 * wallThickness);
        translate([0,0,wallThickness])
            cylinder(h=cupLength+0.1,
                d1=cupDiameter1, d2 = cupDiameter2);
        translate([0, -(cupDiameter1/2 + wallThickness + 0.1), wallThickness])
            cube([cupDiameter1/2 + 2 * wallThickness + 0.1,
                  cupDiameter1 + 2 * wallThickness + 0.1,
                  cupLength + 0.1]);
    }
}

module assemblyBeforeHole() {
    union(){
        cup();
        translate([0,-(cupDiameter1 + 2*wallThickness)/2,0])
            cube([riser+wallThickness, 
                  cupDiameter1 + 2*wallThickness,
                  wallThickness]);
        translate([riser,
            -(cupDiameter1 + 2*wallThickness)/2,
            -(wallTopWidth + wallThickness)])
            cube([wallThickness, 
                cupDiameter1 + 2*wallThickness,
                wallTopWidth + 2*wallThickness]);
        translate([riser,
            -(cupDiameter1 + 2*wallThickness)/2,
            -(wallTopWidth + 2*wallThickness)])
            cube([wallTopFlange, 
                cupDiameter1 + 2*wallThickness,
                wallThickness]);
    }
}

module assembly() {
    $fn=20;
    difference(){
        assemblyBeforeHole();
        translate([riser+wallThickness+wallTopFlange/2,
            0,
            -(wallTopWidth + 2*wallThickness+0.1)])
            cylinder(h=2*wallThickness,d=holeDiameter);
    }
}

// Move into a printable position
translate([0,0,(cupDiameter1 + 2*wallThickness)/2])
    rotate([-90,0,0])
        assembly();

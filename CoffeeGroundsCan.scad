outerDiameter = 120;
outerHeight = 130;
wallThickness = 2 - 1;

rotate_extrude(angle=360)
    difference() {
        offset(1)
            polygon([[0,0],
                [outerDiameter/2,0],
                [outerDiameter/2,outerHeight],
                [outerDiameter/2 - wallThickness,outerHeight],
                [outerDiameter/2 - wallThickness,wallThickness],
                [0,wallThickness]
                ]);
        translate([-10/2,0,0])
            square([10,10],center = true);
    }

translate([outerDiameter,0,0])
    cube([outerDiameter-5,outerHeight+10,wallThickness]);
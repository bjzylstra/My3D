height = 30;
outerLength = 45;
outerHeight = 24*2;

module pipeOuterPolygonHalf() {
    linear_extrude(height)
        polygon([[0,0],
            [9,1],
            [17,2],
            [19,3],
            [21,5],
            [22,10],
            [outerHeight/2,37],
            [23,39],
            [19,42],
            [9,44],
            [0,outerLength]
            ]);
}

module halfPipe() {
    difference() {
        scale([1.1,1.1,1])
            translate([0,-25,0])
                pipeOuterPolygonHalf();
        scale([1,1,1.1])
            translate([-0.01,-25,-0.1])
                pipeOuterPolygonHalf();
    }
}

module pipeInnerPolygonHalf() {
    linear_extrude(height*2)
        polygon([[0,0],
            [9.2,1],
            [12,2],
            [13,3],
            [14.4,4],
            [15.7,5],
            [17,7.5],
            [17,18],
            [16.5,18.5],
            [16.3,20],
            [15.7,21],
            [15,22],
            [13.8,23],
            [10.8,24],
            [0,24]
            ]);
}

module pipePolygonFull() {
    union() {
        // Nudge to get rid of the line of mirror
        translate([-0.01,0,0])
            pipeInnerPolygonHalf();
        mirror([1,0,0])
            pipeInnerPolygonHalf();
    }
}

module pipeInner() {
    difference() {
        scale([0.85,0.85,1])
            pipePolygonFull();
        translate([0,2,5])
            scale([0.7,0.7,1.2])
                pipePolygonFull();
    }
}

module connector() {
    linear_extrude(height)
        polygon([[25,9],
            [55,9],
            [55,-9],
            [25,-9]
            ]);
}

flangeThickness = 2;
flangeWidth = 6;

module screwHole(holeDiameter) {
    rotate([0,90,0])
        cylinder(h = flangeThickness*2, d = holeDiameter);
}

module screwFlange() {
    translate([0,outerLength/2-1,0])
        difference() {
            cube([flangeThickness,flangeWidth,height]);
            translate([-0.2, flangeWidth/2, height*0.2])
                screwHole(1.2);
            translate([-0.2, flangeWidth/2, height*0.8])
                screwHole(2.2);
        }
}

module rightClip() {
    translate([65,-11,0])
        pipeInner();
    connector();
    halfPipe();
    screwFlange();
    mirror([0, 0, 1])
        translate([0,-outerLength-flangeWidth-3,-height])
            screwFlange();
}

module leftClip() {
    translate([65,11,0])
        rotate([0,0,180])
            pipeInner();
    mirror([0,1,0])
        connector();
    mirror([0,1,0])
        halfPipe();
    translate([0,5,0])
        screwFlange();
    mirror([0, 0, 1])
        translate([0,-outerLength-flangeWidth+2,-height])
            screwFlange();
}

translate([0, 100, 0])
    rightClip();

leftClip();
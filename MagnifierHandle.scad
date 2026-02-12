$fn =30;
existingHandleThickness = 37;
receiverWidth = 38;
holeDiameter = 3;
standDiameter = 11.5;
standDepth = 20;
wallWidth = 2.5;

module existingHalfContour() {
    polygon([[0,0],
        [7,1],
        [9.5,2],
        [12,3],
        [13,4],
        [14,5],
        [16.1,8],
        [16.5,10],
        [16.2,12],
        [15.7,15],
        [14.5,20],
        [13.5,25],
        [13,30],
        [12,35],
        [0,35]]);
}

module existingXY() {
    linear_extrude(height = existingHandleThickness, center=true)
        union() {
            existingHalfContour();
            mirror([1,0,0])
                existingHalfContour();
        }
}

module existingHalfZ() {
    radius = 60;
    translate([0,29,-40.5])
        sphere(r = radius);
}

module existingHandle() {
    intersection(){
        existingXY();
        existingHalfZ();
    }
}

module handleReceiver() {
    difference() {
        translate([0,15,7])
            cube([receiverWidth,35,30],center = true);
        existingHandle();
        // Hole for pin
        translate([0,holeDiameter/2 + 5, -5])
            rotate([0,90,0])
                cylinder(h = receiverWidth+1, 
                    d = holeDiameter, 
                    center = true);
    }
}

module standReceiver() {
    difference() {
        translate([0,0,(standDepth+wallWidth)/2])
            cube([standDiameter+2*wallWidth,
                  standDiameter+2*wallWidth,
                  standDepth+wallWidth],
                  center = true);
        translate([0,0,standDepth/2-0.1])
            cylinder(h = standDepth, d = standDiameter, center = true);
    }
}

module pin() {
    translate([0,0,(holeDiameter-0.5)/2])
        rotate([0,90,0])
            cylinder(h = receiverWidth+wallWidth, 
                d = holeDiameter-0.5, 
                center = true);
    translate([receiverWidth/2+wallWidth,0,(holeDiameter-0.5)/2])
        cube([holeDiameter-0.5,2*holeDiameter,holeDiameter-0.5], center = true);
}

translate([0,50,0])
    pin();

handleReceiver();
translate([0,-2.5,28])
    rotate([-90,0,0])
        standReceiver();

$fn =30;
existingHandleThickness = 37;

module existingHalfContour() {
    polygon([[0,0],
        [7,1],
        [9.5,2],
        [12,3],
        [13,4],
        [14,5],
        [16.3,8],
        [16.8,10],
        [16.5,12],
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

difference() {
    translate([0,15,5])
        cube([40,35,35],center = true);
    existingHandle();
}
$fn =30;
existingHandleThickness = 37;

module existingHalfContour() {
    polygon([[0,0],
        [7,1],
        [10,2],
        [12.5,3],
        [13.7,4],
        [14.8,5],
        [16.5,8],
        [17,10],
        [16.8,12],
        [16,15],
        [15,20],
        [14,25],
        [13.5,30],
        [13,35],
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
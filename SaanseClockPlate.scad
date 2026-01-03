$fa = 5;
plateThickness = 5;
offsetHeight = 5;
boltDiameter = 4;
plateExtension = 10;

module boltOuter() {
    translate([0,0, plateThickness+offsetHeight/2-0.1])
        cylinder(h = offsetHeight, d = 2 * boltDiameter, center = true);
}

module boltInner() {
    totalHeight = offsetHeight + plateThickness + 0.2;
    translate([0,0,totalHeight/2-0.1])
        cylinder(h = totalHeight, d = boltDiameter, center = true);
}

boltLocations = [[0,0],
    [75.7,1],
    [75.7-12.4,103.5],
    [20,100],
    [0,110],
    [75.7,110],
    [0,200],
    [75.7,200]];

module boltBar(index1, index2){
    translate([(boltLocations[index1][0]+boltLocations[index2][0])/2,
        (boltLocations[index1][1]+boltLocations[index2][1])/2,
        plateThickness/2])
    cube([abs(boltLocations[index1][0]-boltLocations[index2][0]) + 2* plateExtension,
            abs(boltLocations[index1][1]-boltLocations[index2][1]) + 2* plateExtension, plateThickness], center = true);
}

module plateBeforeHoles() {
    for(bolt = [1:len(boltLocations)]) {
        translate([boltLocations[bolt-1][0],
            boltLocations[bolt-1][1],0])
                boltOuter();
    }
    boltBar(0,3);
    boltBar(1,2);
    boltBar(2,3);
    boltBar(5,6);
}

module plate() {
    difference() {
        plateBeforeHoles();
        for(bolt = [1:len(boltLocations)]) {
            translate([boltLocations[bolt-1][0],
                boltLocations[bolt-1][1],0])
                    boltInner();
    }
        
    }
}
plate();
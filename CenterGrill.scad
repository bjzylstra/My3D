$fn =20;
clampLength = 300;
clampWidth = 20;
boltDiameter = 3;
boltOffset = clampLength/2 - 25.5;
threadHeight = 10;
wallThickness = 2.5;
gap = 0.5;
grilleLength = 320;
grilleWidth = 130;
grilleEdgeHeight = 2 * wallThickness + gap;
louvreWidth = 10;
louvreLength = grilleWidth-20;
sliderWidth = 5;
sliderLength = 20;
sliderHeight = 10;
damperWidth = grilleWidth-10;
damperLength = 240;

module clamp() {
    difference() {
        union() {
            translate([0,0,wallThickness/2])
                cube([clampWidth, clampLength, wallThickness], center = true);
            translate([0,boltOffset,threadHeight/2])
                cylinder(h=threadHeight,
                    d=boltDiameter+2*wallThickness, center=true);
            translate([0,-(boltOffset),threadHeight/2])
                cylinder(h=threadHeight,
                    d=boltDiameter+2*wallThickness, center=true);
        }
        translate([0,boltOffset,threadHeight/2-0.1])
            cylinder(h=threadHeight+0.3,
                d=boltDiameter, center=true);
        translate([0,-(boltOffset),threadHeight/2-0.1])
            cylinder(h=threadHeight+0.3,
                d=boltDiameter, center=true);
    }
}

module damper() {
    limit = ((damperLength/2)/louvreWidth)-1;
    difference() {
        translate([0,-louvreWidth/4,wallThickness/2])
            cube([damperWidth,damperLength-louvreWidth/2,wallThickness],
                center=true);
        for(index = [-limit : limit])
            louvreOpening(index);
    }
    // Add in the knob for the slider
    translate([0,0,sliderHeight/2])
        cube([sliderWidth,sliderLength,sliderHeight],
            center = true);
}

module edgeSegment(length) {
    rotate([90,0,0])
        linear_extrude(height = length)
            polygon([[0,0],
                [0,wallThickness+gap],
                [wallThickness,wallThickness+gap],
                [2*wallThickness,0]]);
}

module louvreOpening(index) {
    translate([0,index * louvreWidth,-gap])
        linear_extrude(height = wallThickness*2)
            hull() {
                translate([-(louvreLength-louvreWidth/2)/2,0,0])
                    circle(d = louvreWidth/2);
                translate([(louvreLength-louvreWidth/2)/2,0,0])
                    circle(d = louvreWidth/2);
            }
}

module grilleBeforeHoles() {
    union() {
        translate([0,0,wallThickness/2])
            cube([grilleWidth, grilleLength, wallThickness], center = true);
        translate([-grilleWidth/2,grilleLength/2,wallThickness])
            edgeSegment(grilleLength);
        rotate([0,0,90])
            translate([-grilleLength/2,grilleWidth/2,wallThickness])
                edgeSegment(grilleWidth);
        rotate([0,0,180])
            translate([-grilleWidth/2,grilleLength/2,wallThickness])
                edgeSegment(grilleLength);
        rotate([0,0,270])
            translate([-grilleLength/2,grilleWidth/2,wallThickness])
                edgeSegment(grilleWidth);
    }
}

module grilleWithLouvres() {
    limit = ((damperLength/2)/louvreWidth)-1;
    difference() {
        grilleBeforeHoles();
        for(index = [-limit : limit])
            louvreOpening(index);
        
    }
}

module boltHole() {
    boltHeadDiameter = 8.1;
    boltHeadHeight = 3;
    boltThickness = boltDiameter + 2;
    union() {
        translate([0,0,(2*wallThickness+0.3)/2])
            cylinder(h=2*wallThickness+0.3,
                d=boltThickness, center=true);
        // Adjust for countersink
        translate([0,0,boltHeadHeight/2])
            cylinder(h = boltHeadHeight, d1 = boltHeadDiameter, d2 = boltThickness, center = true);
    }
}

module grille() {
    difference() {
        union() {
            grilleWithLouvres();
            translate([0,0,wallThickness/2])
                cube([sliderWidth+2*wallThickness+gap,
                    louvreWidth+sliderLength+2*wallThickness+gap, wallThickness],
                    center = true);
            translate([0,boltOffset,wallThickness])
                cylinder(h=2*wallThickness,
                    d=boltDiameter+2*wallThickness, center=true);
            translate([0,-(boltOffset),wallThickness])
                cylinder(h=2*wallThickness,
                    d=boltDiameter+2*wallThickness, center=true);
        }
        translate([0,0,wallThickness/2])
            cube([sliderWidth+gap,
                louvreWidth+sliderLength+gap, 2*wallThickness+gap],
                center = true);
        translate([0,boltOffset,-0.1])
            boltHole();
        translate([0,-(boltOffset),-0.1])
            boltHole();
    }
    // Add a center support
    supportLength = (damperLength/2 - sliderLength);
    translate([0,(supportLength+sliderLength)/2 + 7,wallThickness/2])
        cube([louvreWidth,supportLength,wallThickness], center= true);
    translate([0,-((supportLength+sliderLength)/2 + 7),wallThickness/2])
        cube([louvreWidth,supportLength,wallThickness], center= true);
    
}

module stud(extra,xOffset) {
    translate([xOffset+extra/2,extra/2,
        (wallThickness/2+extra/2)])
            cube([wallThickness+extra, wallThickness+extra,
                wallThickness/2+extra], center=true);
}

module halfGrill() {
    difference(){
        grille();
        translate([-(grilleWidth+gap)/2,0,-gap/2])
            cube([grilleWidth+gap,grilleLength/2+gap,   
                grilleEdgeHeight+gap]);
        for(xOffset = [sliderWidth : louvreWidth : 
            grilleWidth/2 - louvreWidth])
                stud(gap/2,-xOffset);
    }
    for(xOffset = [sliderWidth : louvreWidth : 
        grilleWidth/2 - louvreWidth])
            stud(0,xOffset);
}

grille();
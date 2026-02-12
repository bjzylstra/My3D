$fa = 5;
maleDiameter= 27.1;
femaleDiameter = 26.7; // Increased by 0.1
wallWidth = 2;
bodyLength = 51.2;
totalLength = 66.7;
slotWidth = 2.5;
slotLength = 24;
// Actually rendered 16 as 15.4 which is too small
marbleWidth = 16.6;

module tube(outerDiameter, innerDiameter, height) {
        difference() {
            translate([0,0,height/2])
            cylinder(h = height, d = outerDiameter, center = true);
            translate([0,0,(height+0.1)/2])
            cylinder(h = height+0.2, d = innerDiameter, center = true);
        }
}

module marbleTube() {
    difference() {
        tube(femaleDiameter+wallWidth,maleDiameter-wallWidth,totalLength);
        translate([0,0,bodyLength])
            tube(maleDiameter+2*wallWidth,maleDiameter,totalLength-bodyLength+0.1);
        translate([0,0,-0.1])
            tube(femaleDiameter,0,totalLength-bodyLength+0.1);
        translate([0,maleDiameter/2,totalLength-slotLength/2])
            cube([slotWidth,maleDiameter,slotLength+0.1],center=true);
    }
}

module marbleBaseTube() {
    difference() {
        tube(femaleDiameter+wallWidth,maleDiameter-wallWidth,totalLength);
        translate([0,0,bodyLength])
            tube(maleDiameter+2*wallWidth,maleDiameter,totalLength-bodyLength+0.1);
        translate([0,maleDiameter/2,totalLength/2])
            cube([marbleWidth,maleDiameter,totalLength+0.1],center=true);
    }
}

rimThickness = 4;
rimHeight = 15;
catchRadius = 45;
rampHeight = 5;

module marbleBaseCatch() {
    rotate_extrude()
        difference() {
            offset(r=wallWidth/2)
                polygon([[0,0],
                        [catchRadius,0],
                        [catchRadius,rimHeight],
                        [catchRadius-rimThickness,rimHeight],
                        [catchRadius-rimThickness,wallWidth],
                        [0,wallWidth]]);
            // Trim off the offset along the axis
            polygon([[0,wallWidth+rimThickness],
                     [-wallWidth,wallWidth],
                     [-wallWidth,-wallWidth],
                     [0,-wallWidth]]);
        }
    // Put a ramp at the bottom to get the marbles out.
    difference() {
        translate([0,0,rampHeight/2+wallWidth])
            cylinder(h = rampHeight, d = femaleDiameter, center = true);
        rotate([-10,0,0])
            translate([0,0,5*wallWidth-0.4])
                cube([catchRadius,catchRadius,2*rampHeight],center = true);
    }
}

marbleBaseCatch();
marbleBaseTube();
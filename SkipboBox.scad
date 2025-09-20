deckHeight = 50;
deckLength = 90;
deckWidth = 59;
wallThickness = 1;
fingerHoleDiameter = 20;
gap = 0.3;

// Planning for 2 piles with a guide between
module box(delta) {
    cube([deckWidth*2+3*wallThickness + 2 * delta,
          deckLength+2*wallThickness + 2 * delta,
          deckHeight/2 + wallThickness]);
}

module deck() {
    cube([deckWidth,deckLength,deckHeight/2+0.1]);
}

module boxBottom() {
    difference() {
        box(0);
        translate([wallThickness,wallThickness,wallThickness])
            deck();
        translate([deckWidth + 2*wallThickness,
          wallThickness,wallThickness])
            deck();
        translate([deckWidth/2 + wallThickness,
          deckLength/2 + wallThickness, -0.1])
            cylinder(h = wallThickness + 0.2, 
                d = fingerHoleDiameter);
        translate([3/2 * deckWidth + 2 * wallThickness,
          deckLength/2 + wallThickness, -0.1])
            cylinder(h = wallThickness + 0.2, 
                d = fingerHoleDiameter);
    }
}

module boxTop() {
    difference() {
        box(wallThickness + 2 * gap);
        translate([wallThickness + gap, wallThickness + gap, -wallThickness])
            box(gap);
        translate([-0.1, 
          deckLength/2 + 2 * wallThickness + gap, 0])
            rotate([0, 90, 0])
                cylinder(h = deckWidth*2 + 5*wallThickness + 5 * gap, d = fingerHoleDiameter);
        translate([deckHeight + 2 * wallThickness + gap,
            deckWidth + wallThickness + gap,
            deckHeight/2 - gap - 0.1])
        linear_extrude(height = wallThickness + 2* gap)
            text("SKIP-BO", font = "Verdana:style=Bold",            halign= "center");
    }
}


translate([0, -10, 
  deckHeight/2 + wallThickness])
    rotate([180, 0, 0])
        boxTop();

boxBottom();

deckHeight = 20;
deckLength = 90;
deckWidth = 65;
wallThickness = 1;
fingerHoleDiameter = 20;
gap = 0.5;

// Planning for 2 by 2 piles with a guide between
module box(delta) {
    cube([deckWidth*2+3*wallThickness + 2 * delta,
          deckLength*2+3*wallThickness + 2 * delta,
          deckHeight + wallThickness]);
}

module deck() {
    cube([deckWidth,deckLength,deckHeight+0.1]);
}

module boxBottom() {
    difference() {
        box(0);
        translate([wallThickness,wallThickness,wallThickness])
            deck();
        translate([deckWidth + 2*wallThickness,
          wallThickness,wallThickness])
            deck();
        translate([wallThickness,
          deckLength + 2*wallThickness,wallThickness])
            deck();
        translate([deckWidth + 2*wallThickness,
          deckLength + 2*wallThickness,wallThickness])
            deck();
        translate([deckWidth/2 + wallThickness,
          deckLength/2 + wallThickness, -0.1])
            cylinder(h = wallThickness + 0.2, 
                d = fingerHoleDiameter);
        translate([3/2 * deckWidth + 2 * wallThickness,
          deckLength/2 + wallThickness, -0.1])
            cylinder(h = wallThickness + 0.2, 
                d = fingerHoleDiameter);
        translate([deckWidth/2 + wallThickness,
          3*deckLength/2 + 2*wallThickness, -0.1])
            cylinder(h = wallThickness + 0.2, 
                d = fingerHoleDiameter);
        translate([3/2 * deckWidth + 2 * wallThickness,
          3*deckLength/2 + 2*wallThickness, -0.1])
            cylinder(h = wallThickness + 0.2, 
                d = fingerHoleDiameter);
    }
}

module textTable(tableText,textHeight,tabSize,
    fontSize, useFont){
    for(line = [1:len(tableText)]) {
        translate([0,-textHeight*(line-1),0])
            text(tableText[line-1][0],
                size = fontSize, font = useFont,  
                halign= "left");
        translate([tabSize,-textHeight*(line-1),0])
            text(tableText[line-1][1],
                size = fontSize, font = useFont,  
                halign= "right");
    }
}

meldingText = [["Melding Points",""],
    ["<1500","50"],
    ["1500-2999","90"],
    ["3000-6999","120"],
    ["7000-11999","150"],
    ["12000-14999","175"],
    ["15000-17999","200"],
    ["18000+","220"]];

canastaPointsText = [["Points",""],
    ["Red Canasta","500"],
    ["Black Canasta","300"],
    ["7s Canasta","1500"],
    ["WildCanasta","2000"]];

cardPointsText = [["Card Values",""],
    ["Ace","20"],
    ["8 to King","10"],
    ["4 to 7","5"],
    ["2 (wild)","20"],
    ["Joker","50"],
    ["Red 3","100"],
    ["6 Red 3s","1000"]];

completionText = [["Completing a round (bonus 100)",""],
    ["  4 Red Canastas",""],
    ["  1 Black Canasta",""],
    ["  7s Canasta",""],
    ["  WildCanasta",""]];
    
module textBlock() {
    textHeight = 6;
    tabSize = 50;
    fontSize = 4;
    useFont = "Arial";
    textTable(meldingText,textHeight,tabSize,fontSize,useFont);
    translate([0,(len(meldingText)+1)*-textHeight,0])
        textTable(canastaPointsText,textHeight,tabSize,fontSize,useFont);
    translate([0,(len(meldingText)+1+len(canastaPointsText)+1)*-textHeight,0])
        textTable(cardPointsText,textHeight,tabSize,fontSize,useFont);
    translate([0,(len(meldingText)+1+len(canastaPointsText)+1+len(cardPointsText)+1)*-textHeight,0])
        textTable(completionText,textHeight,tabSize,fontSize,useFont);
}

module boxTop() {
    difference() {
        box(wallThickness + 2 * gap);
        translate([wallThickness + gap, wallThickness + gap, -wallThickness])
            box(gap);
        translate([-0.1, 
          deckLength + 2 * wallThickness + gap, 0])
            rotate([0, 90, 0])
                cylinder(h = deckWidth*2 + 5*wallThickness + 5 * gap, d = fingerHoleDiameter);
    }
    translate([wallThickness + 15 * gap,
        10 + wallThickness + gap,
        deckHeight - wallThickness - gap - 0.1])
        mirror([0,1,0])
            linear_extrude(height = wallThickness + 2* gap)
                textBlock();
}


translate([0, -10, 
  deckHeight + wallThickness])
    rotate([180, 0, 0])
        boxTop();

boxBottom();

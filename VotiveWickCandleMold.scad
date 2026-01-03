$fn = 60;
candleHeight = 60;
candleDiameter = 36;
wallWidth = 6;
wickWidth = 1.5;
cleatOffset = 3;
reduction = 0.90;
wickBaseThickness = 0.5;
wickBaseDiameter = 14.5;
gap = 0.4;

module candle(height, diameter) {
    cylinder(h = height, r = diameter/2);
    translate([0,0,height-wickBaseThickness/2])
        cylinder(h = wickBaseThickness, d = wickBaseDiameter);
}

module cleatReceiver(cleatOffset, reduction) {
linear_extrude(height = candleHeight/2, scale = reduction)
    polygon([[candleDiameter/2-cleatOffset,0],
             [candleDiameter/2-cleatOffset,cleatOffset],
             [candleDiameter/2,cleatOffset],
             [candleDiameter/2,cleatOffset*2],
             [-(candleDiameter/2),cleatOffset*2],
             [-(candleDiameter/2),cleatOffset],
             [-(candleDiameter/2-cleatOffset),cleatOffset],
             [-(candleDiameter/2-cleatOffset),0]]);
}

module cleat(cleatOffset, reduction, gap) {
linear_extrude(height = candleHeight/2, scale = reduction)
    polygon([[candleDiameter/2-cleatOffset+gap,gap],
             [candleDiameter/2-cleatOffset+gap,cleatOffset-gap],
             [candleDiameter/2+gap,cleatOffset-gap],
             [candleDiameter/2+gap,cleatOffset*2+gap],
             [-(candleDiameter/2+gap),cleatOffset*2+gap],
             [-(candleDiameter/2+gap),cleatOffset-gap],
             [-(candleDiameter/2-cleatOffset+gap),cleatOffset-gap],
             [-(candleDiameter/2-cleatOffset+gap),gap],
             [-(candleDiameter/2+cleatOffset),gap],
             [-(candleDiameter/2+cleatOffset),cleatOffset*3],
             [(candleDiameter/2+cleatOffset),cleatOffset*3],
             [(candleDiameter/2+cleatOffset),gap]
    ]);
}

module blockWithReceiver(candleDiameter,
                         candleHeight,
                         wallWidth,
                         cleatOffset,
                         reduction) {
    cube([candleDiameter + wallWidth*2, candleDiameter+wallWidth*2, candleHeight+wallWidth/2]);
    translate([candleDiameter/2 + wallWidth,
               candleDiameter+wallWidth*2, 
               candleHeight/3])
        cleatReceiver(cleatOffset, reduction);
    translate([candleDiameter/2 + wallWidth,
               0, 
               candleHeight/3])
        rotate([0,0,180])
            cleatReceiver(cleatOffset, reduction);
}

module halfMold(candleDiameter,
              candleHeight,
              wallWidth,
              wickWidth,
              cleatOffset,
              reduction) {
    studWidth = 2;
    studLength = 5;
    difference() {
        rotate([0,-90,0])
            blockWithReceiver(candleDiameter,
                              candleHeight,
                              wallWidth,
                              cleatOffset,
                              reduction);
        translate([-1.5*candleHeight, 
                   -cleatOffset*3, 
                   candleDiameter/2+wallWidth])
            cube([candleHeight*2, 
                  candleDiameter*4, candleDiameter *2]);
        translate([0.25, 
                   candleDiameter/2+wallWidth,
                   candleDiameter/2+wallWidth])
            rotate([0, -90, 0])
                candle(candleHeight, candleDiameter);
        // Lower stud hole
        translate([-(4/5*candleHeight),
                  candleDiameter+1.5*wallWidth-studWidth/2,
                  candleDiameter/2 + wallWidth-1.99])
            cube([5,studWidth,2.01]);
        // Upper stud hole
        translate([-(1/5*candleHeight),
                  candleDiameter+1.5*wallWidth-studWidth/2,
                  candleDiameter/2 + wallWidth-1.99])
            cube([5,studWidth,2.01]);
    }
    // Lower stud
    translate([-(4/5*candleHeight),
              (wallWidth-studWidth)/2,
              candleDiameter/2 + wallWidth])
        cube([studLength-gap,studWidth-gap,2-gap]);
    // Upper stud
    translate([-(1/5*candleHeight),
              (wallWidth-studWidth)/2,
              candleDiameter/2 + wallWidth])
        cube([studLength-gap,studWidth-gap,2-gap]);
    // Wick brace
    braceThickness = 2;
    translate([-braceThickness, 0, 
        (candleDiameter/2 + wallWidth - braceThickness)])
        difference() {
            cube([braceThickness,
                candleDiameter+2*wallWidth,
                braceThickness]);
            translate([-0.1, candleDiameter/2+wallWidth,
                braceThickness])
                rotate([0, 90, 0])
                    cylinder(braceThickness + 0.5, 
                        d = wickWidth);
        }
}

module holder(candleHeight, candleDiameter, cleatOffset, gap, wallWidth) {
    difference() {
        linear_extrude(height = candleHeight/2,
            scale=0.6)
            square([candleDiameter+2*(2*cleatOffset+wallWidth+2*gap) + candleHeight,
                candleDiameter+2*(wallWidth+2*gap)+candleHeight],
                center=true);
        translate([0,0, candleHeight/4+wallWidth/2])
            cube([candleDiameter+2*(2*cleatOffset+wallWidth+2*gap),
                candleDiameter+2*(wallWidth+2*gap),
                candleHeight/2], center=true);
    }
}

translate([1.5*candleHeight, -3*candleDiameter, 0])
    halfMold(candleDiameter,
                  candleHeight,
                  wallWidth,
                  wickWidth,
                  cleatOffset,
                  reduction);

translate([0, -3*candleDiameter, 0])
    halfMold(candleDiameter,
                  candleHeight,
                  wallWidth,
                  wickWidth,
                  cleatOffset,
                  reduction);

translate([0, 0, 3*cleatOffset])
    rotate([-90, -2.1, 0])
        rotate([0, -90, 0])
            cleat(cleatOffset, reduction, gap); 
            
translate([candleHeight, 0, 3*cleatOffset])
    rotate([-90, -2.1, 0])
        rotate([0, -90, 0])
            cleat(cleatOffset, reduction, gap); 
$fn = 60;

module taper(radius) {
    rotate_extrude()
        translate([radius+1,0,0])
            circle(radius);
}

module candle(height, diameter) {
    difference() {
        cylinder(h = height, r = diameter/2);
        translate([0,0, height])
            taper(10);
    }
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
                         wickHeight,
                         funnelHeight,
                         wallWidth,
                         cleatOffset,
                         reduction) {
    cube([candleDiameter + wallWidth*2, candleDiameter+wallWidth*2, candleHeight + wickHeight + funnelHeight]);
    translate([candleDiameter/2 + wallWidth,
               candleDiameter+wallWidth*2, 
               candleHeight/2])
        cleatReceiver(cleatOffset, reduction);
    translate([candleDiameter/2 + wallWidth,
               0, 
               candleHeight/2])
        rotate([0,0,180])
            cleatReceiver(cleatOffset, reduction);
}

module halfMold(candleDiameter,
              candleHeight,
              wickHeight,
              funnelHeight,
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
                              wickHeight,
                              funnelHeight,
                              wallWidth,
                              cleatOffset,
                              reduction);
        translate([-1.5*candleHeight, 
                   -cleatOffset*3, 
                   candleDiameter/2+wallWidth])
            cube([candleHeight*2, 
                  candleDiameter*4, candleDiameter *2]);
        translate([-funnelHeight, 
                   candleDiameter/2+wallWidth,
                   candleDiameter/2+wallWidth])
            rotate([0, -90, 0])
                candle(candleHeight, candleDiameter);
        // Wick opening
        translate([-funnelHeight-candleHeight+0.1, 
                   candleDiameter/2+wallWidth,
                   candleDiameter/2+wallWidth])
            rotate([0, -90, 0])
                cylinder(h = wickHeight+0.2, d = wickWidth);
        // Funnel
        translate([0.1, 
                   candleDiameter/2+wallWidth,
                   candleDiameter/2+wallWidth])
            rotate([0, -90, 0])
                cylinder(h = funnelHeight+0.2, 
                    d1 = candleDiameter + 1.5*wallWidth,
                    d2 = candleDiameter);
        // Lower stud hole
        translate([-(candleHeight+funnelHeight+wickHeight/2),
                  candleDiameter+1.5*wallWidth-studWidth/2,
                  candleDiameter/2 + wallWidth-1.99])
            cube([5,studWidth,2.01]);
        // Upper stud hole
        translate([-(funnelHeight+studLength),
                  candleDiameter+1.5*wallWidth-studWidth/2,
                  candleDiameter/2 + wallWidth-1.99])
            cube([5,studWidth,2.01]);
    }
    // Lower stud
    translate([-(candleHeight+funnelHeight+wickHeight/2),
              (wallWidth-studWidth)/2,
              candleDiameter/2 + wallWidth])
        cube([studLength-gap,studWidth-gap,2-gap]);
    // Upper stud
    translate([-(funnelHeight+studLength),
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

candleHeight = 102;
wickHeight = 10;
funnelHeight = 10;
candleDiameter = 11;
wallWidth = 6;
wickWidth = 1.5;
cleatOffset = 3;
reduction = 0.90;
gap = 0.2;


halfMold(candleDiameter,
              candleHeight,
              wickHeight,
              funnelHeight,
              wallWidth,
              wickWidth,
              cleatOffset,
              reduction);

translate([0, -4*candleDiameter, 0])
    halfMold(candleDiameter,
                  candleHeight,
                  wickHeight,
                  funnelHeight,
                  wallWidth,
                  wickWidth,
                  cleatOffset,
                  reduction);

translate([0, candleDiameter*4, 3*cleatOffset])
    rotate([-90, -1, 0])
        rotate([0, -90, 0])
            cleat(cleatOffset, reduction, gap); 
            
translate([-candleHeight*1, candleDiameter*4, 3*cleatOffset])
    rotate([-90, -1, 0])
        rotate([0, -90, 0])
            cleat(cleatOffset, reduction, gap); 
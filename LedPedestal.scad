pedestalHeight = 30;
pedestalDiameter = 26;
wireHoleDiameter = 4;
wireCenterDistance = 7;
spliceWireDiameter = wireHoleDiameter/2;
$fs = 0.5;

module pedestal() {
    translate([0,0,pedestalHeight/2])
        cylinder(h = pedestalHeight, d1= pedestalDiameter,
            d2 = wireCenterDistance, center = true);
}

module wireHole() {
    translate([0,0,pedestalHeight/2+0.5])
        cylinder(h = pedestalHeight + 1.5, 
            d = wireHoleDiameter, center = true);
}

module completePedestal() {
    difference() {
        pedestal();
        translate([wireCenterDistance/2,0,0]) {
            wireHole();
            rotate([90,0,0])
                wireHole();
        }
        translate([-wireCenterDistance/2,0,0]) {
            wireHole();
            rotate([90,0,0])
                wireHole();
        }
    }
}

switchHoleDiameter = 12.2;
switchPinOffset = 2.7;
switchPinDiameter = 3.2;
switchWidth = 17;
switchHeight = 24;
batteryBoxWidth = 50;
batteryBoxLength = 74;
wallWidth = 2;
boxWidth = 2*wallWidth + batteryBoxWidth + switchWidth + wireHoleDiameter;
boxLength = 2*wallWidth + batteryBoxLength + wireHoleDiameter;
screwHoleDiameter = 1.9;
screwReceiverHeight = wallWidth * 2;

module boxBottom() {
    difference() {
        translate([0,0,switchHeight/2])
            linear_extrude(switchHeight, center = true)
                offset(1)
                    square([boxWidth,boxLength], center=true);
        translate([0,0,switchHeight/2+wallWidth])
            cube([boxWidth-2*wallWidth,
                  boxLength-2*wallWidth,
                  switchHeight], center = true);
        translate([boxWidth/2-wallWidth/4,0,wallWidth])
            rotate([0,0,90])
                wireOpening();
    }
    // Add screw receivers
    receiverBaseHeight = switchHeight - screwReceiverHeight;
    translate([boxWidth/2-wallWidth-screwHoleDiameter,
        boxLength/2-wallWidth-screwHoleDiameter,
        receiverBaseHeight])
        screwReceiver();
    translate([boxWidth/2-wallWidth-screwHoleDiameter,
        -(boxLength/2-wallWidth-screwHoleDiameter),
        receiverBaseHeight])
        screwReceiver();
    translate([-(boxWidth/2-wallWidth-screwHoleDiameter),
        boxLength/2-wallWidth-screwHoleDiameter,
        receiverBaseHeight])
        screwReceiver();
    translate([-(boxWidth/2-wallWidth-screwHoleDiameter),
        -(boxLength/2-wallWidth-screwHoleDiameter),
        receiverBaseHeight])
        screwReceiver();
}

module switchHole() {
    translate([0,0,wallWidth/2])
        cylinder(h = wallWidth+1, d=switchHoleDiameter, center =true);
    translate([0,switchHoleDiameter/2+switchPinOffset,wallWidth/2])
        cylinder(h = wallWidth+1, d=switchPinDiameter, center =true);    
}

module screwOpening() {
    translate([0,0,wallWidth/2])
        cylinder(h=wallWidth+1,d1=screwHoleDiameter, 
            d2=screwHoleDiameter*2,center=true);
}

module screwReceiver() {
    difference() {
        translate([0,0,screwReceiverHeight/2])
            cube([wallWidth*2,wallWidth*2,
                screwReceiverHeight], center=true);
        translate([0,0,screwReceiverHeight/2])
            cylinder(h = screwReceiverHeight+0.2,
                d = screwHoleDiameter - 0.3,
                center = true);
    }
}

module wireOpening() {
    translate([0,0,spliceWireDiameter/2])
        rotate([90,0,0])
            linear_extrude(2*wallWidth,center = true)
                hull() {
                    translate([-spliceWireDiameter/2,0,0])
                        circle(d=spliceWireDiameter);
                    translate([spliceWireDiameter/2,0,0])
                        circle(d=spliceWireDiameter);
                }
}

module boxTop() {
    difference() {
        translate([0,0,wallWidth/2])
            linear_extrude(wallWidth, center = true)
                offset(1)
                    square([boxWidth,boxLength], center=true);
        translate([(boxWidth-switchWidth)/2-wallWidth,0,0])
            switchHole();
        translate([boxWidth/2-wallWidth-screwHoleDiameter,
            boxLength/2-wallWidth-screwHoleDiameter,0])
            screwOpening();
        translate([boxWidth/2-wallWidth-screwHoleDiameter,
            -(boxLength/2-wallWidth-screwHoleDiameter),0])
            screwOpening();
        translate([-(boxWidth/2-wallWidth-screwHoleDiameter),
            boxLength/2-wallWidth-screwHoleDiameter,0])
            screwOpening();
        translate([-(boxWidth/2-wallWidth-screwHoleDiameter),
            -(boxLength/2-wallWidth-screwHoleDiameter),0])
            screwOpening();
    }
    translate([boxWidth/2-wallWidth,-switchHoleDiameter,wallWidth])
        linear_extrude(1)
            text(text="ON", size=8, halign = "right", valign ="top");
    translate([boxWidth/2-wallWidth,switchHoleDiameter,wallWidth])
        linear_extrude(1)
            text(text="OFF", size=8, halign = "right", valign ="bottom");
}

boxBottom();
translate([boxWidth+20,0,0])
    boxTop();

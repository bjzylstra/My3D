thickness=2.5;

module windowOutline(){
    eps = 0.01;
    union() {
        cube([60,92.5,thickness], center = true);
        translate([0, 20, 0]) {
          difference() {
            cylinder(h = thickness, r = 40, center = true);
            translate([-60-eps, 0, 0]) {
              cube([60,60,5], center = true);
            }
            translate([60+eps, 0, 0]) {
              cube([60,60,5], center = true);
            }  
          } 
        }
    }
}

module windowCutout(x,y)
{
    translate([x, y, 0]) {
        cube([16,32,10], center = true);
    }
}

module fastenerCutout(x,y)
{
    translate([x, y, 0]) {
        cylinder(h = 10, r = 1.3, center = true);
    }
}

module window(x,y)
{
    translate([x,y,0]){
        difference() {
            xShift = 12;
            yShift = 20;
            windowOutline();
            windowCutout(xShift, yShift);
            windowCutout(xShift,-yShift);
            windowCutout(-xShift,yShift);
            windowCutout(-xShift,-yShift);
            fastenerCutout(24, 41);
            fastenerCutout(24, -41);
            fastenerCutout(-24, 41);
            fastenerCutout(-24, -41);
        }
    }
}

doorWidth = 105;
doorRectangleHeight = 170;

module doorOutline()
{
    translate([0,0,thickness/2])
        cube([doorWidth,doorRectangleHeight,thickness], center = true);
    translate([0,doorRectangleHeight/2,thickness/2])
        cylinder(h = thickness, d = doorWidth, center = true);
}

module door() 
{
    setback = 10;
    difference() {
        doorOutline();
        fastenerCutout(doorWidth/2-setback, doorRectangleHeight/2 - setback);
        fastenerCutout(-(doorWidth/2-setback), doorRectangleHeight/2 - setback);
        fastenerCutout(doorWidth/2-setback, 0);
        fastenerCutout(-(doorWidth/2-setback), 0);
        fastenerCutout(doorWidth/2-setback, -(doorRectangleHeight/2 - setback));
        fastenerCutout(-(doorWidth/2-setback), -(doorRectangleHeight/2 - setback));
        fastenerCutout(0, doorRectangleHeight/2 + doorWidth/2 - setback);
    }
}

door();
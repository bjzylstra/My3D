baseWidth = 5;
baseThickness = 1;
baseOffset = 1;

module segment(length)
{
    rotate([-90, 0, 0])
    {
        linear_extrude(height=length)
        {
            offset(r = baseOffset)
            {
                square([baseWidth,baseThickness],center=true);
            }
        }
    }
}

module arc()
{
    translate([0,0,baseOffset/2])
    {
        rotate_extrude(angle = 90)
        {
            translate([baseOffset, -baseOffset, 0])
            {
                offset(r = baseOffset)
                {
                    square([baseWidth,baseThickness],
                        center = false);
                }
            }
        }
    }
}

module end()
{
    translate([0,0,-baseOffset-baseThickness/2])
    {
        rotate_extrude(angle = 180, convexity = 10)
        {
            polygon(points=[[0,0],
                [0,(baseWidth+baseOffset)/2],
                [baseWidth/2,(baseWidth+baseOffset)/2],
                [baseWidth/2+baseOffset,baseThickness+baseOffset],
                [baseWidth/2+baseOffset,baseThickness],
                [baseWidth/2,0]]);
        }
    }
}

segment(40);

translate([15, 0, 0])
    segment(25);

translate([-15, 0, 0])
    segment(25);

translate([15-baseWidth/2,-baseWidth/2,0])
    rotate([0,0,90])
        segment(25);

translate([15-baseWidth/2-baseOffset,baseOffset,0])
    rotate([0,0,-90])
        arc();

translate([-(15-baseWidth/2-baseOffset),baseOffset,0])
    rotate([0,0,180])
        arc();

translate([15, 25, 0])
    end();

translate([-15, 25, 0])
    end();
    
translate([0,40,0])
{
    translate([-baseWidth/2-baseOffset,0,0])
        arc();
    translate([-baseThickness/2-baseOffset,baseWidth/2+baseOffset,0])
        rotate([0,0,90])
            segment(10.5);
    translate([-15+baseWidth/2+baseOffset/2,baseWidth+baseOffset*2,0])
        rotate([0,0,180])
            arc();
    translate([-15-baseOffset/2,baseWidth+baseOffset*2,0])
        segment(10);
    translate([-15+baseWidth/2+baseOffset/2,10+baseWidth+baseOffset*2,0])
        rotate([0,0,90])
            arc();
    translate([12.5,10+2*baseWidth+baseOffset/2,0])
        rotate([0,0,90])
            segment(25);
    translate([12.5,10+baseWidth+baseOffset*2,0])
        rotate([0,0,0])
            arc();
    translate([12.5+baseWidth-1.5*baseOffset,10+baseWidth+baseOffset*2,0])
        rotate([0,0,-180])
            end();
}

translate([0,-baseWidth/2-baseOffset,baseThickness+baseOffset/2])
    linear_extrude(height=0.5)
        text("I'm hooked on you",size=2.5,halign="center");

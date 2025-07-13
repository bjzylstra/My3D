baseWidth = 3;
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
                [0,(baseThickness+baseOffset*2)],
                [baseWidth/2, baseThickness+baseOffset*2],
                [baseWidth/2+baseOffset,baseThickness+baseOffset],
                [baseWidth/2+baseOffset,baseThickness],
                [baseWidth/2,0]]);
        }
    }
}

module clip()
{
    segment(20);

    translate([10, 0, 0])
        segment(15);

    translate([-10, 0, 0])
        segment(15);

    translate([10-baseWidth+baseOffset,-baseWidth/2,0])
        rotate([0,0,90])
            segment(15+baseOffset);

    translate([10-baseWidth/2-baseOffset,baseOffset,0])
        rotate([0,0,-90])
            arc();

    translate([-(10-baseWidth/2-baseOffset),baseOffset,0])
        rotate([0,0,180])
            arc();

    translate([10, 15, 0])
        end();

    translate([-10, 15, 0])
        end();
        
    translate([0,20,0])
    {
        translate([-baseWidth/2-baseOffset,0,0])
            arc();
        translate([-baseThickness/2-baseOffset,baseWidth/2+baseOffset,0])
            rotate([0,0,90])
                segment(5+baseOffset/2);
        translate([-10+baseWidth+baseOffset/2,baseWidth+baseOffset*2,0])
            rotate([0,0,180])
                arc();
        translate([-10+baseOffset,baseWidth+baseOffset*2,0])
            segment(5);
        translate([-10+baseWidth+baseOffset/2,5+baseWidth+baseOffset*2,0])
            rotate([0,0,90])
                arc();
        translate([7.5+baseOffset/2,5+2*baseWidth+1.5*baseOffset,0])
            rotate([0,0,90])
                segment(15);
        translate([10-2.5*baseOffset,5+baseWidth+baseOffset*2,0])
            rotate([0,0,0])
                arc();
        translate([10,5+baseWidth+baseOffset*2,0])
            rotate([0,0,-180])
                end();
    }
}

clip();
translate([baseWidth/2-baseOffset/2-0.25, 10, baseThickness/2+baseOffset])
    rotate([0,0,90])
        linear_extrude(height=0.5)
            text("I'm hooked on you",size=2,halign="center");

translate([30, 0, 0])
{
    rotate([180, 0, 0])
        clip();
    translate([baseWidth/2-baseOffset/2-0.25, -10, baseThickness/2+baseOffset])
        rotate([0,0,90])
            linear_extrude(height=0.5)
                text("I'm hooked on you",size=2,halign="center");
}
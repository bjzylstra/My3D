module segment(length)
{
    rotate([-90, 0, 0])
    {
        linear_extrude(height=length)
        {
            offset(r = 1)
            {
                square([5,1]);
            }
        }
    }
}

module arc()
{
    rotate_extrude(angle = 90)
    {
        translate([1, 1, 0])
        {
            offset(r = 1)
            {
                square([5,1], center = false);
            }
        }
    }
}

segment(50);

translate([15, 0, 0])
    segment(25);

translate([-15, 0, 0])
    segment(25);

translate([15,-5,0])
    rotate([0,0,90])
        segment(25);

translate([14.1,0.9,-2])
    rotate([0,0,-90])
        arc();

translate([-9.1,0.9,-2])
    rotate([0,0,180])
        arc();

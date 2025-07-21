angle = atan(271/(44.7-30.9));
echo(angle);

module face() {
    linear_extrude(1.6)
        polygon(points=[[0,0],[44.7,0],
            [44.7 - 285/tan(angle),285],[0,285]]);
    rotate([angle-90,0,0])
        cube([44.7, 1.6, 12.5], center = false);
}

face();
translate([44.7*2-13.4,4,44.7-12.9])
    rotate([-3.,-45,7.1])
        mirror([1,0,0])
            face();
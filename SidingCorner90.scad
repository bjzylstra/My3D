module face() {
    linear_extrude(2)
        polygon(points=[[0,0],[44.7,0],[30.7,275],[0,275]]);
    cube([44.7, 2, 12.5], center = false);
}

face();
rotate([0,-90,0])
    mirror([0,0,1])
        face();
$fn = 50;

module rocker() {
    difference() {
        cylinder(h = 18, r = 36.5);
        // Top it off
        translate([-28, -26, -1])
            cube([80,100,21]);
        // Trim left and right
        translate([26,-50,-1])
            cube([30, 100, 21]);
        translate([-56,-50,-1])
            cube([30, 100, 21]);
        // Axle hole
        translate([0, -29, -1])
            cylinder(h = 30, r = 1.3);
        // Recess for switches
        translate([-15.3,-31,-1])
            cube([9.3, 15, 21]);
        translate([-15.3,-31,-1])
            rotate([0,0,10])
                cube([2,10,21]);
        translate([13.5,-30.6,-1])
            rotate([0,0,-10])
                cube([2,10,21]);
        translate([6,-31,-1])
            cube([9.3, 15, 21]);
        // Spring and pin holes
        rotate([90, 0, 0]) {
            translate([20, 9, 25]) {
                translate([0, 0, 2])
                    cylinder(h = 10, r = 2.75);
                translate([1, 0, -10])
                    cylinder(h = 50, r = 1.6);
                translate([-1, 0, -10])
                    cylinder(h = 50, r = 1.6);
                translate([-1.1, -1.6, -10])
                    cube([2,3.2,50]);
            }
            translate([-20, 9, 25]) {
                translate([0, 0, 2])
                    cylinder(h = 10, r = 2.75);
                translate([-1, 0, -10])
                    cylinder(h = 50, r = 1.6);
                translate([1, 0, -10])
                    cylinder(h = 50, r = 1.6);
                translate([-0.9, -1.6, -10])
                    cube([2,3.2,50]);
            }
        }
        // Flatten bottom
        translate([-15,-64,-1])
            cube(30);
    }
}

module handleBase() {
    difference() {
        cylinder(h = 18, r = 12.5);
        translate([-15, -38, -1])
            cube(40);
        translate([6, 0, -1])
            cube(20);
        translate([-26, 0, -1])
            cube(20);
    }
}

module upperHandle() {
    cube([5,17,15.5]);
    translate([2.5,17,0]){
        cylinder(h = 15.5, r = 2.5);
    }
}

translate([0,0,5]) 
    rotate([90,0,0]) {
        union() {
            translate([0,29,0])
                rocker();
            handleBase();
            translate([-2.5,10,1.25])
                upperHandle();
        }
    }


// Washers
translate([40, 0, 0])
    difference() {
        cylinder(h = 7, r = 3);
        translate([0,0,-1])
            cylinder(h = 9, r = 1.3);
    }

translate([-40, 0, 0])
    difference() {
        cylinder(h = 7, r = 3);
        translate([0,0,-1])
            cylinder(h = 9, r = 1.3);
    }

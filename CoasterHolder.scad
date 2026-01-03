$fa = 5;
innerDiameter = 112;
innerHeight = 37;
wallThickness = 1.5;
fingerHoleDiameter = 17;
cutoutLower = 40;
cutoutUpper = 70;
cutoutBottom = 4;

module basicHolder() {
    rotate_extrude()
        offset(r=wallThickness/2)
            polygon(points=[[fingerHoleDiameter/2,0],
                [innerDiameter/2+wallThickness,0],
                [innerDiameter/2+wallThickness,innerHeight+wallThickness],
                [innerDiameter/2,innerHeight+wallThickness],
                [innerDiameter/2,wallThickness],
                [fingerHoleDiameter/2,wallThickness]]);
}

module cutoutHalf() {
    cutoutPointsOld=[[cutoutBottom,0],
        [cutoutBottom,cutoutLower/2],
        [innerHeight+wallThickness,cutoutUpper/2],
        [innerHeight+wallThickness,0]];
    cutoutPoints=[[cutoutBottom,0],
// Using Excel to generate the sine wave shape
[4,20],
[4.254470137,20.83333333],
[5.010148602,21.66666667],
[6.244074487,22.5],
[7.918755578,23.33333333],
[9.983307538,24.16666667],
[12.375,25],
[15.0211626,25.83333333],
[17.84139302,26.66666667],
[20.75,27.5],
[23.65860698,28.33333333],
[26.4788374,29.16666667],
[29.125,30],
[31.51669246,30.83333333],
[33.58124442,31.66666667],
[35.25592551,32.5],
[36.4898514,33.33333333],
[37.24552986,34.16666667],
[37.5,35],
[innerHeight+wallThickness,cutoutUpper/2],
[innerHeight+wallThickness,0]];
   
    polygon(cutoutPoints);
}

module cutout() {
    linear_extrude(innerDiameter*2) {
        cutoutHalf();
        mirror([0,180,0])
            cutoutHalf();
    }
}

difference() {
    basicHolder();
    translate([innerDiameter,0,wallThickness])
        rotate([0,-90,0])
            cutout();
}


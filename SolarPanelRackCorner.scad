innerWidth = 37.8;
innerHeight = 37.8;
wallWidth = 2;

module channel() {
    points = [
        [0,0],
        [0,innerHeight + wallWidth],
        [wallWidth, innerHeight + wallWidth],
        [wallWidth, wallWidth],
        [wallWidth + innerWidth, wallWidth],
        [wallWidth + innerWidth, innerHeight + wallWidth],
        [wallWidth + innerWidth + wallWidth, innerHeight + wallWidth],
        [wallWidth + innerWidth + wallWidth, 0]
    ];

    linear_extrude(height = 2 * innerWidth + wallWidth)
        polygon(points);
}

channel();
mirror([0, -1, 1])
    channel();
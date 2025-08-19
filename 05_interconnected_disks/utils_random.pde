
int randomDirection() {
    int x = (Math.random() < 0.5) ? 0 : 1;
    if(x == 0) return -1;
    else return 1;
}


float randomSpeed() {
    // return random(0.1, 3);
    return random(0.5, 1.25);
}


color randomColor(int opacity) {
    int min = 70;
    int max = 215;

    int r = (int)random(min, max);
    int g = (int)random(min, max);
    int b = (int)random(min, max);

    return color(r, g, b, opacity);
}


float randomXPos(int radius) {
    return (float) random(radius, width - radius);
}

float randomYPos(int radius) {
    // return height / 2 + radius;
    return (float) random(radius, height - radius);
}

int randomRadius(){
    int min = 30;
    int max = height/6;

    // I am searching for a better way to distribute the radius with a
    // I would like to have the focus of value distribution in the lower two-thirds, that's why I am experimenting with
    // the definition of maxRadius

    int maxRadius = (int)random(min, max);
    return (int)random(min, maxRadius);
}

Point randomPosition(int radius) {
    return new Point(randomXPos(radius), randomYPos(radius));
}


/**
 * Bounce.
 * 
 * When the shape hits the edge of the window, it reverses its direction. 
 */

import java.util.ArrayList;
import java.util.List;


color backgroundColor = color(230,230,230);  // 102

List<Disc> discs = new ArrayList<Disc>();

int COUNT_DISKS = 10;
int MAX_OPACITY = 50;  // between 0 and 255, e.g. 128 (or: TRANSPARENCY ...)

void setup() 
{
  size(1000, 800);
  noStroke();
  frameRate(30);
  ellipseMode(RADIUS);

  for(int i = 0; i < COUNT_DISKS; i++) {
      discs.add(
        new Disc()
    );
  }
  background(backgroundColor);
}


void draw() {
    if (keyPressed) {
        return;
    }
    background(backgroundColor);
    for (Disc d : discs) {
        d.draw();
    }
}



int randomDirection() {
    int x = (Math.random() < 0.5) ? 0 : 1;
    if(x == 0) return -1;
    else return 1;
}


float randomSpeed() {
    return random(0.1, 3);
}

color randomColor(int opacity) {
    int min = 0;
    int max = 255;

    int r = (int)random(min, max);
    int g = (int)random(min, max);
    int b = (int)random(min, max);

    return color(r, g, b, opacity);
}


int randomXPos(int radius) {
    return (int)random(radius, width - radius);
}

int randomYPos(int radius) {
    // return height / 2 + radius;
    return (int)random(radius, height - radius);
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

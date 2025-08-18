/**
 * Bounce.
 * 
 * When the shape hits the edge of the window, it reverses its direction. 
 */

import java.util.List;


// constants

color backgroundColor = color(230,230,230);  // 102

int COUNT_DISKS = 15;
int MAX_OPACITY = 50;  // between 0 and 255, e.g. 128 (or: TRANSPARENCY ...)


// processing functions

void setup() 
{
  size(1000, 800);
  noStroke();
  frameRate(30);
  ellipseMode(RADIUS);

  for(int i = 0; i < COUNT_DISKS; i++) {
      String name = "disc_" + i;
      discs.put(
        name,
        new Disc(name)
    );
  }
  background(backgroundColor);
}


void draw() {
    if (keyPressed) {
        return;
    }

    calculateDistances();

    background(backgroundColor);
    for (Disc d : discs.values()) {
        d.draw();
        drawSegments();
    }
}

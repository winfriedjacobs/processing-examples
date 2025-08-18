/**
 * Bounce.
 * 
 * When the shape hits the edge of the window, it reverses its direction. 
 */

import java.util.ArrayList;
import java.util.List;


// constants

color backgroundColor = color(230,230,230);  // 102

int COUNT_DISKS = 10;
int MAX_OPACITY = 50;  // between 0 and 255, e.g. 128 (or: TRANSPARENCY ...)



// global values

List<Disc> discs = new ArrayList<Disc>();



// processing functions

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

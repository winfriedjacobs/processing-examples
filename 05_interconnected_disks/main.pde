/**
 * Bounce.
 * 
 * When the shape hits the edge of the window, it reverses its direction. 
 */

import java.util.List;


// constants

color backgroundColor = color(230,230,230);  // 102


// globals

SortedMap<String, Disc> discs = new ConcurrentSkipListMap<String, Disc>();
List<Segment> segments = new ArrayList<Segment>();
DiscAdderThread discAdderThread;



// processing functions

void setup() 
{
  size(1000, 800);
  noStroke();
  frameRate(30);
  ellipseMode(RADIUS);

  /*
  // this is moved to the DiscAdderThread class
  for(int i = 0; i < COUNT_DISKS; i++) {
      String name = "disc_" + i;
      discs.put(
        name,
        new Disc(name)
    );
  }
  */
  discAdderThread = new DiscAdderThread();
  discAdderThread.start();

  background(backgroundColor);
}


void draw() {
    for (Disc d : discs.values()) {
        d.updatePosition();
    }

    calculateDistances();

    background(backgroundColor);
    for (Disc d : discs.values()) {
        d.draw();
        drawSegments();
    }
}

void keyPressed() {
  noLoop();  // Holding down a key stops looping
}

void keyReleased() {
  loop();  // Releasing the key restarts looping draw()
}


// Ensure the thread is stopped when the sketch closes
void exit() {
  if (discAdderThread != null) {
    discAdderThread.interrupt();
    try {
      discAdderThread.join(); // Wait for the thread to finish
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
  }
  super.exit();
}
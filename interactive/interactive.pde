/**
 * Storing Input.
 *
 * Move the mouse across the screen to change the position
 * of the circles. The positions of the mouse are recorded
 * into an array and played back every frame. Between each
 * frame, the newest value are added to the end of each array
 * and the oldest value is deleted.
 */

int num = 60;
float mx[] = new float[num];
float my[] = new float[num];

color colors[] = new color[num];

int previousMouseX = -1;
int previousMouseY = -1;

int FAKTOR_VERLANGSAMEN = 0; // > 1 dann wird der Prozess entsprechend verlangsamt; z.B. Faktor 4 oder 10;

void setup() {
  for (int n = 0; n < num; n++) {

     int c1 = (120 + (n * 17) % (256 - 120));
     int c2 = (120 + (n * 13) % (256 - 120));
     int c3 = (120 + (n * 7) % (256 - 120));

      colors[n] = color(c1, c2, c3);
      // System.out.println(n);
  }

  size(640, 360);
  noStroke();
}

void draw() {
  // Cycle through the array, using a different entry on each frame.
  // Using modulo (%) like this is faster than moving all the values over.

  int pos;

  if (FAKTOR_VERLANGSAMEN > 1) {
    if(frameCount % FAKTOR_VERLANGSAMEN != 0) {
        return;
    }
    pos = (frameCount / FAKTOR_VERLANGSAMEN) % num;
  } else {
    // NICHT verlangsamen:
    pos = frameCount % num;
  }

  // System.out.println("frameCount: " + Integer.toString(frameCount));
  // System.out.println("previousMouseX: " + Integer.toString(previousMouseX) + " | mouseX: " + Integer.toString(mouseX));
  // System.out.println("previousMouseY: " + Integer.toString(previousMouseY) + " | mouseY: " + Integer.toString(mouseY));


  background(51);

  // if (previousMouseX == mouseX && previousMouseY == mouseY) {
  //   return;
  // }

  mx[pos] = mouseX;
  my[pos] = mouseY;

  // render first ellipse

  for (int i = 0; i < num - 1; i++) {
    // pos+1 is the smallest (the oldest in the array)
    int index = (pos+1 + i) % num;

    color c = colors[index];
    fill(c);
    ellipse(mx[index], my[index], i, i);
  }

  previousMouseX = mouseX;
  previousMouseY = mouseY;
  }

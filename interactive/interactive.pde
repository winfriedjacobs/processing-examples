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


void setup() {
  for (int n = 0; n < num; n++) {

     int c1 = (120 + (n * 17) % (256 - 120));
     int c2 = (120 + (n * 13) % (256 - 120));
     int c3 = (120 + (n * 7) % (256 - 120));

      colors[n] = color(c1, c2, c3);
      System.out.println(n);
  }

  size(640, 360);
  noStroke();
  // fill(255, 153);
}

void draw() {
  background(51);

  // Cycle through the array, using a different entry on each frame.
  // Using modulo (%) like this is faster than moving all the values over.
  int pos = frameCount % num;
  mx[pos] = mouseX;
  my[pos] = mouseY;

  for (int i = 0; i < num; i++) {
    // pos+1 is the smallest (the oldest in the array)
    int index = (pos+1 + i) % num;

    color c = colors[index];
    fill(c);

    ellipse(mx[index], my[index], i, i);
  }
}

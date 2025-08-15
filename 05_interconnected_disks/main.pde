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


class Disc {
    public int rad;

    // Starting position of shape
    public float xpos;
    public float ypos;

    // Speed of the shape
    public float xspeed = 15;
    public float yspeed = 5;

    public int xdirection = 1;  // Left or Right
    public int ydirection = 1;  // Top or Bottom

    color fillColor;
    int opacity = MAX_OPACITY;

   public Disc(){
        this.fillColor = randomColor(this.opacity);

        this.xspeed = randomSpeed();
        this.yspeed = randomSpeed();

        this.xdirection = randomDirection();
        this.ydirection = randomDirection();

        this.rad = randomRadius();

        this.xpos = randomXPos(this.rad);
        this.ypos = randomYPos(this.rad);

    }

    void render() {
        // the disc:
        fill(this.fillColor);
        ellipse(this.xpos, this.ypos, this.rad, this.rad);

        // the dot in the center:
        fill(0,0,0, this.opacity);
        ellipse(this.xpos, this.ypos, 3, 3);
    }

    void updatePosition() {

      // Test to see if the shape exceeds the boundaries of the screen
      // If it does, reverse its direction by multiplying by -1
      if (this.xpos > width - this.rad || this.xpos < this.rad) {
        this.xdirection *= -1;
      }
      if (this.ypos > height - this.rad || this.ypos < this.rad) {
        this.ydirection *= -1;
      }

      this.xpos += (this.xspeed * this.xdirection);
      this.ypos += (this.yspeed * this.ydirection);
    }

    void changeSpeed() {
        this.xspeed = Math.max(0, this.xspeed - 0.05);
        this.yspeed = Math.max(0, this.yspeed - 0.05);
    }

    void draw() {
      // was the main draw function

      this.updatePosition();
      this.render();

      // this.changeSpeed();
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
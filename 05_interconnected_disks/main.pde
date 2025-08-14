/**
 * Bounce.
 * 
 * When the shape hits the edge of the window, it reverses its direction. 
 */

import java.util.ArrayList;
import java.util.List;


color backgroundColor = color(102, 102, 102);

List<Disc> discs = new ArrayList<Disc>();

void setup() 
{
  size(640, 360);
  noStroke();
  frameRate(30);
  ellipseMode(RADIUS);

  discs.add(
    new Disc(
      width/2, // xpos,
      height/2, // ypos
      color(0, 200, 0),
      25, // xspeed
      25 // yspeed
    )
  );

  discs.add(
    new Disc(
      width/4, // xpos,
      height/4, // ypos
      color(200, 0, 0),
      15, // xspeed
      15 // yspeed
    )
  );

  discs.add(
    new Disc(
      width/4, // xpos,
      height/4, // ypos
      color(200, 100, 100),
      5, // xspeed
      5 // yspeed
    )
  );

  background(backgroundColor);
}


void draw() {
    background(backgroundColor);
    for (Disc d : discs) {
        d.draw();
    }
}


class Disc {
    public int rad = 60;
    public int rad2 = 60 + 1;

    // Starting position of shape
    public float xpos;
    public float ypos;

    // Speed of the shape
    public float xspeed = 15;
    public float yspeed = 5;

    public int xdirection = 1;  // Left or Right
    public int ydirection = 1;  // Top or Bottom

    color backgroundColor = color(102, 102, 102);
    color fillColor;

   public Disc(float xpos, float ypos, color c, float xspeed, float yspeed){
        this.xpos = xpos;
        this.ypos = ypos;
        this.fillColor = c;
        this.xspeed = xspeed;
        this.yspeed = yspeed;
    }

    void render() {
      if (xspeed > 0 && yspeed > 0) {
        fill(this.fillColor);
        ellipse(this.xpos, this.ypos, this.rad, this.rad);
      }
    }

    void renderDelete() {
        fill(backgroundColor);
        ellipse(this.xpos, this.ypos, this.rad2, this.rad2);
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

      // this.renderDelete();
      // instead: "background(backgroundColor)" in the main draw function


      this.updatePosition();
      this.render();

      // this.changeSpeed();
}
}

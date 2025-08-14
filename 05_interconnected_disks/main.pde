/**
 * Bounce. 
 * 
 * When the shape hits the edge of the window, it reverses its direction. 
 */
 
color backgroundColor = color(102, 102, 102);

Disc disc;


void setup() 
{
  size(640, 360);
  noStroke();
  frameRate(30);
  ellipseMode(RADIUS);

  disc = new Disc(
    width/2, // xpos,
    height/2, // ypos
    color(0, 200, 0)
  );

  background(backgroundColor);
}


void draw() {
  disc.renderDelete();
  // background(backgroundColor);

  disc.updatePosition();

  disc.render();

  disc.changeSpeed();
}


class Disc {
    public int rad = 60;
    public int rad2 = 60 + 1;

    public float xspeed = 15;  // Speed of the shape, may be negative
    public float yspeed = 15;  // Speed of the shape, may be negative

    // Starting position of shape
    public float xpos;
    public float ypos;

    public int xdirection = 1;  // Left or Right
    public int ydirection = 1;  // Top or Bottom

    color backgroundColor = color(102, 102, 102);
    color fillColor;

    public Disc(float xpos, float ypos, color c){
        this.xpos = xpos;
        this.ypos = ypos;
        this.fillColor = c;
    }

    void renderDelete() {
        fill(backgroundColor);
        ellipse(this.xpos, this.ypos, this.rad, this.rad);
    }

    void render() {
      if (xspeed > 0 && yspeed > 0) {
        fill(this.fillColor);
        ellipse(this.xpos, this.ypos, this.rad, this.rad);
      }
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
}

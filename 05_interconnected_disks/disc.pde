class Disc {
    public String name;
    public int rad;

    // Starting position of shape
    public float xpos;
    public float ypos;

    // Speed of the shape
    public float xspeed;
    public float yspeed;

    public int xdirection = 1;  // Left or Right
    public int ydirection = 1;  // Top or Bottom

    color fillColor;
    int opacity = MAX_OPACITY;

   public Disc(String name){
        this.name = name;
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
        noStroke();
        fill(this.fillColor);
        circle(this.xpos, this.ypos, this.rad);

        // the dot in the center:
        fill(0, 0, 0, 50);  // black with half opacity
        // fill(segmentColor);
        circle(this.xpos, this.ypos, 3);   // original 3
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

    Point center() {
        return new Point(this.xpos, this.ypos);
    }

    void draw() {
      // was the main draw function

      this.updatePosition();
      this.render();

      // this.changeSpeed();
    }
}

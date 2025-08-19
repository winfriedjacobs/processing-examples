class Disc {
    public String name;
    public int rad;

    // // Starting position of shape
    public ArrayList<Point> steps;
    public int currentStep = 0;

    // Current position of shape
    public Point pos;

    color fillColor;
    int opacity = MAX_OPACITY;

    public Disc(String name){
        this.name = name;
        this.fillColor = randomColor(this.opacity);
        this.rad = randomRadius();

        int numberOfSteps = (int) random(1300, 1700);  // todo
        this.steps = new ArrayList<Point>();

        Point startPos = randomPosition(this.rad);
        Point endPos = randomPosition(this.rad);

        float xdiff = (endPos.x - startPos.x) / numberOfSteps;
        float ydiff = (endPos.y - startPos.y) / numberOfSteps;

        int i;
        float currentX;
        float currentY;
        for (
            i = 0, currentX = startPos.x, currentY = startPos.y;
            i < numberOfSteps - 1;
            i++, currentX += xdiff, currentY += ydiff
        ) {
            this.steps.add(new Point(currentX, currentY));
        }
    }

    void render() {
        // the disc:
        noStroke();
        fill(this.fillColor);
        circle(this.pos.x, this.pos.y, this.rad);

        // the dot in the center:
        fill(0, 0, 0, 50);  // black with half opacity
        // fill(segmentColor);
        circle(this.pos.x, this.pos.y, 3);   // original 3
    }

    void updatePosition() {
      // println("updatePosition " + this.steps.size());
      if(this.steps.size() > 0) {
        this.pos = this.steps.remove(0);  // unshift
      } else {
        this.removeMeFromDiscs();
      }
    }

    Point center() {
        return new Point(this.pos);
    }

    void removeMeFromDiscs() {
        discs.remove(this.name);
    }

    void draw() {
      this.updatePosition();
      this.render();

      // this.changeSpeed();
    }

}

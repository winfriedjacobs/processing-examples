int MAX_OPACITY = 50;  // between 0 and 255, e.g. 128 (or: TRANSPARENCY ...)

class Disc {
    public String name;
    public int rad;

    // // Starting position of shape
    public ArrayList<Point> steps;

    public int currentStep = 0;
    public int numberOfSteps;

    // Current position of shape
    public Point pos;

    color fillColor;
    int opacity = MAX_OPACITY;

    public Disc(String name){
        this.name = name;
        this.fillColor = randomColor(this.opacity);
        this.rad = randomRadius();

        this.numberOfSteps = (int) random(1300, 1700);  // todo
        this.steps = new ArrayList<Point>();

        Point startPos = randomPosition(this.rad);
        Point endPos = randomPosition(this.rad);

        float xdiff = (endPos.x - startPos.x) / this.numberOfSteps;
        float ydiff = (endPos.y - startPos.y) / this.numberOfSteps;

        int i;
        float currentX;
        float currentY;
        for (
            i = 0, currentX = startPos.x, currentY = startPos.y;
            i < this.numberOfSteps - 1;
            i++, currentX += xdiff, currentY += ydiff
        ) {
            this.steps.add(new Point(currentX, currentY));
        }
    }

    void render() {
        // the disc:
        int threshold = 150;  // step number 0..threshold: fade-in, numberOfSteps-threshold..numberOfStep: fade-out

        int alpha = -1;

        // Achtung, das neue Alpha wird zur vorhandenden Opacity hinzu"kombiniert" (sofern > 0)
        // deswegen muss es von 0 bis 255 hochgezählt werden
        if (this.currentStep < threshold) {
            alpha = this.currentStep * 255 / threshold;
        } else {
            int distanceToEnd = this.numberOfSteps - this.currentStep;
            if (distanceToEnd < threshold) {
                alpha = distanceToEnd * 255 / threshold;
            } else {
                alpha = -1;
            }
        }

        // println("alpha: " + alpha);

        color fillColor = alpha >= 0
            ? color(this.fillColor, alpha)
            : this.fillColor;

        noStroke();
        fill(fillColor);
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
        this.currentStep++;
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

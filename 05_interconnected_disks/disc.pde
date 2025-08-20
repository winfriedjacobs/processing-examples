int MAX_OPACITY = 50;  // between 0 and 255, e.g. 128 (or: TRANSPARENCY ...)

class Step {
    public PVector pos;
    public int opacity;

    public Step(PVector pos, int opacity) {
        this.pos = pos;
        this.opacity = opacity;
    }

    public Step(PVector pos) {
        this(pos, MAX_OPACITY);
    }
}


class Disc {
    public String name;
    public int rad;
    public int opacity;

    // // Starting position of shape
    public ArrayList<Step> steps;

    public int currentStep = 0;
    public int numberOfSteps;

    // Current position of shape
    public PVector pos;

    color fillColor;

    public Disc(String name){
        this.name = name;
        this.fillColor = randomColor(MAX_OPACITY);
        this.rad = randomRadius();

        this.numberOfSteps = (int) random(1300, 1700);  // todo
        this.steps = createSteps(this.rad, this.numberOfSteps);
    }

    void render() {
        // the disc:
        color fillColor = updateFillColor(this.fillColor, this.currentStep, this.numberOfSteps);

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
        Step step =  this.steps.remove(0);  // unshift
        this.pos = step.pos;
        this.opacity = step.opacity;

        this.currentStep++;
      } else {
        this.removeMeFromDiscs();
      }
    }

    PVector center() {
        return this.pos.copy();
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

color updateFillColor(color initialFillColor, int currentStep, int numberOfSteps) {

    int threshold = 150;  // step number 0..threshold: fade-in, numberOfSteps-threshold..numberOfStep: fade-out

    int alpha = -1;

    // Achtung, das neue Alpha wird zur vorhandenden Opacity hinzu"kombiniert" (sofern > 0)
    // deswegen muss es von 0 bis 255 hochgezählt werden
    if (currentStep < threshold) {
        alpha = alphaFromDistance(currentStep, threshold);
    } else {
        int distanceToEnd = numberOfSteps - currentStep;
        if (distanceToEnd < threshold) {
            alpha = alphaFromDistance(distanceToEnd, threshold);
        }
    }
    // else alpha remains -1

    // println("alpha: " + alpha);

    color fillColor = alpha >= 0
        ? color(initialFillColor, alpha)
        : initialFillColor;

    return fillColor;
}


ArrayList<Step> createSteps(int discRadius, int numberOfSteps) {
    ArrayList<Step> steps = new ArrayList<Step>();

    PVector startPos = randomPosition(discRadius);
    PVector endPos = randomPosition(discRadius);

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
        PVector pos = new PVector(currentX, currentY);
        steps.add(new Step(pos));
    }

    return steps;
}
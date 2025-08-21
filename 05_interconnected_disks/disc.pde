int MAX_OPACITY = 65; // 50-75 gehen gut  // between 0 and 255, e.g. 128 (or: TRANSPARENCY ...)
int MAX_ALPHA = 255;

class Step {
    public PVector pos;
    public int alpha;

    public Step(PVector pos, int alpha) {
        this.pos = pos;
        this.alpha = alpha;  // will later be combined with the opacity of the disc
    }

    public Step(PVector pos) {
        this(pos, MAX_ALPHA);
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

    // Current step
    public Step step;

    color fillColor;

    public Disc(String name){
        this.name = name;
        this.fillColor = randomColor(MAX_OPACITY);
        this.rad = randomRadius();

        this.numberOfSteps = (int) random(450, 950);
        this.steps = createSteps(this.rad, this.numberOfSteps);
    }

    void render(PVector pos, color originalFillColor, int alpha, int radius) {
        // the disc:
        color fillColor = updateColorWithAlpha(originalFillColor, alpha);

        noStroke();
        fill(fillColor);
        circle(pos.x, pos.y, radius);

        // the dot in the center:
        color dotColor = updateColorWithAlpha(segmentColor, alpha);
        fill(dotColor);
        circle(pos.x, pos.y, 3);   // original 3
    }

    void updatePosition() {
      if(this.steps.size() > 0) {
        this.step = this.steps.remove(0);  // unshift
        this.currentStep++;
      } else {
        this.removeMeFromDiscs();
      }
    }

    PVector center() {
        return this.step.pos.copy();
    }

    void removeMeFromDiscs() {
        discs.remove(this.name);
    }

    void draw() {
      // this.updatePosition();  // removed, because updatePosition is called in an extra loop in main
      if (this.step != null) {
        this.render(this.step.pos, this.fillColor, this.step.alpha, this.rad);
      }

      // this.changeSpeed();
    }
}

color updateColorWithAlpha(color initialFillColor, int alpha) {
    // 0 <= alpha <= 255
    color fillColor = alpha == MAX_ALPHA
        ? initialFillColor
        : color(initialFillColor, alpha);
    return fillColor;
}


ArrayList<Step> createSteps(int discRadius, int numberOfSteps) {
    int threshold = 25;  // gehen beide gut: 25, 50;  // step number 0..threshold: fade-in, numberOfSteps-threshold..numberOfStep: fade-out

    ArrayList<Step> steps = new ArrayList<Step>();

    PVector startPos = randomPosition(discRadius);
    PVector endPos = randomPosition(discRadius);

    float xdiff = (endPos.x - startPos.x) / numberOfSteps;
    float ydiff = (endPos.y - startPos.y) / numberOfSteps;

    int i;  // stepNumber
    float currentX;
    float currentY;
    for (
        i = 0, currentX = startPos.x, currentY = startPos.y;
        i < numberOfSteps - 1;
        i++, currentX += xdiff, currentY += ydiff
    ) {
        PVector pos = new PVector(currentX, currentY);
        // Create the “appear/disappear alphas” in advance along with the steps, not during rendering.
        // This is even better considering that the creation of a Disc is performed in an extra thread.
        int alpha = createAlpha(i, numberOfSteps, threshold);

        steps.add(new Step(pos, alpha));
    }

    return steps;
}


int createAlpha(int currentStep, int numberOfSteps, int threshold) {
    int alpha = MAX_ALPHA;

    // Achtung, das neue Alpha wird zur vorhandenden Opacity hinzu"kombiniert" (sofern > 0),
    // deswegen muss es von 0 bis 255 hochgezählt werden
    if (currentStep < threshold) {
        alpha = alphaFromDistance(currentStep, threshold);
    } else {
        int distanceToEnd = numberOfSteps - currentStep;
        if (distanceToEnd < threshold) {
            alpha = alphaFromDistance(distanceToEnd, threshold);
        }
    }
    // else alpha remains MAX_ALPHA

    return alpha;
}

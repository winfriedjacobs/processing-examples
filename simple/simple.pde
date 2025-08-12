
color fillColor = color(0, 200, 0);

public void settings() {
      size(640, 480);
}

public void setup() {
      background(0);
}

public void draw() {
    fill(fillColor);
    ellipse(mouseX+100, mouseY, 50, 50);
}

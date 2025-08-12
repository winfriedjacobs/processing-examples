/**
 * Bounce. 
 * 
 * When the shape hits the edge of the window, it reverses its direction. 
 */
 
int rad = 60;        // Width of the shape
int rad2 = rad + 1;
float xpos, ypos;    // Starting position of shape

float xspeed = 15;  // Speed of the shape
float yspeed = 15;  // Speed of the shape

int xdirection = 1;  // Left or Right
int ydirection = 1;  // Top to Bottom

color backgroundColor = color(102, 102, 102);
color objectColor = color(0, 200, 0);


void setup() 
{
  size(640, 360);
  noStroke();
  frameRate(30);
  ellipseMode(RADIUS);
  // Set the starting position of the shape
  xpos = width/2;
  ypos = height/2;

  background(backgroundColor);
}

void renderEllipse(color c){
    fill(c);
    ellipse(xpos, ypos, rad, rad);
}

void renderEllipse2(color c){
    fill(c);
    ellipse(xpos, ypos, rad2, rad2);
}

void draw() 
{
  renderEllipse2(backgroundColor);
  // background(backgroundColor);

  // Update the position of the shape
  xpos = xpos + (xspeed * xdirection);
  ypos = ypos + (yspeed * ydirection);
  
  // Test to see if the shape exceeds the boundaries of the screen
  // If it does, reverse its direction by multiplying by -1
  if (xpos > width-rad || xpos < rad) {
    xdirection *= -1;
  }
  if (ypos > height-rad || ypos < rad) {
    ydirection *= -1;
  }

  if (xspeed > 0 && yspeed > 0) {
    // Draw the shape
    renderEllipse(objectColor);
  }

  xspeed = Math.max(0, xspeed - 0.05);
  yspeed = Math.max(0, yspeed - 0.05);
}

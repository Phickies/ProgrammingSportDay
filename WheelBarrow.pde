/*=================
 The wheelbarrow, code written by Nina and Rosalie, design by Rosalie
 =================*/

class Wheelbarrow {
  float x;
  float y;
  float w;
  float h;
  boolean isFlipped;

  // size is 300x120

  Wheelbarrow() {
    w = 200;
    h = 120;
    x = width/2;
    y = height - height/8;
    isFlipped = false;
  }

  void display() {
    pushMatrix();
    translate(x, y);
    if (isFlipped) {
      pushMatrix();
      translate(280, 0);
      scale(-1, 1);
    }
    fill(0);
    noStroke();
    circle(30, 100, 45);  //wheel
    fill(200);
    circle(30, 100, 20);  //wheel
    fill(255, 0, 0);
    quad(30, 30, 75, 90, 190, 50, 200, 30);  //main part
    noFill();
    stroke(100);
    strokeWeight(8);
    quad(110, 75, 125, 115, 160, 115, 170, 55);  //feet
    line(30, 100, 280, 20);  //support beam
    stroke(255, 0, 0);
    strokeWeight(10);
    line(255, 28, 280, 20);  //handle
    if (isFlipped) {
      popMatrix();
    }
    popMatrix();
  }
  void move(boolean[] keys) {
    if (keys[0] && keys[1]) {
    } else if (x > 0 && keys[0]) {
      x -= 15;
      isFlipped = false;
    } else if (x < width-300 && keys[1]) {
      x += 15;
      isFlipped = true;
    }
  }
  void update() {
  }
}

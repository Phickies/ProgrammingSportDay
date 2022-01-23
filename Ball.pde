/*=================
 All the balls that are drawn, code written by Nina, An, Ata
 =================*/

class Ball {
  PVector position;
  float gravity;
  PVector velocity;
  PVector acceleration;
  int value;

  String type;

  float radius;
  boolean toRemove;

  //constructor of the class king
  Ball() {
    acceleration = new PVector(0, 0);
    position = new PVector(1700, 300);
    velocity = new PVector(20, 10);
    gravity = random(0.02, 0.05);
    value = int(random(-5, 11));

    radius = 48;
    toRemove = false;
    if (int(random(0, 6)) == 5) {
      type = "time";
    } else {
      type= "number";
    }
  }

  // draw the ball
  void display() {
    stroke(0);
    noStroke();
    if (type =="time") {
      fill(0, 0, 255);
    } else {
      fill(0);
      if (value < 0) {
        fill(255, 0, 0);
      }
    }
    circle(position.x, position.y, radius);
    fill(255);
    text(str(value), position.x, position.y);
  }

  // calculate the force to throw the ball
  void update() {
    acceleration.y += gravity;
    velocity.sub(acceleration);
    position.sub(velocity);

    if (position.y > height+radius) {
      toRemove = true;
    }
  }

  int checkHit(float hitX, float hitY, float hitW) {
    if (position.x >= hitX && position.x <= hitX+hitW && position.y >= hitY) {
      // inside hitbox
      toRemove = true;
      return value;
    }
    return 0;
  }
}

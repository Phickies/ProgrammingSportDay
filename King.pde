/*=================
 The king atop the castle, code written by Rosalie, design by Rosalie
 =================*/

class King {
  float xKing = 1600;
  float yKing = 230;

  void display() {
    pushMatrix();
    translate(xKing, yKing);
    stroke(100);
    strokeWeight(5);
    noFill();

    //king
    line(0, 300, 30, 190);  //left leg
    line(60, 300, 30, 190); //right leg
    line(30, 190, 30, 90);  //spine
    line(30, 120, 5, 175);  //left arm
    line(30, 120, 85, 95);  //right arm
    circle(30, 60, 60);    //head
    circle(20, 65, 6);     //eye
    line(10, 57, 20, 48);   //eyebrow
    line(12, 85, 30, 75);   //mouth

    //crown
    fill(#d4af37);
    noStroke();
    triangle(0, 20, 0, 45, 25, 45);
    triangle(0, 45, 40, 45, 15, 20);
    triangle(10, 45, 50, 45, 30, 20);
    triangle(20, 45, 60, 45, 45, 20);
    triangle(30, 45, 60, 45, 60, 20);
    popMatrix();
  }
}

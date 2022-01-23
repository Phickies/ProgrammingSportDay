/*=================
 The castle, code written by Rosalie, asset by Rosalie
 =================*/

class Castle {

  float x;
  float y;
  PImage img;
  Castle() {
    img = loadImage("StoneBrick.png");
    x = width/2;
    y = height/2;
  }

  void display() {
    pushMatrix();
    translate(-(x/2)/12, 0);
    for (int i=0; i < 7; i++) {
      for (int j=0; j < 6; j++) {
        image(img, (2*x)-x/2+i*((x/2)/6), (2*y)-y+j*((y)/6), (x/2)/6, (y)/6);
        image(img, (2*x)-x/2+2*(i*((x/2)/6)), (2*y)-y-((y)/6), (x/2)/6, (y)/6);
      }
    }
    popMatrix();
  }
}

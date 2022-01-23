/*=================
 Sports day program designed and created by Nina, Rosalie, Ata, An
 Move with A and D keys
 All designs and images by Rosalie
 Prompt words: Ruling, Mathematician, Wheelbarrow
 Written in Processing, using Processing documentation, designs in Krita
 =================*/
/*=================
 The main code, game states by An and Nina,
 Remaining code here by An, Nina, and Ata
 =================*/

String gameState;
boolean[] keys;
PImage backgroundImg;
float centerX;
float centerY;

Header header;
Wheelbarrow wheelbarrow;
Castle castle;
Ball[] balls = new Ball[3];
King king = new King();

void setup() {
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  // set state for game start screen
  gameState = "START";
  fullScreen();
  centerX = width/2;
  centerY = height/2;
  backgroundImg = loadImage("Castle_Background.png");
  wheelbarrow = new Wheelbarrow();
  keys = new boolean[2];
  header = new Header();
  castle = new Castle();
  noCursor();
  for (int i = 0; i < balls.length; i++) {
    balls[i] = new Ball();
  }
}

void draw() {
  background(255);//clear background
  if (gameState == "START") {
    startMenu();
  } else if (gameState == "PLAY") {
    mainScene();
  } else if (gameState == "WIN") {
    gameWin();
  } else if (gameState == "GAMEOVER") {
    gameOver();
  } else {
    startMenu();
  }
}

void keyPressed() {
  if (key == 'a') {
    keys[0] = true;
  }
  if (key == 'd') {
    keys[1] = true;
  }
}

void keyReleased() {
  if (key == 'a') {
    keys[0] = false;
  }
  if (key == 'd') {
    keys[1] = false;
  }
}


//============
// maybe add class for managing scenes

void startMenu() {
  background(102, 255, 255);
  fill(0);
  textSize(100);
  text("Tap any where to play", centerX, centerY);
  textSize(50);
  text("Press ESC to exit", centerX, centerY + 150);
  if (mousePressed == true) {
    gameState = "PLAY";
  }
  if (keyPressed == true) {
    if (keyCode == ESC) {
      exit();
    }
  }
}

void mainScene() {
  rectMode(CORNER);
  if (header.t <= 0) {
    gameState = "GAMEOVER";
  } else if (header.score == header.goal) {
    gameState = "WIN";
  }
  image(backgroundImg, 0, 0);
  header.drawHeader();
  king.display();
  castle.display();
  for (int i = 0; i < balls.length; i++) {
    balls[i].display();
    balls[i].update();
    if (balls[i].type == "time") {
      header.startingTime += balls[i].checkHit(wheelbarrow.x, wheelbarrow.y, wheelbarrow.w);
    } else {
      header.score += balls[i].checkHit(wheelbarrow.x, wheelbarrow.y, wheelbarrow.w);
    }
    if (balls[i].toRemove) {
      //throw and add ball
      balls[i] = new Ball();
    }
  }
  wheelbarrow.display();
  wheelbarrow.move(keys);
}

void gameWin() {
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  background(0, 200, 255);
  fill(0);
  textSize(100);
  text("You Win! Well Done!", centerX, centerY);
  textSize(50);
  text("Press ESC to exit", centerX, centerY + 150);
  if (keyPressed == true) {
    if (keyCode == RIGHT) {
      println("game menu");
      gameState = "START";
    } else if (keyCode == ESC) {
      exit();
    }
  }
}


void gameOver() {
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  background(0);
  fill(255);
  textSize(100);
  text("Game Over! D:", centerX, centerY);
  textSize(50);
  text("Press ESC to exit", centerX, centerY + 150);
  if (keyPressed == true) {
    if (keyCode == RIGHT) {
      println("game menu");
      gameState = "START";
    } else if (keyCode == ESC) {
      exit();
    }
  }
}

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

/*=================
 The header containing time, score, goal, code written by An
 =================*/

class Header {
  PFont font;
  String time = "000";
  int t;
  int startingTime = 60;
  float headerHeight; 

  int goal = int(random(40, 65));
  float score = 0;
  Header() {

    //size(300, 300);
    fullScreen();
    headerHeight = height/10;
    font = createFont("Arial", 30);

    textSize(headerHeight/2);
    fill(0);
    t = 1000;
  }

  void drawHeader()
  {
    //header rernder
    stroke(0);
    strokeWeight(2);
    fill(255);
    rect(0, 0, width, headerHeight/2 + 10);


    //Goal text
    fill(0);
    textAlign(CENTER, BASELINE);
    text(int(goal), width/2, headerHeight/2);


    // Current Score
    // If Current Score is higher than Goal, the color will change into Red.
    if ( score > goal ) {
      fill(255, 0, 0);
    } else if ( score == goal ) {
      fill(0, 255, 0);
      // change state to end game (win)
    } else {
      fill(0);
    }
    textAlign(LEFT, BASELINE);
    text("Current Score: " + int(score), width - width/4, headerHeight/2);

    // start counting down
    t = startingTime-int(millis()/1000);
    time = nf(t, 2);

    // check if the time is hit 0 then do what?
    if (t == 0) {

      // change state to end game (loss)
    }

    //print the time
    fill(0);
    textAlign(LEFT, BASELINE);
    text("Time: 00:" + time, 10, headerHeight/2);
  }
}

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

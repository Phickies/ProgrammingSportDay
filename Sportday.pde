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

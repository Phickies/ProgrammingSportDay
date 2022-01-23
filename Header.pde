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

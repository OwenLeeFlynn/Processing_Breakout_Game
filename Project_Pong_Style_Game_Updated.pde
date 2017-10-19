import ddf.minim.*;
Minim minim;
AudioSample ballBounceUp, ballBounceDown, ballBounceSideways, gameOverSound, madWorldSong;

Ball ball1;    // Declaration of a ball object from the Ball class.
Bat playerBat;
int brickRows = 5;
int brickColumns = 10;
Brick[][] bricks = new Brick[brickColumns][brickRows];

int Score = 0;

boolean gameHasStarted = false;

void setup() {
  size (755, 550);
  background(0);
  ball1 = new Ball();
  playerBat = new Bat();
  frameRate = 100;
  setupBricks();
  minim = new Minim(this);
  ballBounceUp  = minim.loadSample("ballBounceUp.wav");
  ballBounceDown = minim.loadSample("ballBounceDown.wav");
  ballBounceSideways = minim.loadSample("ballBounceSideways.wav");
  gameOverSound = minim.loadSample("gameOverSound.wav");
  madWorldSong = minim.loadSample("madWorld.mp3");
}

void draw() {
  if (gameHasStarted == false) {
    background (255);
    fill(0);
    rect(10, 10, width - 20, height - 20);
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(10);
    text("Press Mouse to Start...", width/2, height/2 + 30);
    textSize(35);
    text("BREAKOUT", width/2, height/2 - 30);
  } else if (gameHasStarted == true) {
    background(0);
    if (ball1.gameOver == false) { //If the player has not lost then game then...
      // background(50);
      ball1.draw();
      ball1.move();
      playerBat.draw();
      playerBat.move();
      drawBricks();
      scoreCounter();
    } else
      gameIsLost();
  }
}


void gameIsLost() {
  if (ball1.gameOver == true) {
    background (255);
    fill(0);
    rect(10, 10, width - 20, height - 20);
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(38);
    text("Game Over", width/2, height/2 - 60);
    textSize(27);
    text("Your score was: " + Score + "!", width/2, height/2);
    if (Score <= 10){
      textSize(13);
      text("That was kind of a sad score lmao" , width/2, height/2 + 60);
    }
    else if (Score >= 20){
      textSize(13);
      text("Congrats, you are proficient at using a mouse" , width/2, height/2 + 60);
    }
  }
}

void scoreCounter() {
  textAlign(CENTER, CENTER);
  fill(255);
  textSize(16);
  text("Score: " + Score, width/2, 520);
}

void setupBricks() {
  for (int rows = 0; rows<brickColumns; rows++)
  {
    for (int col = 0; col<brickRows; col++)
    {
      int topLeftOfBrickX = rows*75 + 5;
      int topOfBrickY = col*25 + 5;
      color brickColor = color (random (50, 230), random (50, 230), random (50, 230));
      bricks[rows][col] = new Brick(topLeftOfBrickX, topOfBrickY, color (brickColor));
    }
  }
}
void mousePressed() {
  gameHasStarted = true;
}
void drawBricks() {
  for (int rows = 0; rows<brickColumns; rows++)
  {
    for (int col = 0; col<brickRows; col++)
    {
      if ((ball1.position.y-ball1.radius > bricks[rows][col].brickY) && (ball1.position.y-ball1.radius <= bricks[rows][col].brickY + bricks[rows][col].brickHeight) && (ball1.position.x+ball1.radius < bricks[rows][col].brickX + bricks[rows][col].brickWidth) && (ball1.position.x+ball1.radius > bricks[rows][col].brickX)) {
        //If ball hits bottom of brick
        bricks[rows][col].deactivate();
        ballBounceDown.trigger();
        ball1.velocity.y = -1 * ball1.velocity.y;
        Score++;
      } else if ((ball1.position.y+ball1.radius >= bricks[rows][col].brickY) && (ball1.position.y+ball1.radius < bricks[rows][col].brickY + bricks[rows][col].brickHeight) && (ball1.position.x+ball1.radius < bricks[rows][col].brickX + bricks[rows][col].brickWidth) && (ball1.position.x+ball1.radius > bricks[rows][col].brickX)) {
        //If ball hits top of brick
        bricks[rows][col].deactivate(); 
        ballBounceUp.trigger();
        ball1.velocity.y = -1 * ball1.velocity.y;
        Score++;
      } else if ((ball1.position.y >= bricks[rows][col].brickY) && (ball1.position.y <= bricks[rows][col].brickY + bricks[rows][col].brickHeight) && (ball1.position.x+ball1.radius >= bricks[rows][col].brickX) && (ball1.position.x+ball1.radius < bricks[rows][col].brickX + bricks[rows][col].brickWidth)) {
        //If ball hits left side of brick
        bricks[rows][col].deactivate();  
        ballBounceSideways.trigger();
        ball1.velocity.x = -1 * ball1.velocity.x;
        Score++;
      } else if ((ball1.position.y >= bricks[rows][col].brickY) && (ball1.position.y <= bricks[rows][col].brickY + bricks[rows][col].brickHeight) && (ball1.position.x-ball1.radius <= bricks[rows][col].brickX + bricks[rows][col].brickWidth) && (ball1.position.x+ball1.radius > bricks[rows][col].brickX)) {
        //If ball hits left side of brick
        bricks[rows][col].deactivate(); 
        ballBounceSideways.trigger();
        ball1.velocity.x = -1 * ball1.velocity.x;
        Score++;
      } else
        bricks[rows][col].draw();
    }
  }
}
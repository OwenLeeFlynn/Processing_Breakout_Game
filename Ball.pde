class Ball
{
  PVector position;    // Position of the ball.
  PVector velocity;    // Amount it moves on each redraw.
  float radius;        // Radius of ball.
  color colour;        // Colour of ball.
  boolean gameOver;
  float speedGlobal = 7;
  float batBallOffsetStrength = 2;

  // Initialises the ball's state.
  Ball()
  {
    position = new PVector(width/2, height/2);
    velocity = new PVector(speedGlobal/5, -speedGlobal);
    radius = 9;
    colour   = color(255);
  }

  // Draws the ball at its current position.
  void draw()
  {
    noStroke();
    fill(colour);
    ellipse(position.x, position.y, radius * 2, radius * 2);
  }

  // Moves the ball according to its current velocity.
  void move()
  {
    position.x = position.x + velocity.x;
    position.y = position.y + velocity.y;

    if (position.x-radius < 0 && velocity.x < 0)
    {
      // Escaping to the left, start moving right.
      velocity.x = -1*velocity.x;
      ballBounceSideways.trigger();
    } else if (position.x+radius > width && velocity.x > 0)
    {
      // Escaping to the right, start moving left.
      velocity.x = -1*velocity.x;
      ballBounceSideways.trigger();
    } else if (position.y-radius < 0 && velocity.y < 0)
    {
      // Escaping upwards, start moving down.
      velocity.y = -1*velocity.y;
      ballBounceDown.trigger();
    } else if ((position.y+radius >= 477) && (position.y+radius < 497) && (position.x+radius >= playerBat.batPosTopLeft) && (position.x+radius < playerBat.batPosTopRight) && (playerBat.ballLeftSideOfBat == true)) {
      //Ball has hit bat
      velocity.y = -1*velocity.y;
      velocity.x = -1*(playerBat.distFromMiddleOfBat/15 + batBallOffsetStrength);
      ballBounceUp.trigger();
    } else if ((position.y+radius >= 477) && (position.y+radius < 497) && (position.y-radius < 497) && (position.x-radius <= playerBat.batPosTopRight) && (position.x-radius > playerBat.batPosTopLeft) && (playerBat.ballLeftSideOfBat == false)) {
      //Ball has hit bat
      velocity.y = -1*velocity.y;
      velocity.x = 1*(playerBat.distFromMiddleOfBat/15 + batBallOffsetStrength);
      ballBounceUp.trigger();
    } else if (position.y+radius > height && velocity.y > 0)
    {
      // Ball has hit bottom of screen GAME OVER!
      gameOver = true;
      gameOverSound.trigger();
      madWorldSong.trigger();
    }
  }
}
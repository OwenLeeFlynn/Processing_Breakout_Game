class Brick
{
  color brickColor;
  color originalColor;
  int brickWidth;
  int brickHeight;
  int brickX;
  int brickY;
  boolean brickActive;  
  PVector centerPointXAndY;

  Brick(int tempBrickX, int tempBrickY, color tempColor) 
  {
    brickColor = tempColor;
    brickWidth = 70;
    brickHeight = 20;
    brickX = tempBrickX;
    brickY = tempBrickY;
    brickActive = true;
    originalColor = tempColor;
  }

  void draw() {
    if (brickActive) {
      rectMode(CORNER);
      fill(brickColor);
      rect(brickX, brickY, brickWidth, brickHeight);
    }
  }

  boolean isActive() {
    return brickActive;
  }

  void deactivate() {
    brickActive = false;
    brickColor = (50);
    brickX = -70;
    brickY = -70;
  }

  void centerPoint() {
    centerPointXAndY = new PVector (brickX + brickWidth/2, brickY + brickHeight/2);
  }
}
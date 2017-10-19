class Bat
{
  float batPosTopLeft;
  float batPosTopRight;
  float batPosTopMiddle;
  float distFromMiddleOfBat;
  boolean ballLeftSideOfBat;

  Bat() {
    batPosTopLeft = mouseX - 50;
    batPosTopRight = batPosTopLeft +100;
    batPosTopMiddle = batPosTopLeft + 50;
    distFromMiddleOfBat = dist(batPosTopMiddle, 477, ball1.position.x, ball1.position.y);
  }

  void draw() {
    rect(batPosTopLeft, 477, 100, 20);
  }

  void move() {
    if (mouseX > width - 53) {
      batPosTopLeft =(width - 103);
      checkBatPositions();
    } else if (mouseX < 53) {
      batPosTopLeft = 3;
      checkBatPositions();
    } else 
    batPosTopLeft = (mouseX - 50);
    fill(255);
    checkBatPositions();
  }

  void checkBatPositions() {
    batPosTopRight = batPosTopLeft + 100;
    batPosTopMiddle = batPosTopLeft + 50; 
    distFromMiddleOfBat = dist(batPosTopMiddle, 477, ball1.position.x, ball1.position.y);
    if ((ball1.position.x) < batPosTopMiddle)
    {
      ballLeftSideOfBat = true;
    } else ballLeftSideOfBat = false;
  }
}
import 'dart:ui';
import 'values.dart';
import 'snakepart.dart';
import 'dart:math';

class Snake{
  // position of snake
  // snakePartList[0] is always the head of the snake
  // snakePartList[snakeLength-1] is always tail of snake
  List<SnakePart> snakePartList = [];
  List<int> foodList= [];
  Direction headDirection = Direction.up;
  Color color = const Color(0xFFFF3D00);
  Snake({required this.snakeLength});
  int snakeLength = 0;
  int foodAmount = 10;

  void initializeSnake(){
    Random rand = Random();
    // get random row
    int getRandomRow = rand.nextInt(colLength);
    // get random column
    int getRandomCol = rand. nextInt(rowLength);
    // pick between the above two to begin initializing snake
    bool randomRowCol = rand.nextBool();


    // set row minimum and row maximum
    int rowMin = (getRandomRow*10)+2;
    int rowMax = ((getRandomRow*10)+9)-2;
    // set column minimum and maximum
    int colMin = getRandomCol + 30;
    int colMax = (colLength*rowLength) - 21;


    // start position between min and max
    int randomRowPositionStart = rowMin + rand.nextInt(rowMax - rowMin);
    int randomColPositionStart = colMin + rand.nextInt(colMax - colMin);
    // if true, snake appears on row
    if(randomRowCol){
      // determine direction
      Direction initializeDirection = rand.nextBool()? Direction.right : Direction.left;
      if(initializeDirection == Direction.right){
        for(int i =0; i< snakeLength; i++){

          snakePartList.add(SnakePart(currentPixel:randomRowPositionStart + i));
          headDirection = Direction.left;
          snakePartList[i].previousPixel = randomRowPositionStart - i;

        }
      }else{
        for(int i =0; i< snakeLength; i++){

          snakePartList.add(SnakePart(currentPixel:randomRowPositionStart - i));
          headDirection = Direction.right;
          snakePartList[i].previousPixel = randomRowPositionStart + i;

        }
      }
    //else snake starts column
    }// if
    else{
      Direction initializeDirection = rand.nextBool()? Direction.up : Direction.down;
      if(initializeDirection == Direction.up){
        for(int i =0; i< snakeLength; i++){

          snakePartList.add(SnakePart(currentPixel:randomColPositionStart - (i*10)));
          headDirection = Direction.down;
          snakePartList[i].previousPixel = randomColPositionStart + (i*10);
        }// for loop

      }// if
      else{
        for(int i =0; i< snakeLength; i++){

          snakePartList.add(SnakePart(currentPixel:randomColPositionStart + (i*10)));
          headDirection = Direction.up;
          snakePartList[i].previousPixel = randomColPositionStart - (i*10);

        }// for loop
      }// else
    }// else
    generateFood();
  }// initializeSnake
  void generateFood(){
    Random rand = Random();

    for(int i= 0; i<foodAmount;i++){
      foodList.add(rand.nextInt(150));
    }

  }
  void moveSnakeHead(Direction direction){
    headDirection = direction;

    switch(direction){
      case Direction.down:
        snakePartList[0].previousPixel =snakePartList[0].currentPixel;
        snakePartList[0].currentPixel+=rowLength;

        break;
      case Direction.left:
        snakePartList[0].previousPixel =snakePartList[0].currentPixel;
        snakePartList[0].currentPixel-=1;

        break;
      case Direction.right:
        snakePartList[0].previousPixel =snakePartList[0].currentPixel;
        snakePartList[0].currentPixel+=1;

        break;
      case Direction.up:
        snakePartList[0].previousPixel =snakePartList[0].currentPixel;
        snakePartList[0].currentPixel-=rowLength;

        break;
      default:

    }//end switch

  }//end moveSnakeHead function

  void moveSnakeBody(){

    for(int i =1; i< snakeLength; i++){
      snakePartList[i].previousPixel = snakePartList[i].currentPixel;
      snakePartList[i].currentPixel = snakePartList[i-1].previousPixel;
    }

  }// moveSnakeBody function

}// end class



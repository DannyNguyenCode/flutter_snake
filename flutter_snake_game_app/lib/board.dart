import 'package:flutter/material.dart';
import 'package:flutter_snake_game_app/snake.dart';
import 'package:flutter_snake_game_app/snakepart.dart';
import 'values.dart';
import 'pixel.dart';
import 'dart:async';
class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  Snake snake = Snake(snakeLength:3);
  Direction setDirection = Direction.forward;
  int scoreCounter = 0;
  int gameSpeed = 0;
  @override
  void initState(){
    super.initState();
    setGameSpeed(scoreCounter);
    startGame();
  }
  void setGameSpeed(int score){
    if(score == 0){
      gameSpeed= 1000;
    }else if(score == 10){
      gameSpeed = 500;
    }else if(score == 20){
      gameSpeed = 200;
    }else if(score == 30){
      gameSpeed = 100;
    }

  }
  void setMap(){

  }
  void startGame(){
    snake.initializeSnake();
    Duration frameRate = Duration(milliseconds: gameSpeed);
    gameLoop(frameRate);
  }
  void nextLevel(){

    setGameSpeed(scoreCounter);
    startGame();
  }
  bool isGameOver(){
    // turn snakePartList into a list to iterate through;
    List<int> currentPixelsList = snake.snakePartList.map((snakePart)=>snakePart.currentPixel).toList();

    for(int i = 1; i < snake.snakeLength; i++){
      // if any snakePart position is equal to the head of the snake, then game over
      if(currentPixelsList[i] == currentPixelsList[0]){
        return true;
      }
    }
    // otherwise game continues
    return false;

  }
  void gameLoop(Duration frameRate){
    Timer.periodic(
        frameRate,
            (timer){
          setState(() {

            switch(setDirection){
              case Direction.left:
                if(snake.headDirection !=Direction.right){
                  moveLeft();
                }else{
                  moveForward();
                }
                break;
              case Direction.right:
                if(snake.headDirection !=Direction.left){
                  moveRight();
                }else{
                  moveForward();
                }

                break;
              case Direction.up:
                if(snake.headDirection !=Direction.down){
                  moveUp();
                }else{
                  moveForward();
                }

                break;
              case Direction.down:
                if(snake.headDirection !=Direction.up){
                  moveDown();
                }else{
                  moveForward();
                }
                break;
              default:
                moveForward();
            }
            if(snake.foodList.isEmpty){
              timer.cancel();
              nextLevel();
            }
            if(isGameOver()){
              timer.cancel();

            }


          });
        });
  }

  void moveForward(){
    if(!checkCollision(snake.headDirection)){
      snake.moveSnakeHead(snake.headDirection);
      snake.moveSnakeBody();
      snakeAteFood();
    }
  }
  void moveLeft(){
    if(!checkCollision(Direction.left)){
      setState(() {
        snake.moveSnakeHead(Direction.left);
        snake.moveSnakeBody();
        snakeAteFood();
      });
    }
  }
  void moveRight(){
    if(!checkCollision(Direction.right)){
      setState(() {
        snake.moveSnakeHead(Direction.right);
        snake.moveSnakeBody();
        snakeAteFood();
      });
    }
  }
  void moveUp(){
    if(!checkCollision(Direction.up)){
      setState(() {
        snake.moveSnakeHead(Direction.up);
        snake.moveSnakeBody();
        snakeAteFood();
      });
    }
  }
  void moveDown(){
    if(!checkCollision(Direction.down)){
      setState(() {
        snake.moveSnakeHead(Direction.down);
        snake.moveSnakeBody();
        snakeAteFood();
      });
    }
  }

  bool checkCollision(Direction direction){

    int row = (snake.snakePartList[0].currentPixel / rowLength).floor();
    int col = snake.snakePartList[0].currentPixel % rowLength;

    if(direction == Direction.left){
      col -= 1;
    }else if(direction == Direction.right){
      col += 1;
    }else if(direction == Direction.down){
      row += 1;
    }else if(direction == Direction.up){
      row -= 1;
    }
    if(row >= colLength || col < 0 || col>=rowLength || row < 0){
      return true;
    }

    return false;
  }
  void snakeAteFood(){
    if(snake.foodList.contains(snake.snakePartList[0].currentPixel)){
      snake.foodList.remove(snake.snakePartList[0].currentPixel);
      snake.snakeLength++;
      snake.snakePartList.add(SnakePart(currentPixel: snake.snakePartList[snake.snakeLength -2].previousPixel));

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
                itemCount: rowLength * colLength,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: rowLength),
                itemBuilder: (context,index){
                  if(snake.snakePartList.map((snakePart)=> snakePart.currentPixel).contains(index)){
                    if(index == snake.snakePartList[0].currentPixel){
                      return Pixel(
                        color:snake.color,
                        child: const Text(''),
                      );
                    }else{
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Pixel(
                          color:snake.color,
                          child: const Text(''),
                        ),
                      );
                    }

                  }else if(snake.foodList.map((food)=> food).contains(index)){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Pixel(
                        color:Colors.brown[200] as Color,
                        child: const Text(''),
                      ),
                    );
                  }
                  else{
                    return Pixel(
                      color: Colors.grey[900] as Color,
                      child:Text(
                        index.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom:50.0, top: 50.0),
            child: Column(
              children: [
                IconButton(
                    onPressed:()=>setDirection=Direction.up,
                    icon: const Icon(Icons.arrow_upward)
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: ()=>setDirection=Direction.left,
                        icon: const Icon(Icons.arrow_left)
                    ),
                    IconButton(
                        onPressed: ()=>setDirection=Direction.right,
                        icon: const Icon(Icons.arrow_right)
                    ),
                  ],
                ),
                IconButton(
                    onPressed:()=>setDirection=Direction.down,
                    icon: const Icon(Icons.arrow_downward)
                ),
              ],
            )
          )
        ],
      ),
    );
  }
}
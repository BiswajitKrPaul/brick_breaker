import 'dart:async';

import 'package:brick_breaker/constants/constants.dart';
import 'package:brick_breaker/widgets/game_controller.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List breaker = [...kBreaker];

  List ball = [...kBall];
  List brick = [...kBrick];
  Direction direction;
  BallDirection ballDirection = BallDirection.Down;
  bool isGameStarted = false;
  bool isGameOver = false;
  Timer timer;

  void startGame() {
    isGameStarted = true;
    isGameOver = false;
    timer = Timer.periodic(Duration(milliseconds: 60), (timer) {
      setState(() {
        if (isGameOver) {
          timer.cancel();
          restart();
        } else {
          moveBall();
        }
      });
    });
  }

  void restart() {
    setState(() {
      isGameStarted = false;
      ball = [...kBall];
      brick = [...kBrick];
      breaker = [...kBreaker];
      ballDirection = BallDirection.Down;
    });
  }

  bool hasBallHitBrick() {
    for (int i = 0; i < brick.length; i++) {
      if (brick[i].last == ball.first[1] && brick[i].first == ball.first[0]) {
        if (ballDirection == BallDirection.Up) {
          ballDirection = BallDirection.Down;
        } else if (ballDirection == BallDirection.LeftDiagonalUp) {
          ballDirection = BallDirection.RightDiagonalDown;
        } else if (ballDirection == BallDirection.RightDiagonalUp) {
          ballDirection = BallDirection.leftDiagonalDown;
        }
        brick.removeAt(i);
        return true;
      }
    }
    return false;
  }

  void moveBall() {
    /* 1. Check if the ball is hitting the floor
       2. Check if the ball is hitting the brick
       3. Check if the ball is Breaker
    */
    if (ball.first[0] != kTotalNoColumn - 1) {
      if (ballDirection == BallDirection.Down) {
        if (ball.first[0] == kTotalNoColumn - 2) {
          if (breaker[1].last == ball.first[1] ||
              breaker[2].last == ball.first[1]) {
            ballDirection = BallDirection.Up;
          } else if (breaker[0].last == ball.first[1]) {
            ballDirection = BallDirection.LeftDiagonalUp;
          } else if (breaker[3].last == ball.first[1]) {
            ballDirection = BallDirection.RightDiagonalUp;
          } else {
            ball.insert(0, [ball.first[0] + 1, ball.first[1]]);
            ball.removeLast();
            ballDirection = BallDirection.Down;
          }
        } else {
          ballDirection = BallDirection.Down;
          ball.insert(0, [ball.first[0] + 1, ball.first[1]]);
        }
      }
      if (ballDirection == BallDirection.Up) {
        if (hasBallHitBrick()) {
          ball.insert(0, [ball.first[0] + 1, ball.first[1]]);
          ball.removeLast();
        } else if (ball.first[0] <= 0) {
          ball.insert(0, [ball.first[0] + 1, ball.first[1]]);
          ball.removeLast();
          ballDirection = BallDirection.Down;
        } else {
          ball.insert(0, [ball.first[0] - 1, ball.first[1]]);
          ballDirection = BallDirection.Up;
        }
      }
      if (ballDirection == BallDirection.LeftDiagonalUp) {
        if (hasBallHitBrick()) {
          // right diagonal down
          ball.insert(0, [ball.last[0] + 1, ball.last[1] + 1]);
          ball.removeLast();
        } else if (ball.first[0] <= 0) {
          ball.insert(0, [ball.last[0] + 1, ball.last[1] + 1]);
          ballDirection = BallDirection.RightDiagonalDown;
          ball.removeLast();
        } else if (ball.first[1] <= 0) {
          ball.insert(0, [ball.last[0] - 1, ball.last[1] + 1]);
          ball.removeLast();
          ballDirection = BallDirection.RightDiagonalUp;
        } else {
          ball.insert(0, [ball.first[0] - 1, ball.first[1] - 1]);
          ballDirection = BallDirection.LeftDiagonalUp;
        }
      }
      if (ballDirection == BallDirection.RightDiagonalUp) {
        if (hasBallHitBrick()) {
          //left diagonal down
          ball.insert(0, [ball.first[0] + 1, ball.first[1] - 1]);
          ball.removeLast();
        } else if (ball.first[0] <= 0) {
          ball.insert(0, [ball.first[0] + 1, ball.first[1] - 1]);
          ballDirection = BallDirection.leftDiagonalDown;
          ball.removeLast();
        } else if (ball.first[1] == kTotalNoRow - 1) {
          ball.insert(0, [ball.first[0] - 1, ball.first[1] - 1]);
          ball.removeLast();
          ballDirection = BallDirection.LeftDiagonalUp;
        } else {
          ball.insert(0, [ball.last[0] - 1, ball.last[1] + 1]);
          ballDirection = BallDirection.RightDiagonalUp;
        }
      }
      if (ballDirection == BallDirection.RightDiagonalDown) {
        if (ball.first[1] == kTotalNoRow - 1) {
          ball.insert(0, [ball.first[0] + 1, ball.first[1] - 1]);
          ball.removeLast();
          ballDirection = BallDirection.leftDiagonalDown;
        } else if (ball.first[0] == kTotalNoColumn - 2) {
          if (breaker[1].last == ball.first[1] ||
              breaker[2].last == ball.first[1]) {
            ballDirection = BallDirection.Up;
          } else if (breaker[0].last == ball.first[1]) {
            ballDirection = BallDirection.LeftDiagonalUp;
          } else if (breaker[3].last == ball.first[1]) {
            ballDirection = BallDirection.RightDiagonalUp;
          } else {
            ball.insert(0, [ball.last[0] + 1, ball.last[1] + 1]);
            ballDirection = BallDirection.RightDiagonalDown;
            ball.removeLast();
          }
        } else {
          ball.insert(0, [ball.last[0] + 1, ball.last[1] + 1]);
          ballDirection = BallDirection.RightDiagonalDown;
        }
      }
      if (ballDirection == BallDirection.leftDiagonalDown) {
        if (ball.first[1] <= 0) {
          ballDirection = BallDirection.RightDiagonalDown;
          ball.insert(0, [ball.first[0] + 1, ball.first[1] + 1]);
          ball.removeLast();
        } else if (ball.first[0] == kTotalNoColumn - 2) {
          if (breaker[1].last == ball.first[1] ||
              breaker[2].last == ball.first[1]) {
            ballDirection = BallDirection.Up;
          } else if (breaker[0].last == ball.first[1]) {
            ballDirection = BallDirection.LeftDiagonalUp;
          } else if (breaker[3].last == ball.first[1]) {
            ballDirection = BallDirection.RightDiagonalUp;
          } else {
            ball.insert(0, [ball.first[0] + 1, ball.first[1] - 1]);
            ballDirection = BallDirection.leftDiagonalDown;
            ball.removeLast();
          }
        } else {
          ball.insert(0, [ball.first[0] + 1, ball.first[1] - 1]);
          ballDirection = BallDirection.leftDiagonalDown;
        }
      }
      if (ball.length > 1) {
        ball.removeLast();
      }
    } else {
      print('Game Over');
      isGameOver = true;
    }
  }

  void moveBreaker(Direction direction) {
    if (direction == Direction.left) {
      if (breaker.first[1] != 0) {
        breaker.insert(0, [breaker.first[0], breaker.first[1] - 1]);
        breaker.removeLast();
      }
    } else if (direction == Direction.right) {
      if (breaker.last[1] != kTotalNoRow - 1) {
        breaker.insert(breaker.length, [breaker.last[0], breaker.last[1] + 1]);
        breaker.removeAt(0);
      }
    }
    setState(() {
      this.direction = direction;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Brick Breaker',
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: restart,
            icon: Icon(Icons.restart_alt),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: isGameStarted ? null : startGame,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    child: AspectRatio(
                      aspectRatio: kTotalNoRow / kTotalNoColumn,
                      child: Container(
                        color: Colors.transparent,
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: kTotalNoRow,
                          ),
                          itemCount: kTotalNoRow * kTotalNoColumn,
                          itemBuilder: (BuildContext context, int index) {
                            int rowY = index % kTotalNoRow;
                            int rowX = (index / kTotalNoRow).floor();
                            bool isBreaker = false;
                            bool isBrick = false;
                            BoxShape shape = BoxShape.rectangle;

                            Color color;
                            for (var pos in breaker) {
                              if (pos[0] == rowX && pos[1] == rowY) {
                                isBreaker = true;
                                break;
                              }
                            }

                            for (var pos in brick) {
                              if (pos[0] == rowX && pos[1] == rowY) {
                                isBrick = true;
                                break;
                              }
                            }

                            if (isBreaker) {
                              color = Colors.red;
                              shape = BoxShape.rectangle;
                            } else if (isBrick) {
                              color = Colors.deepPurple;
                              shape = BoxShape.rectangle;
                            } else if (rowX == ball.first[0] &&
                                rowY == ball.first[1]) {
                              color = Colors.green;
                              shape = BoxShape.circle;
                            } else {
                              color = Colors.transparent;
                              shape = BoxShape.rectangle;
                            }

                            return Container(
                              margin: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: color,
                                shape: shape,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GameController(
                    direction: direction,
                    function: moveBreaker,
                  ),
                ),
              ],
            ),
            isGameStarted
                ? Container()
                : Container(
                    height: 200,
                    width: 150,
                    color: Colors.black54,
                    child: Center(
                      child: Text(
                        'Tap to play',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

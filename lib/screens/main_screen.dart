import 'package:brick_breaker/constants/constants.dart';
import 'package:brick_breaker/widgets/game_controller.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final breaker = [
    [29, 7],
    [29, 8],
    [29, 9],
    [29, 10],
  ];

  List ball = [
    [15, 8]
  ];

  List brick = [
    [0, 0],
    [0, 1],
    [0, 2],
    [0, 3],
    [0, 4],
    [0, 5],
    [0, 6],
    [0, 7],
    [0, 8],
    [0, 9],
    [0, 10],
    [0, 11],
    [0, 12],
    [0, 13],
    [0, 14],
    [0, 15],
    [0, 16],
    [0, 17],
    [1, 0],
    [1, 1],
    [1, 2],
    [1, 3],
    [1, 4],
    [1, 5],
    [1, 6],
    [1, 7],
    [1, 8],
    [1, 9],
    [1, 10],
    [1, 11],
    [1, 12],
    [1, 13],
    [1, 14],
    [1, 15],
    [1, 16],
    [1, 17],
    [2, 0],
    [2, 1],
    [2, 2],
    [2, 3],
    [2, 4],
    [2, 5],
    [2, 6],
    [2, 7],
    [2, 8],
    [2, 9],
    [2, 10],
    [2, 11],
    [2, 12],
    [2, 13],
    [2, 14],
    [2, 15],
    [2, 16],
    [2, 17],
    [3, 0],
    [3, 1],
    [3, 2],
    [3, 3],
    [3, 4],
    [3, 5],
    [3, 6],
    [3, 7],
    [3, 8],
    [3, 9],
    [3, 10],
    [3, 11],
    [3, 12],
    [3, 13],
    [3, 14],
    [3, 15],
    [3, 16],
    [3, 17],
    [4, 0],
    [4, 1],
    [4, 2],
    [4, 3],
    [4, 4],
    [4, 5],
    [4, 6],
    [4, 7],
    [4, 8],
    [4, 9],
    [4, 10],
    [4, 11],
    [4, 12],
    [4, 13],
    [4, 14],
    [4, 15],
    [4, 16],
    [4, 17],
  ];
  Direction direction;
  bool isGameStarted = false;

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
        title: Text(
          'Brick Breaker',
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
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
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: kTotalNoRow,
                    ),
                    itemCount: kTotalNoRow * kTotalNoColumn,
                    itemBuilder: (BuildContext context, int index) {
                      int rowY = index % kTotalNoRow;
                      int rowX = (index / kTotalNoRow).floor();
                      bool isBreaker = false;
                      bool isBrick = false;
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
                      } else if (isBrick) {
                        color = Colors.deepPurple;
                      } else if (rowX == ball.first[0] &&
                          rowY == ball.first[1]) {
                        color = Colors.green;
                      } else {
                        color = Colors.transparent;
                      }

                      return Container(
                        margin: EdgeInsets.all(1),
                        color: color,
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
    );
  }
}

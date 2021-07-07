import 'package:brick_breaker/constants/constants.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
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

                      return Container(
                        margin: EdgeInsets.all(1),
                        color: Colors.grey,
                        child: FittedBox(child: Text('$rowX,$rowY')),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}

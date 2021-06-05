import 'package:app/gameWidgets/gameGrid.dart';
import 'package:flutter/material.dart';

class GameWidget extends StatefulWidget {

  final double width;
  final double height;

  const GameWidget({
    required this.width,
    required this.height,
    Key? key
  }) : super(key: key);

  @override
  _GameWidgetState createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {

  bool playing = false;

  @override
  Widget build(BuildContext context) {
    if (playing) {
      return GameGrid(
        width: widget.width,
        height: widget.height,
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            child: Container(
              width: widget.width * 0.4,
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 7.0, bottom: 7.0),
              child: Text(
                "Play",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: widget.width * 0.07,
                  fontWeight: FontWeight.bold,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.green[600],
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
            onTap: () {
              setState(() {
                playing = true;
              });
            },
          ),
        ],
      );
    }
  }
}

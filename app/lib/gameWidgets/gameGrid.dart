import 'package:flutter/material.dart';

class GameGrid extends StatefulWidget {

  final double width;
  final double height;

  const GameGrid({
    required this.width,
    required this.height,
    Key? key
  }) : super(key: key);

  @override
  _GameGridState createState() => _GameGridState();
}

class _GameGridState extends State<GameGrid> {

  List gameState = [" ", " ", " ", " ", " ", " ", " ", " ", " "];

  // This function will return X and O based on the rawText
  String gridText(String rawText) {
    if (rawText == "x") {
      return "╳";
    } else if (rawText == "o"){
      return  "O";
    } else {
      return " ";
    }
  }

  // This function will display a grid item and
  // Will validate and pass input into the bloc
  Widget gridItem(index) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        child: Text(
          gridText(gameState[index]),
          style: TextStyle(
            color: Colors.green[600],
            fontSize: widget.width * 0.2,
            fontWeight: FontWeight.bold
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green[600]!)
        ),
      ),
      onTap: () {
        if (gameState[index] == " ") {
          setState(() {
            gameState[index] = "x";
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width * 0.9,
      height: widget.width * 0.9,
      child: GridView.builder(
        itemCount: 9,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return gridItem(index);
        }
      ),
    );
  }
}

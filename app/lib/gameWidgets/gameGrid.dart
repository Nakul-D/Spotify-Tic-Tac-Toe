import 'package:flutter/material.dart';
import 'package:app/logic/gameBloc.dart';
import 'package:app/logic/gameEvents.dart';

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

  late GameController gameController;
  String gameState = "Playing";
  List gridState = [" ", " ", " ", " ", " ", " ", " ", " ", " "];

  void initState() {
    gameController = GameController();
    super.initState();
    NewGameEvent event = NewGameEvent();
    gameController.add(event);
  }

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
          gridText(gridState[index]),
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
        if (gridState[index] == " ") {
          PlayerInputEvent event = PlayerInputEvent(
            index: index
          );
          gameController.add(event);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: gameController.stream,
      builder: (context, AsyncSnapshot<Map> snapshot) {
        print(snapshot.data);
        if (snapshot.data != null) {
          Map data = snapshot.data!;
          gridState = data["gridState"];
          gameState = data["gameState"];
        }
        if (gameState == "Playing") {
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
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "$gameState",
                style: TextStyle(
                  color: Colors.green[600],
                  fontSize: widget.width * 0.1,
                  fontWeight: FontWeight.bold
                ),
              ),
              GestureDetector(
                child: Container(
                  width: widget.width * 0.6,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 7.0, bottom: 7.0),
                  child: Text(
                    "Play again",
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
                  NewGameEvent event = NewGameEvent();
                  gameController.add(event);
                },
              ),
            ],
          );
        }
      }
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';
import 'package:app/logic/gameEvents.dart';

List winningConditions = [
  [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]
];

class GameController extends Bloc<GameEvents, Map> {

  GameController() : super({});

  List gridState = [" ", " ", " ", " ", " ", " ", " ", " ", " "];

  @override
  Stream<Map> mapEventToState(GameEvents event) async* {
    
    if (event is NewGameEvent) {
      gridState = [" ", " ", " ", " ", " ", " ", " ", " ", " "];
      yield {
        "gameState": "Playing",
        "gridState": gridState,
      };
    }

    if (event is PlayerInputEvent) {
      gridState[event.index] = "x";
      String gameState = "Playing";
      if(_checkTie(gridState)) {
        gameState = "Tie";
      }
      if (_checkWin(gridState)) {
        gameState = "x won";
      }
      if (gameState == "Playing") {
        gridState[_algorithm(gridState)] = "o";
        if(_checkTie(gridState)) {
          gameState = "Tie";
        }
        if (_checkWin(gridState)) {
          gameState = "o won";
        }
      }
      yield {
        "gameState": gameState,
        "gridState": gridState,
      };
    }

  }
}

// This function will check if the game is won
bool _checkWin(List gridState) {
  bool result = false;
  winningConditions.forEach((condition) {
    bool r1 = gridState[condition[0]] == gridState[condition[1]];
    bool r2 = gridState[condition[1]] == gridState[condition[2]];
    bool r3 = gridState[condition[0]] == gridState[condition[2]];
    bool r4 = gridState[condition[2]] != " ";
    if (r1 && r2 && r3 && r4) {
      result = true;
    }
  });
  return result;
}

// This function will check if the game is a tie
bool _checkTie(List gameState) {
  bool result = true;
  if (gameState.contains(" ")) {
    result = false;
  }
  return result;
}

// This function will play against the player
int _algorithm(List gridState) {
  late int result;
  while (true) {
    final random = new Random();
    result = random.nextInt(8);
    if (gridState[result] == " "){
      break;
    }
  }
  String checkFor = "x";
  for (int i = 0; i < 2; i++) {
    winningConditions.forEach((condition) {
      bool r1 = gridState[condition[0]] == gridState[condition[1]];
      bool r2 = gridState[condition[1]] == gridState[condition[2]];
      bool r3 = gridState[condition[0]] == gridState[condition[2]];
      if (r1 && (gridState[condition[1]] == checkFor)) {
        if (gridState[condition[2]] == " ") result = condition[2];
      }
      if (r2 && (gridState[condition[2]] == checkFor)) {
        if (gridState[condition[0]] == " ") result = condition[0];
      }
      if (r3 && (gridState[condition[2]] == checkFor)) {
        if (gridState[condition[1]] == " ") result = condition[1];
      }
    });
    checkFor = "o";
  }
  return result;
}

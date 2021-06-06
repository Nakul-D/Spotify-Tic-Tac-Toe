import 'package:flutter_test/flutter_test.dart';
import 'package:app/logic/gameBloc.dart';
import 'package:app/logic/gameEvents.dart';

void main() {

  test("Initial gridState test", () {
    final gameController = GameController();
    expect(
      gameController.gridState,
      [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    );
  });

  test('Player win test', () {
    final gameController = GameController();
    gameController.gridState = ["x", " ", "x", "o", "x", " ", "o", " ", "o"];
    PlayerInputEvent playerInputEvent = PlayerInputEvent(index: 1);
    gameController.mapEventToState(playerInputEvent).listen((data) {
      expect(
        data,
        {
          "gameState": "x won",
          "gridState": ["x", "x", "x", "o", "x", " ", "o", " ", "o"],
        }
      );
    });
  });

  test("Algorithm win test", () {
    final gameController = GameController();
    gameController.gridState = ["x", " ", " ", " ", "x", " ", "o", " ", "o"];
    PlayerInputEvent playerInputEvent = PlayerInputEvent(index: 1);
    gameController.mapEventToState(playerInputEvent).listen((data) {
      expect(
        data,
        {
          "gameState": "o won",
          "gridState": ["x", "x", " ", " ", "x", " ", "o", "o", "o"],
        }
      );
    });
  });

  test("Tie test", () {
    final gameController = GameController();
    gameController.gridState = ["x", "o", "x", " ", "x", "o", "o", "x", "o"];
    PlayerInputEvent playerInputEvent = PlayerInputEvent(index: 3);
    gameController.mapEventToState(playerInputEvent).listen((data) {
      expect(
        data,
        {
          "gameState": "Tie",
          "gridState": ['x', 'o', 'x', 'x', 'x', 'o', 'o', 'x', 'o'],
        }
      );
    });
  });

}

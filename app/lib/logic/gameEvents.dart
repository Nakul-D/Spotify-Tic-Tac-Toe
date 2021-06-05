abstract class GameEvents {}

class NewGameEvent extends GameEvents {}

class PlayerInputEvent extends GameEvents {
  int index;
  PlayerInputEvent({required this.index});
}

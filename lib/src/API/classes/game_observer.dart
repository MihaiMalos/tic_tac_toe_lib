import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

abstract interface class GameObserver {
  void onPlaceMark(Position pos, bool isComputerMove);
  void onGameOver(GameStatus state);
  void onTimerTick(Duration remainingTime);
}

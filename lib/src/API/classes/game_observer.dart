import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

abstract interface class GameObserver {
  void onPlaceMark(Position pos);
  void onGameOver(GameEvent state);
}

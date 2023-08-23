import 'package:tic_tac_toe_lib/src/API/position.dart';
import 'package:tic_tac_toe_lib/src/enums/game_state.dart';

abstract interface class GameObserver {
  void onPlaceMark(Position pos);
  void onGameOver(GameState state);
}

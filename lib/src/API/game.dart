import 'package:tic_tac_toe_lib/src/API/game_observer.dart';
import 'package:tic_tac_toe_lib/src/API/position.dart';
import 'package:tic_tac_toe_lib/src/classes/game_impl.dart';
import 'package:tic_tac_toe_lib/src/enums/mark.dart';

abstract class Game {
  factory Game.create() => GameImpl();

  void placeMark(Position pos);
  Mark getBoardElement(Position pos);
  Mark get turn;

  bool addObserver(GameObserver observer);
  bool removeObserver(GameObserver observer);
}

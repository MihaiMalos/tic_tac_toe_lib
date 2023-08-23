import 'package:tic_tac_toe_lib/src/classes/game_impl.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

abstract class Game {
  factory Game.create({Strategy strategy = Strategy.twoPlayers}) =>
      GameImpl(strategy: strategy);

  Mark get turn;
  int get boardSize;
  Board get board;

  void placeMark(Position pos);

  bool addObserver(GameObserver observer);
  bool removeObserver(GameObserver observer);
}

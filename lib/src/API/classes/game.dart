import 'package:tic_tac_toe_lib/src/internals/classes/game_impl.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

abstract class Game {
  factory Game.create({
    Strategy strategy = Strategy.twoPlayers,
    Duration computerMoveDuration = const Duration(seconds: 1),
  }) =>
      GameImpl(strategy: strategy, computerMoveDuration: computerMoveDuration);

  Mark get turn;
  int get boardSize;
  MarkMatrix get boardRepresentation;
  GameStrategy? get strategy;

  set setStrategy(GameStrategy strategy);
  Future<void> placeMark(Position pos);

  void restart();

  bool addObserver(GameObserver observer);
  bool removeObserver(GameObserver observer);
}

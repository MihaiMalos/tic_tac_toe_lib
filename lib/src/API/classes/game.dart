import 'package:tic_tac_toe_lib/src/internals/classes/game_impl.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

abstract class Game {
  factory Game.create({
    Strategy strategy = Strategy.twoPlayers,
    Duration timerMoveDuration = const Duration(seconds: 5),
    Duration timerResolution = const Duration(milliseconds: 10),
  }) =>
      GameImpl(
        strategy: strategy,
        timerMoveDuration: timerMoveDuration,
        timerResolution: timerResolution,
      );

  Mark get turn;
  int get boardSize;
  MarkMatrix get boardRepresentation;
  Strategy get strategy;

  void startTimer();
  void stopTimer();
  Duration get timerDuration;
  Duration get timerElapsedTime;

  set strategy(Strategy strategy);
  Future<void> placeMark(Position pos);

  void restart();

  bool addObserver(GameObserver observer);
  bool removeObserver(GameObserver observer);
}

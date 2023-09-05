import 'dart:math';

import 'package:tic_tac_toe_lib/src/internals/classes/board_impl.dart';
import 'package:tic_tac_toe_lib/src/internals/classes/game_timer.dart';
import 'package:tic_tac_toe_lib/src/internals/classes/strategies/easy_strategy.dart';
import 'package:tic_tac_toe_lib/src/internals/classes/strategies/hard_strategy.dart';
import 'package:tic_tac_toe_lib/src/internals/classes/strategies/medium_strategy.dart';
import 'package:tic_tac_toe_lib/src/internals/enums/game_state.dart';
import 'package:tic_tac_toe_lib/src/internals/interfaces/timer_observer.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

class GameImpl extends GameObservable implements Game, TimerObserver {
  final BoardImpl _board;
  Mark _turn;
  GameState _state;
  GameStrategy? _strategy;
  final GameTimer _timer;

  GameImpl({
    required Strategy strategy,
    required Duration timerMoveDuration,
    required Duration timerResolution,
  })  : _board = BoardImpl(),
        _turn = Mark.x,
        _state = GameState.playing,
        _strategy = strategy.convertToObj,
        _timer = GameTimer(
          moveDuration: timerMoveDuration,
          resolution: timerResolution,
        ) {
    _timer.addObserver(this);
  }

  GameImpl.fromString(
    CharMatrix board,
    Mark turn,
    GameState state, [
    Strategy strategy = Strategy.twoPlayers,
    Duration timerMoveDuration = const Duration(seconds: 5),
    Duration timerResolution = const Duration(milliseconds: 10),
  ])  : _board = BoardImpl.fromString(board),
        _turn = turn,
        _state = state,
        _strategy = strategy.convertToObj,
        _timer = GameTimer(
          moveDuration: timerMoveDuration,
          resolution: timerResolution,
        ) {
    _timer.addObserver(this);
  }

  @override
  Mark get turn => _turn;
  @override
  int get boardSize => BoardImpl.size;
  @override
  MarkMatrix get boardRepresentation => MarkMatrix.from(_board.configuration);
  @override
  GameStrategy? get strategy => _strategy;

  @override
  set setStrategy(GameStrategy? strategy) => _strategy = strategy;

  void _changeTurn() => _turn = _turn.opposite;
  void _changeState(GameState state) => _state = state;

  @override
  void startTimer() => _timer.start();
  @override
  void stopTimer() => _timer.stop();
  @override
  Duration get timerDuration => _timer.timerDuration;

  @override
  void restart() {
    _board.reset();
    _state = GameState.playing;
    _turn = Mark.x;
    _timer.restart();
  }

  @override
  Future<void> placeMark(Position pos) async {
    if (_state.isGameOver) {
      throw GameOverException("Game is over, can't make anymore moves.");
    }
    if (_state.isPaused) {
      throw WaitingMoveException(
          "There is already a move in progress. Wait for it ti finish.");
    }
    await makeMove(pos, false);
    if (!_state.isGameOver) _timer.restart();
    if (_strategy != null && !_state.isGameOver) {
      // find a way to not duplicate code
      Position computerPos = _strategy!.getComputerPos(_board, _turn);
      await makeMove(computerPos, true);
      if (!_state.isGameOver) _timer.restart();
    }
  }

  Future<void> makeMove(Position pos, bool isComputerMove) async {
    if (isComputerMove) {
      _changeState(GameState.paused);
      await Future.delayed(strategyToDuration(_strategy));
      _changeState(GameState.playing);
    }

    _board.placeMark(pos, _turn);
    _changeTurn();
    _notifyPlaceMark(pos, isComputerMove);
    _changeState(_board.checkWinningMove(pos, _turn.opposite));

    if (_state.isXWinner) {
      _notifyGameOver(GameStatus.xWon);
    } else if (_state.isOWinner) {
      _notifyGameOver(GameStatus.oWon);
    } else if (_state.isDraw) {
      _notifyGameOver(GameStatus.draw);
    }
  }

  Duration strategyToDuration(GameStrategy? strategy) {
    if (strategy is EasyStrategy) {
      return Duration(milliseconds: Random().nextInt(100) + 400);
    } else if (strategy is MediumStrategy) {
      return Duration(milliseconds: Random().nextInt(500) + 500);
    } else if (strategy is HardStrategy) {
      return Duration(milliseconds: Random().nextInt(1000) + 1000);
    }
    return Duration.zero;
  }

  @override
  String toString() => _board.toString();

  void _notifyPlaceMark(Position pos, bool isComputerMove) {
    for (var observer in _observers) {
      observer.onPlaceMark(pos, isComputerMove);
    }
  }

  void _notifyGameOver(GameStatus state) {
    _timer.stop();
    for (var observer in _observers) {
      observer.onGameOver(state);
    }
  }

  void _notifyTimerTick(Duration remainingTime) {
    for (var observer in _observers) {
      observer.onTimerTick(remainingTime);
    }
  }

  @override
  void onTimerTick(Duration remainingTime) {
    _notifyTimerTick(remainingTime);
  }

  @override
  void onTimerEnd() {
    if (_state.isGameOver) return;
    GameState winnerState = _turn == Mark.x ? GameState.oWon : GameState.xWon;
    GameStatus winnerStatus =
        _turn == Mark.x ? GameStatus.oWon : GameStatus.xWon;
    _changeState(winnerState);
    _notifyGameOver(winnerStatus);
  }
}

class GameObservable {
  final List<GameObserver> _observers = [];

  bool addObserver(GameObserver observer) {
    if (_observers.contains(observer)) {
      return false;
    }
    _observers.add(observer);
    return true;
  }

  bool removeObserver(GameObserver observer) {
    return _observers.remove(observer);
  }
}

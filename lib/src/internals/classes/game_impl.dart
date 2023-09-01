import 'package:tic_tac_toe_lib/src/internals/classes/board_impl.dart';
import 'package:tic_tac_toe_lib/src/internals/enums/game_state.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

class GameImpl extends GameObservable implements Game {
  final BoardImpl _board;
  Mark _turn;
  GameState _state;
  GameStrategy? _strategy;
  final Duration _computerMoveDuration;

  GameImpl({
    Strategy strategy = Strategy.twoPlayers,
    Duration computerMoveDuration = const Duration(seconds: 1),
  })  : _board = BoardImpl(),
        _turn = Mark.x,
        _state = GameState.playing,
        _strategy = strategy.convertToObj,
        _computerMoveDuration = computerMoveDuration;

  GameImpl.fromString(
    CharMatrix board,
    Mark turn,
    GameState state, [
    Strategy strategy = Strategy.twoPlayers,
    Duration computerMoveDuration = const Duration(seconds: 1),
  ])  : _board = BoardImpl.fromString(board),
        _turn = turn,
        _state = state,
        _strategy = strategy.convertToObj,
        _computerMoveDuration = computerMoveDuration;

  @override
  Mark get turn => _turn;
  @override
  int get boardSize => BoardImpl.size;
  @override
  MarkMatrix get boardRepresentation => MarkMatrix.from(_board.configuration);
  @override
  GameStrategy? get strategy => _strategy;

  @override
  set setStrategy(GameStrategy strategy) => _strategy = strategy;

  void _changeTurn() => _turn = _turn.opposite;
  void _changeState(GameState state) => _state = state;

  @override
  void restart() {
    _board.reset();
    _state = GameState.playing;
    _turn = Mark.x;
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
    if (_strategy != null && !_state.isGameOver) {
      // find a way to not duplicate code
      Position computerPos = _strategy!.getComputerPos(_board, _turn);
      await makeMove(computerPos, true);
    }
  }

  Future<void> makeMove(Position pos, bool isComputerMove) async {
    if (isComputerMove) {
      _changeState(GameState.paused);
      await Future.delayed(_computerMoveDuration);
      _changeState(GameState.playing);
    }

    _board.placeMark(pos, _turn);
    _changeTurn();
    _notifyPlaceMark(pos, isComputerMove);
    _changeState(_board.checkWinningMove(pos, _turn.opposite));

    if (_state.isXWinner) {
      _notifyGameOver(GameEvent.xWon);
    } else if (_state.isOWinner) {
      _notifyGameOver(GameEvent.oWon);
    } else if (_state.isDraw) {
      _notifyGameOver(GameEvent.draw);
    }
  }

  @override
  String toString() => _board.toString();
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

  void _notifyPlaceMark(Position pos, bool isComputerMove) {
    for (var observer in _observers) {
      observer.onPlaceMark(pos, isComputerMove);
    }
  }

  void _notifyGameOver(GameEvent state) {
    for (var observer in _observers) {
      observer.onGameOver(state);
    }
  }
}

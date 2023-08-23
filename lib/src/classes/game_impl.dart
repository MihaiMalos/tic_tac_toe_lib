import 'package:tic_tac_toe_lib/src/API/game.dart';
import 'package:tic_tac_toe_lib/src/API/game_observer.dart';
import 'package:tic_tac_toe_lib/src/API/game_strategy.dart';
import 'package:tic_tac_toe_lib/src/API/position.dart';
import 'package:tic_tac_toe_lib/src/classes/board.dart';
import 'package:tic_tac_toe_lib/src/enums/game_state.dart';
import 'package:tic_tac_toe_lib/src/enums/mark.dart';
import 'package:tic_tac_toe_lib/src/enums/strategy.dart';
import 'package:tic_tac_toe_lib/src/exceptions/exceptions.dart';

class GameImpl extends GameObservable implements Game {
  final Board _board;
  Mark _turn;
  GameState _state;
  final GameStrategy? _strategy;

  GameImpl({Strategy strategy = Strategy.twoPlayers})
      : _board = Board(),
        _turn = Mark.x,
        _state = GameState.playing,
        _strategy = strategy.convertToObj;

  GameImpl.fromString(CharMatrix board, Mark turn, GameState state,
      [Strategy strategy = Strategy.twoPlayers])
      : _board = Board.fromString(board),
        _turn = turn,
        _state = state,
        _strategy = strategy.convertToObj;

  @override
  Mark get turn => _turn;
  @override
  int get boardSize => Board.size;

  void _changeTurn() => _turn = _turn.opposite;
  void _changeState(GameState state) => _state = state;

  @override
  Mark getBoardElement(Position pos) {
    return _board.getElementByPos(pos);
  }

  @override
  void placeMark(Position pos) {
    if (_state.isGameOver) {
      throw GameOverException("Game is over, can't make anymore moves.");
    }
    _board.placeMark(pos, _turn);
    _notifyPlaceMark(pos);
    _changeState(_board.checkWinningMove(pos, _turn));
    if (_state.isGameOver) _notifyGameOver(_state);
    _changeTurn();

    if (_strategy != null && !_state.isGameOver) {
      // find a way to not duplicate code
      Position computerPos = _strategy!.getComputerPos(_board, _turn);
      _board.placeMark(computerPos, _turn);
      _notifyPlaceMark(computerPos);
      _changeState(_board.checkWinningMove(computerPos, _turn));
      if (_state.isGameOver) _notifyGameOver(_state);
      _changeTurn();
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

  void _notifyPlaceMark(Position pos) {
    for (var observer in _observers) {
      observer.onPlaceMark(pos);
    }
  }

  void _notifyGameOver(GameState state) {
    for (var observer in _observers) {
      observer.onGameOver(state);
    }
  }
}

import 'package:tic_tac_toe_lib/src/classes/board_impl.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

class GameImpl extends GameObservable implements Game {
  final BoardImpl _board;
  Mark _turn;
  GameEvent _state;
  final GameStrategy? _strategy;

  GameImpl({Strategy strategy = Strategy.twoPlayers})
      : _board = BoardImpl(),
        _turn = Mark.x,
        _state = GameEvent.playing,
        _strategy = strategy.convertToObj;

  GameImpl.fromString(CharMatrix board, Mark turn, GameEvent state,
      [Strategy strategy = Strategy.twoPlayers])
      : _board = BoardImpl.fromString(board),
        _turn = turn,
        _state = state,
        _strategy = strategy.convertToObj;

  @override
  Mark get turn => _turn;
  @override
  int get boardSize => BoardImpl.size;
  @override
  MarkMatrix get boardRepresentation => MarkMatrix.from(_board.configuration);

  void _changeTurn() => _turn = _turn.opposite;
  void _changeState(GameEvent state) => _state = state;

  @override
  void placeMark(Position pos) {
    if (_state.isGameOver) {
      throw GameOverException("Game is over, can't make anymore moves.");
    }
    _board.placeMark(pos, _turn);
    _changeTurn();
    _notifyPlaceMark(pos);
    _changeState(_board.checkWinningMove(pos, _turn.opposite));
    if (_state.isGameOver) _notifyGameOver(_state);

    if (_strategy != null && !_state.isGameOver) {
      // find a way to not duplicate code
      Position computerPos = _strategy!.getComputerPos(_board, _turn);
      _board.placeMark(computerPos, _turn);
      _changeTurn();
      _notifyPlaceMark(computerPos);
      _changeState(_board.checkWinningMove(computerPos, _turn.opposite));
      if (_state.isGameOver) _notifyGameOver(_state);
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

  void _notifyGameOver(GameEvent state) {
    for (var observer in _observers) {
      observer.onGameOver(state);
    }
  }
}

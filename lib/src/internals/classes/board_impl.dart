import 'package:tic_tac_toe_lib/src/internals/enums/game_state.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

typedef CharMatrix = List<String>;

class BoardImpl implements Board {
  static const size = 3;
  late MarkMatrix _board;

  BoardImpl() {
    _board = boardInit();
  }

  BoardImpl.fromString(CharMatrix board) : _board = [] {
    for (String line in board) {
      List<Mark> row = line.split(' ').map((str) => Mark.parse(str)).toList();
      _board.add(row);
    }
  }

  @override
  MarkMatrix get configuration => _board;
  @override
  Mark getElementByPos(Position pos) => _board[pos.row][pos.col];
  @override
  Mark getElementByPair(int row, int col) => _board[row][col];

  @override
  PositionList get emptyPositions {
    PositionList positions = [];
    for (int row = 0; row < size; row++) {
      for (int column = 0; column < size; column++) {
        if (isEmptyPos(row, column)) positions.add(Position(row, column));
      }
    }
    return positions;
  }

  @override
  bool get isFull {
    for (int row = 0; row < size; row++) {
      if (_board[row].contains(Mark.empty)) {
        return false;
      }
    }
    return true;
  }

  @override
  GameEvent? checkWinning(Mark mark) {
    for (int index = 0; index < size; index++) {
      if (checkRow(index, mark) || checkColumn(index, mark)) {
        return mark == Mark.x ? GameEvent.xWon : GameEvent.oWon;
      }
    }
    if (checkPrimaryDiagonal(mark) || checkSecondaryDiagonal(mark)) {
      return mark == Mark.x ? GameEvent.xWon : GameEvent.oWon;
    }
    return isFull ? GameEvent.draw : null;
  }

  @override
  void reset() {
    _board.clear();
    _board = boardInit();
  }

  @override
  String toString() {
    return _board
        .map((row) => row
            .map((element) => element == Mark.empty ? '.' : element.name)
            .join(' '))
        .join('\n');
  }

  MarkMatrix boardInit() {
    return List.generate(
        size, (rowIndex) => List.generate(size, (colIndex) => Mark.empty));
  }

  void placeMark(Position pos, Mark mark) {
    validatePosition(pos);
    _board[pos.row][pos.col] = mark;
  }

  bool isEmptyPos(int row, int col) => getElementByPair(row, col).isEmpty;

  GameState checkWinningMove(Position pos, Mark mark) {
    if (checkRow(pos.row, mark) ||
        checkColumn(pos.col, mark) ||
        checkPrimaryDiagonal(mark) ||
        checkSecondaryDiagonal(mark)) {
      return mark == Mark.x ? GameState.xWon : GameState.oWon;
    }

    return isFull ? GameState.draw : GameState.playing;
  }

  void validatePosition(Position pos) {
    if (!pos.isValid()) {
      throw OutOfBoundException('Specified position is not valid');
    }
    if (!getElementByPos(pos).isEmpty) {
      throw OcuppiedPositionException('Specified position is already ocuppied');
    }
  }

  bool checkColumn(int col, Mark mark) {
    for (int row = 0; row < size; row++) {
      if (getElementByPair(row, col) != mark) {
        return false;
      }
    }
    return true;
  }

  bool checkRow(int row, Mark mark) =>
      _board[row].every((element) => element.isSame(mark));

  bool checkPrimaryDiagonal(Mark mark) {
    for (int index = 0; index < size; index++) {
      if (!getElementByPair(index, index).isSame(mark)) {
        return false;
      }
    }
    return true;
  }

  bool checkSecondaryDiagonal(Mark mark) {
    for (int index = 0; index < size; index++) {
      if (!getElementByPair(index, size - index - 1).isSame(mark)) {
        return false;
      }
    }
    return true;
  }
}

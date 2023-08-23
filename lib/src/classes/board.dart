import 'package:tic_tac_toe_lib/src/API/classes/position.dart';
import 'package:tic_tac_toe_lib/src/API/enums/game_state.dart';
import 'package:tic_tac_toe_lib/src/API/enums/mark.dart';
import 'package:tic_tac_toe_lib/src/API/exceptions/exceptions.dart';

typedef MarkMatrix = List<List<Mark>>;
typedef CharMatrix = List<String>;

class Board {
  static const size = 3;
  late MarkMatrix _board;

  Board()
      : _board = List.generate(
            size, (rowIndex) => List.generate(size, (colIndex) => Mark.empty));

  Board.fromString(CharMatrix board) {
    _board = [];
    for (String line in board) {
      List<Mark> row = line.split(' ').map((str) => Mark.parse(str)).toList();
      _board.add(row);
    }
  }

  bool isEmptyPos(int row, int col) => getElementByPair(row, col).isEmpty;
  MarkMatrix get configuration => _board;

  PositionList get emptyPositions {
    PositionList positions = [];
    for (int row = 0; row < size; row++) {
      for (int column = 0; column < size; column++) {
        if (isEmptyPos(row, column)) positions.add(Position(row, column));
      }
    }
    return positions;
  }

  Mark getElementByPos(Position pos) => _board[pos.row][pos.col];
  Mark getElementByPair(int row, int col) => _board[row][col];

  void clearElement(Position pos) => _board[pos.row][pos.col] = Mark.empty;

  bool get isFull {
    for (int row = 0; row < size; row++) {
      if (_board[row].any((element) => element.isSame(Mark.empty))) {
        return false;
      }
    }
    return true;
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

  GameState checkWinningMove(Position pos, Mark mark) {
    if (checkRow(pos.row, mark) ||
        checkColumn(pos.col, mark) ||
        checkPrimaryDiagonal(mark) ||
        checkSecondaryDiagonal(mark)) {
      return mark.toGameState;
    }

    return isFull ? GameState.tie : GameState.playing;
  }

  GameState checkWinning(Mark mark) {
    for (int index = 0; index < size; index++) {
      if (checkRow(index, mark) || checkColumn(index, mark)) {
        return mark.toGameState;
      }
    }
    if (checkPrimaryDiagonal(mark) || checkSecondaryDiagonal(mark)) {
      return mark.toGameState;
    }
    return isFull ? GameState.tie : GameState.playing;
  }

  void placeMark(Position pos, Mark mark) {
    validatePosition(pos);
    _board[pos.row][pos.col] = mark;
  }

  @override
  String toString() {
    return _board
        .map((row) => row
            .map((element) => element == Mark.empty ? '.' : element.name)
            .join(' '))
        .join('\n');
  }
}

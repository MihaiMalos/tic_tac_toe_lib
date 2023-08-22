import 'package:tic_tac_toe_lib/src/API/position.dart';
import 'package:tic_tac_toe_lib/src/enums/game_state.dart';
import 'package:tic_tac_toe_lib/src/enums/mark.dart';
import 'package:tic_tac_toe_lib/src/exceptions/exceptions.dart';

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
  Mark getElementByPos(Position pos) => _board[pos.row][pos.col];
  Mark getElementByPair(int row, int col) => _board[row][col];

  bool get isFull {
    for (int row = 0; row < size; row++) {
      if (_board[row].any((element) => element.isSame(Mark.empty))) {
        return false;
      }
    }
    return true;
  }

  void positionValidation(Position pos) {
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

  GameState checkWinning(Position pos, Mark mark) {
    if (checkRow(pos.row, mark) ||
        checkColumn(pos.col, mark) ||
        checkPrimaryDiagonal(mark) ||
        checkSecondaryDiagonal(mark)) {
      return mark == Mark.x ? GameState.xWon : GameState.oWon;
    }

    return isFull ? GameState.tie : GameState.playing;
  }

  void placeMark(Position pos, Mark mark) {
    positionValidation(pos);
    _board[pos.row][pos.col] = mark;
  }

  @override
  String toString() {
    final out = StringBuffer();
    for (var row in _board) {
      for (var index = 0; index < row.length; index++) {
        final element = row[index];
        out.write(element == Mark.empty ? '.' : element.name);
        if (index != row.length - 1) out.write(' ');
      }
      if (row != _board.last) out.write('\n');
    }
    return out.toString();
  }
}

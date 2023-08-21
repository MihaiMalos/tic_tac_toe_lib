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
    for (String line in board) {
      List<Mark> row = line.split(' ').map((str) => Mark.parse(str)).toList();
      _board.add(row);
    }
  }

  Mark getElementByPos(Position pos) => _board[pos.row][pos.col];
  Mark getElementByPair(int row, int col) => _board[row][col];

  void validation(Position pos) {
    if (!pos.isValid()) {
      throw OutOfBoundException('Specified position is not valid');
    }
    if (!getElementByPos(pos).isEmpty) {
      throw OcuppiedPositionException('Specified position is already ocuppied');
    }
  }

  bool isFull() {
    for (int row = 0; row < size; row++) {
      if (_board[row].any((element) => !element.isSame(Mark.empty))) {
        return false;
      }
    }
    return true;
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

    return isFull() ? GameState.tie : GameState.playing;
  }

  void placeMark(Position pos, Mark mark) {
    validation(pos);
    _board[pos.row][pos.col] = mark;
  }

  @override
  String toString() {
    final out = StringBuffer();
    for (var row in _board) {
      for (var element in row) {
        out.write(element == Mark.empty ? '. ' : '${element.name} ');
      }
      out.write('\n');
    }
    return out.toString();
  }
}

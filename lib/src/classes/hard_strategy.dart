import 'package:tic_tac_toe_lib/src/API/game_strategy.dart';
import 'package:tic_tac_toe_lib/src/API/position.dart';
import 'package:tic_tac_toe_lib/src/classes/board.dart';
import 'package:tic_tac_toe_lib/src/enums/mark.dart';

class HardStrategy implements GameStrategy {
  @override
  Position getComputerPos(Board board, Mark mark) {
    int bestScore = 0;
    late Position bestMove;
    for (var row = 0; row < Board.size; row++) {
      for (var column = 0; column < Board.size; column++) {
        if (board.isEmptyPos(row, column)) {
          final int score = minimax(board, mark, 0, true);
          if (score > bestScore) {
            bestScore = score;
            bestMove = Position(row, column);
          }
        }
      }
    }
    return bestMove;
  }

  int minimax(Board board, Mark mark, int depth, bool isMaximizing) {
    return 1;
  }
}

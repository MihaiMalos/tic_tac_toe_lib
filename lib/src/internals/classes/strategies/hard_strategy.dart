import 'dart:math';

import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

extension on Board {
  void placeMark(Position pos, Mark mark) =>
      configuration[pos.row][pos.col] = mark;

  void clearElement(Position pos) =>
      configuration[pos.row][pos.col] = Mark.empty;
}

class HardStrategy implements GameStrategy {
  @override
  Position getComputerPos(Board board, Mark mark) {
    double bestScore = double.negativeInfinity;
    double alpha = double.negativeInfinity;
    double beta = double.infinity;
    late Position bestMove;
    final positions = board.emptyPositions;
    for (var position in positions) {
      board.placeMark(position, mark);
      final double score = minimax(board, mark, alpha, beta, false);
      board.clearElement(position);
      if (score > bestScore) {
        bestScore = score;
        bestMove = position;
      }
    }
    return bestMove;
  }

  Map scores = {
    GameStatus.oWon: 1.0,
    GameStatus.draw: 0.0,
    GameStatus.xWon: -1.0,
  };

  double minimax(
      Board board, Mark mark, double alpha, double beta, bool isMaximizing) {
    GameStatus? result;
    isMaximizing
        ? result = board.checkWinning(mark.opposite)
        : result = board.checkWinning(mark);
    if (result != null) return scores[result];

    double bestScore = isMaximizing ? double.negativeInfinity : double.infinity;
    final markToFill = isMaximizing ? mark : mark.opposite;
    final extremeValue = isMaximizing ? max : min;

    final positions = board.emptyPositions;

    for (var position in positions) {
      board.placeMark(position, markToFill);
      double score = minimax(board, mark, alpha, beta, !isMaximizing);
      board.clearElement(position);
      bestScore = extremeValue(score, bestScore);
      if (isMaximizing) {
        alpha = extremeValue(alpha, score);
      } else {
        beta = extremeValue(beta, score);
      }
      if (beta <= alpha) break;
    }
    return bestScore;
  }
}

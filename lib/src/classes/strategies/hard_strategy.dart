import 'dart:math';

import 'package:tic_tac_toe_lib/src/API/game_strategy.dart';
import 'package:tic_tac_toe_lib/src/API/position.dart';
import 'package:tic_tac_toe_lib/src/classes/board.dart';
import 'package:tic_tac_toe_lib/src/enums/game_state.dart';
import 'package:tic_tac_toe_lib/src/enums/mark.dart';

int cnt = 0;

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
    GameState.oWon: 1.0,
    GameState.tie: 0.0,
    GameState.xWon: -1.0,
  };

  double minimax(
      Board board, Mark mark, double alpha, double beta, bool isMaximizing) {
    cnt++;
    GameState result;
    isMaximizing
        ? result = board.checkWinning(mark)
        : result = board.checkWinning(mark.opposite);
    if (result.isGameOver) return scores[result];

    if (isMaximizing) {
      double bestScore = double.negativeInfinity;
      final positions = board.emptyPositions;
      for (var position in positions) {
        board.placeMark(position, mark);
        double score = minimax(board, mark, alpha, beta, false);
        board.clearElement(position);
        bestScore = max(score, bestScore);
        alpha = max(alpha, score);
        if (beta <= alpha) break;
      }
      return bestScore;
    } else {
      double bestScore = double.infinity;
      final positions = board.emptyPositions;
      for (var position in positions) {
        board.placeMark(position, mark.opposite);
        double score = minimax(board, mark, alpha, beta, true);
        board.clearElement(position);
        bestScore = min(score, bestScore);
        beta = min(beta, score);
        if (beta <= alpha) break;
      }
      return bestScore;
    }
  }
}

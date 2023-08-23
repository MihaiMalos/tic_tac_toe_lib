import 'dart:math';

import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

class EasyStrategy implements GameStrategy {
  @override
  Position getComputerPos(Board board, Mark mark) {
    final positions = board.emptyPositions;
    final randomPosIndex = Random().nextInt(positions.length);
    return positions[randomPosIndex];
  }
}

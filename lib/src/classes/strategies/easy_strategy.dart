import 'dart:math';

import 'package:tic_tac_toe_lib/src/API/game_strategy.dart';
import 'package:tic_tac_toe_lib/src/API/position.dart';
import 'package:tic_tac_toe_lib/src/classes/board.dart';
import 'package:tic_tac_toe_lib/src/enums/mark.dart';

class EasyStrategy implements GameStrategy {
  @override
  Position getComputerPos(Board board, Mark mark) {
    final positions = board.emptyPositions;
    final randomPosIndex = Random().nextInt(positions.length);
    return positions[randomPosIndex];
  }
}

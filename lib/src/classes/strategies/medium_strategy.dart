import 'dart:math';

import 'package:tic_tac_toe_lib/src/classes/board.dart';
import 'package:tic_tac_toe_lib/src/classes/strategies/easy_strategy.dart';
import 'package:tic_tac_toe_lib/src/classes/strategies/hard_strategy.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

class MediumStrategy implements GameStrategy {
  @override
  Position getComputerPos(Board board, Mark mark) {
    EasyStrategy easy = EasyStrategy();
    HardStrategy hard = HardStrategy();
    bool easyMove = Random().nextBool();
    return easyMove
        ? easy.getComputerPos(board, mark)
        : hard.getComputerPos(board, mark);
  }
}

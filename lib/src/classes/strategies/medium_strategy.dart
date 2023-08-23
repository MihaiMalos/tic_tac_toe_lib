import 'dart:math';

import 'package:tic_tac_toe_lib/src/classes/strategies/easy_strategy.dart';
import 'package:tic_tac_toe_lib/src/classes/strategies/hard_strategy.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

class MediumStrategy implements GameStrategy {
  @override
  Position getComputerPos(Board board, Mark mark) {
    bool easyMove = Random().nextBool();
    return easyMove
        ? EasyStrategy().getComputerPos(board, mark)
        : HardStrategy().getComputerPos(board, mark);
  }
}

import 'package:tic_tac_toe_lib/src/API/position.dart';
import 'package:tic_tac_toe_lib/src/classes/board.dart';
import 'package:tic_tac_toe_lib/src/enums/mark.dart';

abstract interface class GameStrategy {
  Position getComputerPos(Board board, Mark mark);
}

import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

abstract interface class GameStrategy {
  Position getComputerPos(Board board, Mark mark);
}

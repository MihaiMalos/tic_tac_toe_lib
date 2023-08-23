import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

abstract interface class Board {
  Mark getElementByPos(Position pos);
  Mark getElementByPair(int row, int col);

  PositionList get emptyPositions;
  bool get isFull;

  void placeMark(Position pos, Mark mark);
  void clearElement(Position pos);
  GameState checkWinning(Mark mark);
}

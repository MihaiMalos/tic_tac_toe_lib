import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

abstract interface class Board {
  MarkMatrix get configuration;

  Mark getElementByPos(Position pos);
  Mark getElementByPair(int row, int col);

  PositionList get emptyPositions;
  bool get isFull;

  GameState checkWinning(Mark mark);
}

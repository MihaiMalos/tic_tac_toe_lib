import 'package:tic_tac_toe_lib/src/enums/game_state.dart';

enum Mark {
  x,
  o,
  empty;

  bool get isEmpty => this == Mark.empty;
  bool isSame(Mark other) => this == other;

  Mark get opposite => isEmpty ? Mark.empty : Mark.values[(index + 1) % 2];
  GameState get toGameState {
    if (this == Mark.x) return GameState.xWon;
    if (this == Mark.o) return GameState.oWon;

    throw Exception("Mark is not valid");
  }

  static Mark parse(String str) {
    List<String> input = ['x', 'o', '.'];
    List<Mark> output = [Mark.x, Mark.o, Mark.empty];
    int index = input.indexOf(str);
    if (index == -1) throw Exception("Invalid string");
    return output[index];
  }
}

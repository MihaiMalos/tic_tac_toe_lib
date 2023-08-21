import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';
import 'package:test/test.dart';

void main() {
  Game game = Game.create();

  test('Board init', () {
    for (int index = 0; index < 9; index++) {
      final Position elementPos = Position(index ~/ 3, index % 3);
      expect(game.getBoardElement(elementPos), Mark.empty);
    }
  });

  test('Place marks', () {
    final xPos = Position(0, 1);
    final oPos = Position(1, 1);
    game.placeMark(xPos);
    expect(game.getBoardElement(xPos), Mark.x);
    game.placeMark(oPos);
    expect(game.getBoardElement(oPos), Mark.o);
  });
}

import 'package:test/test.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

void main() {
  test('First row', () {
    Game game = Game.create(strategy: Strategy.hard);

    game.placeMark(Position(0, 0));

    print(game);
  });
}

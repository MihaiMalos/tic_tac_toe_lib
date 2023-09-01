import 'package:test/test.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

void main() {
  test('Hard strategy tie', () async {
    Game game = Game.create(strategy: Strategy.hard);

    await game.placeMark(Position(0, 1));
    await game.placeMark(Position(2, 0));
    await game.placeMark(Position(2, 2));
    await game.placeMark(Position(0, 2));
    await game.placeMark(Position(1, 0));

    // expect(() => game.placeMark(Position(0, 0)),
    //     throwsA(isA<GameOverException>()));
  });
}

import 'package:test/test.dart';
import 'package:tic_tac_toe_lib/src/enums/strategy.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

void main() {
  group('Hard strategy', () {
    late Game game;

    setUp(() {
      game = Game.create(strategy: Strategy.hard);
    });

    test('Place marks', () {
      game.placeMark(Position(0, 2));
      print(game);
    });
  });
}

import 'package:tic_tac_toe_lib/src/classes/game_impl.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';
import 'package:test/test.dart';

void main() {
  group('Default constructor', () {
    late Game game;

    setUp(() {
      game = Game.create();
    });

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
  });

  group('fromString constructor', () {
    late GameImpl game;
    List<String> board = [
      "x . o",
      ". . .",
      ". x .",
    ];
    setUp(() {
      game = GameImpl.fromString(board, Mark.o, GameState.playing);
    });

    test('Board init', () {
      expect(game.toString(), board.join('\n'));
    });

    test('Place marks', () {
      final oPos = Position(1, 1);
      final xPos = Position(0, 1);
      game.placeMark(oPos);
      game.placeMark(xPos);

      List<String> expectedBoard = [
        "x x o",
        ". o .",
        ". x .",
      ];

      expect(game.toString(), expectedBoard.join('\n'));
    });
  });
}

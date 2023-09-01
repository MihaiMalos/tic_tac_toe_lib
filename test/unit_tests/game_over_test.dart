import 'package:test/test.dart';
import 'package:tic_tac_toe_lib/src/internals/classes/game_impl.dart';
import 'package:tic_tac_toe_lib/src/internals/enums/game_state.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

void main() {
  group('X wins on row', () {
    late GameImpl game;
    List<String> board = [
      ". . x",
      ". . .",
      ". . .",
    ];
    setUp(() {
      game = GameImpl.fromString(board, Mark.x, GameState.playing);
    });

    test('First row', () {
      game.placeMark(Position(0, 0));
      game.placeMark(Position(1, 0)); // o turn
      game.placeMark(Position(0, 1));

      expect(() => game.placeMark(Position(2, 1)),
          throwsA(isA<GameOverException>()));
    });

    test('Second row', () {
      game.placeMark(Position(1, 0));
      game.placeMark(Position(0, 0)); // o turn
      game.placeMark(Position(1, 1));
      game.placeMark(Position(0, 1)); // o turn
      game.placeMark(Position(1, 2));

      expect(() => game.placeMark(Position(2, 1)),
          throwsA(isA<GameOverException>()));
    });

    test('Third row', () {
      game.placeMark(Position(2, 0));
      game.placeMark(Position(0, 0)); // o turn
      game.placeMark(Position(2, 1));
      game.placeMark(Position(0, 1)); // o turn
      game.placeMark(Position(2, 2));

      expect(() => game.placeMark(Position(0, 0)),
          throwsA(isA<GameOverException>()));
    });
  });

  group('X wins on column', () {
    late GameImpl game;
    List<String> board = [
      ". . .",
      "x . .",
      ". . .",
    ];
    setUp(() {
      game = GameImpl.fromString(board, Mark.x, GameState.playing);
    });

    test('First column', () {
      game.placeMark(Position(0, 0));
      game.placeMark(Position(1, 1)); // o turn
      game.placeMark(Position(2, 0));

      expect(() => game.placeMark(Position(2, 1)),
          throwsA(isA<GameOverException>()));
    });
    test('Second column', () {
      game.placeMark(Position(0, 1));
      game.placeMark(Position(0, 0)); // o turn
      game.placeMark(Position(1, 1));
      game.placeMark(Position(0, 2)); // o turn
      game.placeMark(Position(2, 1));

      expect(() => game.placeMark(Position(2, 2)),
          throwsA(isA<GameOverException>()));
    });

    test('Third column', () {
      game.placeMark(Position(0, 2));
      game.placeMark(Position(0, 0)); // o turn
      game.placeMark(Position(1, 2));
      game.placeMark(Position(0, 1)); // o turn
      game.placeMark(Position(2, 2));

      expect(() => game.placeMark(Position(1, 1)),
          throwsA(isA<GameOverException>()));
    });
  });

  group('X wins on diagonal', () {
    late GameImpl game;
    List<String> board = [
      ". . .",
      ". x .",
      "x . x",
    ];
    setUp(() {
      game = GameImpl.fromString(board, Mark.x, GameState.playing);
    });

    test('Primary diagonal', () {
      game.placeMark(Position(0, 0));
      expect(() => game.placeMark(Position(0, 2)),
          throwsA(isA<GameOverException>()));

      expect(() => game.placeMark(Position(0, 0)),
          throwsA(isA<GameOverException>()));
    });

    test('Secondary diagonal', () {
      game.placeMark(Position(0, 2));
      expect(() => game.placeMark(Position(0, 2)),
          throwsA(isA<GameOverException>()));

      expect(() => game.placeMark(Position(0, 0)),
          throwsA(isA<GameOverException>()));
    });
  });
}

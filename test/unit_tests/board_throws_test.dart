import 'package:tic_tac_toe_lib/src/internals/classes/board_impl.dart';
import 'package:test/test.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

void main() {
  // comment

  group('Exception throws', () {
    late BoardImpl game;
    List<String> board = [
      "x . o",
      ". . .",
      ". x .",
    ];
    setUp(() {
      game = BoardImpl.fromString(board);
    });

    test('Invalid position', () {
      expect(() => game.placeMark(Position(69, 3), Mark.o),
          throwsA(isA<OutOfBoundException>()));
    });

    test('Ocuppied position (same mark)', () {
      expect(() => game.placeMark(Position(0, 0), Mark.x),
          throwsA(isA<OcuppiedPositionException>()));
    });

    test('Ocuppied position (other mark)', () {
      expect(() => game.placeMark(Position(0, 0), Mark.o),
          throwsA(isA<OcuppiedPositionException>()));
    });
  });
}

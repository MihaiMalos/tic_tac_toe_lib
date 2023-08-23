import 'package:tic_tac_toe_lib/src/classes/board.dart';
import 'package:test/test.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

void main() {
  group('Exception throws', () {
    late Board game;
    List<String> board = [
      "x . o",
      ". . .",
      ". x .",
    ];
    setUp(() {
      game = Board.fromString(board);
    });

    test('Invalid positionn', () {
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

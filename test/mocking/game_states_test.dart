import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<GameObserver>()])
import 'game_observer.mocks.dart';

void main() {
  final observer = MockGameObserver();
  late Game game;
  group('Game over states', () {
    setUp(() {
      game = Game.create();
      game.addObserver(observer);
    });
    test('Place mark', () {
      PositionList positions = [Position(0, 0), Position(0, 1)];
      for (var position in positions) {
        game.placeMark(position);
        verify(observer.onPlaceMark(position, false));
      }
    });

    test('X wins', () {
      PositionList positions = [
        Position(0, 0),
        Position(1, 0),
        Position(0, 1),
        Position(1, 1),
        Position(0, 2),
      ];

      for (var position in positions) {
        game.placeMark(position);
        verify(observer.onPlaceMark(position, false));
      }

      verify(observer.onGameOver(GameEvent.xWon));
    });

    test('O wins', () {
      PositionList positions = [
        Position(0, 0),
        Position(1, 0),
        Position(0, 1),
        Position(1, 1),
        Position(2, 0),
        Position(1, 2),
      ];

      for (var position in positions) {
        game.placeMark(position);
        verify(observer.onPlaceMark(position, false));
      }
      verify(observer.onGameOver(GameEvent.oWon));
    });

    test('Tie', () {
      PositionList positions = [
        Position(0, 0),
        Position(1, 0),
        Position(0, 1),
        Position(1, 1),
        Position(2, 0),
        Position(0, 2),
        Position(2, 2),
        Position(2, 1),
        Position(1, 2),
      ];

      for (var position in positions) {
        game.placeMark(position);
        verify(observer.onPlaceMark(position, false));
      }
      verify(observer.onGameOver(GameEvent.tie));
    });
  });
}

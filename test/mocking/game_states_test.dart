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
      game.placeMark(Position(0, 0));
      game.placeMark(Position(0, 1));

      verify(observer.onPlaceMark()).called(2);
    });

    test('X wins', () {
      game.placeMark(Position(0, 0));
      game.placeMark(Position(1, 0));

      game.placeMark(Position(0, 1));
      game.placeMark(Position(1, 1));

      game.placeMark(Position(0, 2));

      verify(observer.onPlaceMark()).called(5);
      verify(observer.onGameOver(GameState.xWon));
    });

    test('O wins', () {
      game.placeMark(Position(0, 0));
      game.placeMark(Position(1, 0));

      game.placeMark(Position(0, 1));
      game.placeMark(Position(1, 1));

      game.placeMark(Position(2, 0));
      game.placeMark(Position(1, 2));

      verify(observer.onPlaceMark()).called(6);
      verify(observer.onGameOver(GameState.oWon));
    });

    test('Tie', () {
      game.placeMark(Position(0, 0));
      game.placeMark(Position(1, 0));

      game.placeMark(Position(0, 1));
      game.placeMark(Position(1, 1));

      game.placeMark(Position(2, 0));
      game.placeMark(Position(0, 2));

      game.placeMark(Position(2, 2));
      game.placeMark(Position(2, 1));

      game.placeMark(Position(1, 2));

      verify(observer.onPlaceMark()).called(9);
      verify(observer.onGameOver(GameState.tie));
    });
  });
}

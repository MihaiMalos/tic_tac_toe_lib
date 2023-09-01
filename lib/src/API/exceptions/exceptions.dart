class OutOfBoundException implements Exception {
  OutOfBoundException(this.message);
  final String message;
}

class OcuppiedPositionException implements Exception {
  OcuppiedPositionException(this.message);
  final String message;
}

class WaitingMoveException implements Exception {
  WaitingMoveException(this.message);
  final String message;
}

class GameOverException implements Exception {
  GameOverException(this.message);
  final String message;
}

enum GameStatus {
  xWon,
  oWon,
  draw;

  bool get isGameOver => this == draw || this == xWon || this == oWon;

  bool get isXWinner => this == xWon ? true : false;
  bool get isOWinner => this == oWon ? true : false;
  bool get isDraw => this == draw ? true : false;
}

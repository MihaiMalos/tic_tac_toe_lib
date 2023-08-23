enum GameState {
  playing,
  xWon,
  oWon,
  tie;

  bool get isGameOver => this != GameState.playing;
}

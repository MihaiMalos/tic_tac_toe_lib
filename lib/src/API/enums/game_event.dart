enum GameEvent {
  playing,
  xWon,
  oWon,
  tie;

  bool get isGameOver => this != GameEvent.playing;
}

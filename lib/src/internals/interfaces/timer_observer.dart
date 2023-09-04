abstract interface class TimerObserver {
  void onTimerTick(Duration duration);
  void onTimerEnd();
}

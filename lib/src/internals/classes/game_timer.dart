import 'package:quiver/async.dart';
import 'package:tic_tac_toe_lib/src/internals/interfaces/timer_observer.dart';

class GameTimer extends TimerObserverable {
  late CountdownTimer _countdownTimer;
  final Duration _moveDuration;
  final Duration _resolution;

  GameTimer({required Duration moveDuration, required Duration resolution})
      : _moveDuration = moveDuration,
        _resolution = resolution;

  void start() {
    _countdownTimer = CountdownTimer(_moveDuration, _resolution);
    var timerListener = _countdownTimer.listen(null);
    timerListener.onData((event) {
      if (!_countdownTimer.remaining.isNegative) {
        _notifyTimerTick(event.remaining);
      }
    });
    timerListener.onDone(() {
      if (_countdownTimer.remaining.isNegative) _notifyTimerEnd();
      _countdownTimer.cancel();
    });
  }

  void restart() {
    _countdownTimer.cancel();
    start();
  }

  void stop() => _countdownTimer.cancel();
  Duration get timeElapsed => _countdownTimer.elapsed;
  Duration get timerDuration => _moveDuration;
}

class TimerObserverable {
  final List<TimerObserver> _observers = [];

  bool addObserver(TimerObserver observer) {
    if (_observers.contains(observer)) {
      return false;
    }
    _observers.add(observer);
    return true;
  }

  bool removeObserver(TimerObserver observer) {
    return _observers.remove(observer);
  }

  void _notifyTimerTick(Duration remainingTime) {
    for (var observer in _observers) {
      observer.onTimerTick(remainingTime);
    }
  }

  void _notifyTimerEnd() {
    for (var observer in _observers) {
      observer.onTimerEnd();
    }
  }
}

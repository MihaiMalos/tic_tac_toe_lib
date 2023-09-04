import 'package:quiver/async.dart';
import 'package:tic_tac_toe_lib/src/internals/interfaces/timer_observer.dart';

class GameTimer extends TimerObserverable {
  late CountdownTimer _countdownTimer;
  final Duration _moveDuration;

  GameTimer({required Duration moveDuration}) : _moveDuration = moveDuration;

  void start() {
    _countdownTimer = CountdownTimer(_moveDuration, Duration(milliseconds: 10));
    var timerListener = _countdownTimer.listen(null);
    timerListener.onData((event) {
      _notifyTimerTick(event.remaining);
    });
    timerListener.onDone(() {
      _notifyTimerEnd();
      _countdownTimer.cancel();
    });
  }

  void restart() {
    _countdownTimer.cancel();
    _countdownTimer = CountdownTimer(_moveDuration, Duration(milliseconds: 10));
  }
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

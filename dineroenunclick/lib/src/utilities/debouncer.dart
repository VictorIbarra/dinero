import 'dart:async';

class Debouncer {
  final Duration delay;
  Timer _timer;

  Debouncer({this.delay = const Duration(milliseconds: 300)});

  call(Function action) {
    cancel();
    _timer = Timer(delay, action);
  }

  cancel() {
    _timer?.cancel();
  }
}

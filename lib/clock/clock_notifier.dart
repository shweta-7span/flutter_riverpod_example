import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClockNotifier extends StateNotifier<DateTime> {
  // 1. initialize with current time
  ClockNotifier() : super(DateTime.now()) {
    // 2. create a timer that fires every second
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        // 3. update the state with the current time
        state = DateTime.now();
      },
    );
  }

  late final Timer _timer;

  // 4. cancel the timer when finished
  @override
  void dispose() {
    debugPrint("_timer dispose");
    _timer.cancel();
    super.dispose();
  }
}

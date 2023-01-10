import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'clock_notifier.dart';

// Note: StateNotifierProvider has two type annotations
final clockProvider = StateNotifierProvider<ClockNotifier, DateTime>((ref) {
  return ClockNotifier();
});

class TimePage extends StatelessWidget {
  const TimePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Consumer(
          builder: (_, WidgetRef ref, __) {
            // watch the StateNotifierProvider to return a DateTime (the state)
            final currentTime = ref.watch(clockProvider);

            // format the time as `hh:mm:ss`
            final timeFormatted = DateFormat.Hms().format(currentTime);

            return Text(
              timeFormatted,
              style: const TextStyle(fontSize: 30),
            );
          },
        ),
      ),
    );
  }
}

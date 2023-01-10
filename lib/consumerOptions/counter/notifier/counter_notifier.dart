import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterModel {
  final int count;

  const CounterModel(this.count);
}

class CounterNotifier extends StateNotifier<CounterModel> {
  CounterNotifier() : super(_initialValue);

  static const _initialValue = CounterModel(2);

  void increment() {
    state = CounterModel(state.count + 1);
  }
}

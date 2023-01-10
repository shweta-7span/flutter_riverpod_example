import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*-----------------StateNotifierProvider---------------------*/
/*final counterProvider = StateNotifierProvider((ref) => Counter());

class Counter extends StateNotifier<int> {
  Counter() : super(0);

  void increment() => state++;
}*/

/*-----------------StateProvider---------------------*/
final counterProvider = StateProvider<int>((ref) => 0);

// 1. widget class now extends [ConsumerWidget]
class CounterPageConsumerWidget extends ConsumerWidget {
  const CounterPageConsumerWidget({super.key, required this.title});

  final String title;

  // 2. build method has an extra [WidgetRef] argument
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 3. use ref.watch() to get the value of the provider
    final count = ref.watch(counterProvider);
    debugPrint('build count: $count');

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$count',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ref.read(counterProvider.notifier).increment(); //StateNotifierProvider
          ref.read(counterProvider.notifier).state++; //StateProvider
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

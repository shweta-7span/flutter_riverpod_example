import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'notifier/counter_notifier.dart';

/*-----------------StateNotifierProvider---------------------*/
final counterProvider = StateNotifierProvider<CounterNotifier, CounterModel>(
    (ref) => CounterNotifier());

class Counter extends StateNotifier<int> {
  Counter() : super(0);

  void increment() => state++;
}

/*-----------------StateProvider---------------------*/
// final counterProvider = StateProvider<int>((ref) => 0);

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('build');

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
            Consumer(
              builder: (_, WidgetRef ref, __) {
                final count = ref.watch(counterProvider);
                debugPrint('Consumer count: $count');

                return Text(
                  '${count.count}',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref
              .read(counterProvider.notifier)
              .increment(); //StateNotifierProvider
          // ref.read(counterProvider.notifier).state++; //StateProvider
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

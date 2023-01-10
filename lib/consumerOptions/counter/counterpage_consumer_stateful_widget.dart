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

// 1. extend [ConsumerStatefulWidget]
class CounterPageConsumerStatefulWidget extends ConsumerStatefulWidget {
  const CounterPageConsumerStatefulWidget({super.key, required this.title});

  final String title;

  @override
  ConsumerState<CounterPageConsumerStatefulWidget> createState() =>
      _CounterPageState();
}

// 2. extend [ConsumerState]
class _CounterPageState
    extends ConsumerState<CounterPageConsumerStatefulWidget> {
  @override
  void initState() {
    super.initState();
    // 3. if needed, we can read the provider inside initState
    final count = ref.read(counterProvider);
    debugPrint('initState count: $count');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            // 4. wrap with Consumer when user ref.watch() to
            // ReBuild only Consumer instead of whole build method
            Consumer(
              builder: (_, WidgetRef ref, __) {
                // 5. use ref.watch() to get the value of the provider
                final count = ref.watch(counterProvider);
                debugPrint('Consumer count: $count');

                return Text(
                  '$count',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
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

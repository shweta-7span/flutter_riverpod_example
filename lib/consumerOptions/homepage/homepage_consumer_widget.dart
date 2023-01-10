import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// provider that returns a string value
final homePageConsumerWidget =
    StateProvider<String>((ref) => 'HomePage ConsumerWidget');

// 1. widget class now extends [ConsumerWidget]
class HomePageConsumerWidget extends ConsumerWidget {
  const HomePageConsumerWidget({super.key, required this.title});

  final String title;

  // 2. build method has an extra [WidgetRef] argument
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 3. use ref.watch() to get the value of the provider
    final helloWorld = ref.watch(homePageConsumerWidget);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(helloWorld),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
                onPressed: () {
                  ref.read(homePageConsumerWidget.notifier).state =
                      "Update Text";
                },
                child: const Text('Click'))
          ],
        ),
      ),
    );
  }
}

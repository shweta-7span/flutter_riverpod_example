import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// provider that returns a string value
final homePageConsumerStatefulWidget =
    Provider<String>((_) => 'HomePage ConsumerStatefulWidget');

// 1. extend [ConsumerStatefulWidget]
class HomePageConsumerStatefulWidget extends ConsumerStatefulWidget {
  const HomePageConsumerStatefulWidget({super.key, required this.title});

  final String title;

  @override
  ConsumerState<HomePageConsumerStatefulWidget> createState() =>
      _MyHomePageThreeState();
}

// 2. extend [ConsumerState]
class _MyHomePageThreeState
    extends ConsumerState<HomePageConsumerStatefulWidget> {
  @override
  void initState() {
    super.initState();
    // 3. if needed, we can read the provider inside initState
    final helloWorld = ref.read(homePageConsumerStatefulWidget);
    debugPrint(helloWorld); // "Hello world"
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              ref.watch(homePageConsumerStatefulWidget),
            ),
          ],
        ),
      ),
    );
  }
}

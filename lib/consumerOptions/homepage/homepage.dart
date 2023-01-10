import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// provider that returns a string value
final homePageProvider = Provider<String>((ref) => 'HomePage');

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer(
              builder: (_, WidgetRef ref, __) {
                return Text(
                  ref.watch(homePageProvider),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

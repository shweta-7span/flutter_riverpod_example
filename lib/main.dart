import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'api/screens/login/loginpage.dart';

void main() {
  // wrap the entire app with a ProviderScope so that widgets
  // will be able to read providers
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const HomePageConsumerWidget(title: 'RiverPod 2.0'),
      // home: const CounterPage(title: 'RiverPod 2.0'),
      // home: const TimePage(title: 'RiverPod 2.0'),
      home: const LoginPage(),
      // home: const MoreApiScreen(),
      // home: const DropdownScreen(),
    );
  }
}

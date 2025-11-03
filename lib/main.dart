import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Isolate Examples',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const IsolateDemo(),
    );
  }
}

class IsolateDemo extends StatelessWidget {
  const IsolateDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column());
  }
}

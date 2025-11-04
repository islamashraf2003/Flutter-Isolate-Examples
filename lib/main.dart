import 'dart:isolate';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: IsolateDemo()));
}

class IsolateDemo extends StatefulWidget {
  const IsolateDemo({super.key});

  @override
  State<IsolateDemo> createState() => _IsolateDemoState();
}

/// This function is placed outside the widget tree because it runs in a separate isolate.
/// Isolates cannot access variables, state, or context from the main isolate.
/// It only communicates with the main isolate using the SendPort.
void heavyTask(SendPort sendPort) {
  int sum = 0;
  for (int i = 0; i < 500000000; i++) {
    sum += i;
  }

  sendPort.send(sum);
}

class _IsolateDemoState extends State<IsolateDemo> {
  String result = 'No result right now';

  Future<void> runHeavyTaskWithIsolate() async {
    setState(() {
      result = 'Calculating (with isolate)...';
    });
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(heavyTask, receivePort.sendPort);
    dynamic sum = await receivePort.first;

    setState(() {
      result = 'Result (with isolate) = $sum';
    });
  }

  Future<void> runHeavyTaskWithoutIsolate() async {
    setState(() {
      result = 'Calculating (without isolate)...';
    });

    int sum = 0;
    for (int i = 0; i < 500000000; i++) {
      sum += i;
    }

    setState(() {
      result = 'Result (no isolate) = $sum';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Isolate Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(result, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            CircularProgressIndicator(color: Colors.black),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: runHeavyTaskWithIsolate,
              child: const Text('Heavy Task'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: runHeavyTaskWithoutIsolate,
              child: const Text('Run Heavy Task WITHOUT Isolate'),
            ),
          ],
        ),
      ),
    );
  }
}

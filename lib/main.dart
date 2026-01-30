import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// 앱의 최상위 위젯
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // const 생성자

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: const CounterPage(),
    );
  }
}

/// 카운터 화면 (StatefulWidget)
class CounterPage extends StatefulWidget {
  const CounterPage({super.key}); // const 생성자

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2단계: 위젯의 이해'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$_counter',
              style: const TextStyle(fontSize: 40),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _incrementCounter,
              child: const Text('증가'),
            ),
          ],
        ),
      ),
    );
  }
}

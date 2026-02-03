import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: CounterPage());
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

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

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  // 메인 화면(MainScreen)에서 데이터를 기다리고 받는 코드
  void _navigateToDetail() async {
    final result = await Navigator.push(
      // await로 결과 대기
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(currentCount: _counter),
      ),
    );

    if (result != null) {
      // result 변수에는 "작업 완료!"라는 문자열이 담기게 됨
      setState(() {
        _counter = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('3단계: 레이아웃'),
        actions: [
          IconButton(
            onPressed: _navigateToDetail,
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.blue,
              alignment: Alignment.center,
              child: Text(
                _counter.toString(),
                style: const TextStyle(fontSize: 50, color: Colors.white),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _incrementCounter,
                child: const Text("증가"),
              ),
              ElevatedButton(
                onPressed: _decrementCounter,
                child: const Text("감소"),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _resetCounter,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final int currentCount;
  const DetailPage({super.key, required this.currentCount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("상세 페이지")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('현재 카운트: $currentCount'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, currentCount + 10),
              child: const Text("+10"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, currentCount - 10),
              child: const Text("-10"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// 2. 앱의 최상위 위젯 (MaterialApp 반환)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp( // <--- 수정 포인트 1: MaterialApp에 const 추가
      home: ContactListPage(), // <--- 수정 포인트 2: ContactListPage()에 const 추가
    );
  }
}

class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key}); // <--- 여기도 const 생성자로 변경

  @override
  Widget build(BuildContext context) {
    final List<String> contacts = [
      '김철수', '이영희', '박민준', '최서연', '정지훈',
      '강민서', '조현우', '윤지아', '임도윤', '황서윤',
      '송하준', '오은서', '장시우', '신예은', '한지민'
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('연락처 목록')),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (BuildContext ctx, int idx) {
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text(contacts[idx]),
            subtitle: const Text("전화번호: 010-1234-5678"),
            trailing: const Icon(Icons.call),
          );
        },
      ),
    );
  }
}

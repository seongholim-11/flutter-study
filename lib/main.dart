import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ContactListPage(),
    );
  }
}

class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  final List<String> _contacts = [
    '김철수', '이영희', '박민준', '최서연', '정지훈',
    '강민서', '조현우', '윤지아', '임도윤', '황서윤',
    '송하준', '오은서', '장시우', '신예은', '한지민'
  ];

  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addContact() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _contacts.add(_controller.text);
      });
      _controller.clear();
    }
  }

  void _removeContact(int index) {
    setState(() {
      _contacts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('연락처 목록')),
      body: Column(
        children: [
          // 1. 입력 위젯 사용 (완벽하게 구현하셨습니다)
          ContactInput(controller: _controller, onAdd: _addContact),
          // 2. 리스트 위젯 사용 (완벽하게 구현하셨습니다)
          ContactListView(contacts: _contacts, onRemove: _removeContact),
        ],
      ),
    );
  }
}

// --- 분리된 위젯 1: 연락처 입력 --- 
class ContactInput extends StatelessWidget {
  // 부모로부터 받을 데이터와 함수 선언
  final TextEditingController controller;
  final VoidCallback onAdd;

  // 생성자를 통해 전달받음
  const ContactInput({super.key, required this.controller, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller, // 전달받은 컨트롤러 사용
              decoration: const InputDecoration(hintText: "새 연락처 이름"),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: onAdd, // 전달받은 함수 사용
            child: const Text("추가"),
          ),
        ],
      ),
    );
  }
}

// --- 분리된 위젯 2: 연락처 목록 --- 
class ContactListView extends StatelessWidget {
  // 부모로부터 받을 데이터와 함수 선언
  final List<String> contacts;
  final void Function(int) onRemove; // Function(int) 타입으로 받음

  // 생성자를 통해 전달받음
  const ContactListView({super.key, required this.contacts, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    // [핵심] 리스트는 남는 공간을 모두 차지해야 하므로 Expanded로 감싸야 함
    return Expanded(
      child: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text(contacts[index]),
            subtitle: const Text("전화번호: 010-1234-5678"),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                onRemove(index); // 전달받은 함수 사용
              },
            ),
          );
        },
      ),
    );
  }
}

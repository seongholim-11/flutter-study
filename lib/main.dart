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
          Padding(
            padding: const EdgeInsets.all(8.0),
            // [오류 수정 1] Row의 자식들은 children: [] 리스트 안에 있어야 합니다.
            child: Row(
              children: [
                // [오류 수정 2] TextField는 남는 공간을 모두 차지하도록 Expanded로 감쌉니다.
                Expanded(
                  child: TextField(
                    controller: _controller,
                    // [요구사항 수정] hintText를 추가합니다.
                    decoration: const InputDecoration(hintText: "새 연락처 이름"),
                  ),
                ),
                const SizedBox(width: 8), // 입력 필드와 버튼 사이에 간격을 줍니다.
                ElevatedButton(
                  onPressed: _addContact,
                  child: const Text("추가"),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(_contacts[index]),
                  subtitle: const Text("전화번호: 010-1234-5678"),
                  // [오류 수정 3] IconButton은 const가 될 수 없으며,
                  // onPressed는 함수 자체를 전달해야 합니다.
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    // [오류 수정 4] () => _removeContact(index) 형태로 함수를 전달해야 합니다.
                    onPressed: () {
                      _removeContact(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

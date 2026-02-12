import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // [요구사항 1] MaterialApp에 테마 적용
    return MaterialApp(
      title: '연락처 앱',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ContactListPage(),
    );
  }
}

// ... (ContactListPage, _ContactListPageState 코드는 변경 없음) ...
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
          ContactInput(controller: _controller, onAdd: _addContact),
          ContactListView(contacts: _contacts, onRemove: _removeContact),
        ],
      ),
    );
  }
}


class ContactInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAdd;

  const ContactInput({super.key, required this.controller, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: "새 연락처 이름"),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: onAdd,
            // [수정] Text에 불필요한 스타일 제거
            // 버튼은 테마로부터 자동으로 스타일을 부여받습니다.
            child: const Text("추가"),
          ),
        ],
      ),
    );
  }
}

class ContactListView extends StatelessWidget {
  final List<String> contacts;
  final void Function(int) onRemove;

  const ContactListView({super.key, required this.contacts, required this.onRemove});

  @override
  Widget build(BuildContext context) {
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
                onRemove(index);
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactDetailPage(
                    name: contacts[index],
                    phone: '010-1234-5678',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ContactDetailPage extends StatelessWidget {
  final String name;
  final String phone;

  const ContactDetailPage({super.key, required this.name, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$name 님의 정보')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // [요구사항 2] 하드코딩된 스타일을 테마 스타일로 변경
            Icon(
              Icons.person,
              size: 100,
              color: Theme.of(context).colorScheme.primary, // 테마의 기본 색상
            ),
            const SizedBox(height: 16),
            Text(
              name,
              style: Theme.of(context).textTheme.headlineMedium, // 테마의 headlineMedium 스타일
            ),
            const SizedBox(height: 8),
            Text(
              phone,
              style: Theme.of(context).textTheme.bodyLarge, // 테마의 bodyLarge 스타일
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("뒤로가기"),
            ),
          ],
        ),
      ),
    );
  }
}

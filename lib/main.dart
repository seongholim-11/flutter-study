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

class Contact {
  String name;
  String phone;
  bool isFavorite; // 즐겨찾기 여부

  // 생성자
  Contact({required this.name, required this.phone, this.isFavorite = false});
}

// ... (ContactListPage, _ContactListPageState 코드는 변경 없음) ...
class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  final List<Contact> _contacts = [
    Contact(name: '김철수', phone: '010-1234-5678', isFavorite: false),
    Contact(name: '이영희', phone: '010-1234-5678', isFavorite: false),
    Contact(name: '박민준', phone: '010-1234-5678', isFavorite: false),
    Contact(name: '최서연', phone: '010-1234-5678', isFavorite: false),
    Contact(name: '정지훈', phone: '010-1234-5678', isFavorite: false),
    Contact(name: '강민서', phone: '010-1234-5678', isFavorite: false),
    Contact(name: '조현우', phone: '010-1234-5678', isFavorite: false),
    Contact(name: '윤지아', phone: '010-1234-5678', isFavorite: false),
    Contact(name: '임도윤', phone: '010-1234-5678', isFavorite: false),
    Contact(name: '황서윤', phone: '010-1234-5678', isFavorite: false),
    Contact(name: '송하준', phone: '010-1234-5678', isFavorite: false),
    Contact(name: '오은서', phone: '010-1234-5678', isFavorite: false),
    Contact(name: '장시우', phone: '010-1234-5678', isFavorite: false),
    Contact(name: '신예은', phone: '010-1234-5678', isFavorite: false),
    Contact(name: '한지민', phone: '010-1234-5678', isFavorite: false),
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
        _contacts.add(Contact(name: _controller.text, phone: '010-0000-0000'));
      });
      _controller.clear();
    }
  }

  void _toggleFavorite(int index) {
    setState(() {
      _contacts[index].isFavorite = !_contacts[index].isFavorite;
    });
  }

  void _removeContact(int index) {
    setState(() {
      showDialog(
        context: context, // 현재 위젯의 context
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text('삭제 확인'),
            content: const Text('정말로 삭제하시겠습니까?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext), // 다이얼로그 닫기
                child: const Text('취소'),
              ),
              TextButton(
                onPressed: () {
                  // ... 실제 삭제 로직 실행 ...

                  _contacts.removeAt(index);
                  Navigator.pop(dialogContext); // 다이얼로그 닫기
                },
                child: const Text('삭제'),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('연락처 목록')),
      body: Column(
        children: [
          ContactInput(controller: _controller, onAdd: _addContact),
          ContactListView(
            contacts: _contacts,
            onRemove: _removeContact,
            onToggleFavorite: _toggleFavorite,
          ),
        ],
      ),
    );
  }
}

class ContactInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAdd;

  const ContactInput({
    super.key,
    required this.controller,
    required this.onAdd,
  });

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
  final List<Contact> contacts;
  final void Function(int) onRemove;
  final void Function(int) onToggleFavorite;

  const ContactListView({
    super.key,
    required this.contacts,
    required this.onRemove,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: IconButton(
              onPressed: () {
                onToggleFavorite(index);
              },
              color: Colors.amber,
              icon: contacts[index].isFavorite
                  ? Icon(Icons.star)
                  : Icon(Icons.star_border),
            ),
            title: Text(contacts[index].name),
            subtitle: Text(contacts[index].phone),
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
                    name: contacts[index].name,
                    phone: contacts[index].phone,
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
              style: Theme.of(
                context,
              ).textTheme.headlineMedium, // 테마의 headlineMedium 스타일
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

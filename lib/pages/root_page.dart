import 'package:flutter/material.dart';
import './chat/chat_page.dart';
import './find/find_page.dart';
import './friends/friends_page.dart';
import './my/my_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key, required this.title});

  final String title;

  @override
  State<RootPage> createState() => _RootPage();
}

class _RootPage extends State<RootPage> {
  int _currentIndex = 0;

  List<Widget> _pages = [ChatPage(), FriendsPage(), FindPage(), MyPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 12.0,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.red[600],
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.wechat),
              label: '微信',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contact_phone),
              label: '通讯录',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chair),
              label: '发现',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.self_improvement),
              label: '我的',
            )
          ]),
      // body: const RootPage(),
    );
  }
}

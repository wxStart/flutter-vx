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

  // 作为页面缓存
  List<Widget> _cache = [];

  final List _pages = [
    (BuildContext context) => const ChatPage(),
    (BuildContext context) => FriendsPage(context: context),
    (BuildContext context) => const FindPage(),
    (BuildContext context) => const MyPage()
  ];

  final PageController _controller = PageController();

  // 创建页面
  List<Widget> _cretaPage(BuildContext context) {
    // 主要是想在 FriendsPage 组件 initState中  就使用 context;
    if (_cache.isEmpty) {
      _cache = _pages.map<Widget>((item) => item(context)).toList();
    }
    return _cache;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        // physics: const NeverScrollableScrollPhysics(), 禁止左右拖拽改变页面
        onPageChanged: (index) {
          // 左右拖拽 页面切换变化
          setState(() {
            _currentIndex = index;
          });
        },
        controller: _controller,
        children: _cretaPage(context),
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 12.0,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              _controller.jumpToPage(index);
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

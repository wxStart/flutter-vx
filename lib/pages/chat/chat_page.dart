import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_vx/common/iconfont.dart';
import 'package:flutter_vx/const.dart';
import 'package:flutter_vx/pages/friends/friend_data.dart';
import 'package:http/http.dart' as http;

class Chat {
  final String name;
  final String message;
  final String imageUrl;

  Chat({required this.name, required this.message, required this.imageUrl});

  factory Chat.fromMap(Map map) {
    return Chat(
      name: map['chat_name'],
      message: map['message'],
      imageUrl: map['chat_url'],
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with AutomaticKeepAliveClientMixin<ChatPage> {
  bool _loading = false;
  bool _hasError = false;
  List<Chat> _datas = [];
  bool _netWork = false;

  bool _timeout = false;

  Future<List<Chat>> geDatas() async {
    _timeout = false;
    setState(() {
      _loading = true;
      _hasError = false;
      _netWork = false;
    });
    var url =
        Uri.parse('http://rap2api.taobao.org/app/mock/316903/api/chat/list');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      List<Chat> lists =
          res['lists'].map<Chat>((el) => Chat.fromMap(el)).toList();
      return lists;
    } else {
      throw Exception("statusCode: ${response.statusCode}");
    }
  }

  @override
  void initState() {
    super.initState();
    print('初始化了');
    // 获取网络数据
    geDatas()
        .then((List<Chat> datas) {
          if (!_timeout) {
            setState(() {
              _loading = false;
              _hasError = false;
              _datas = datas;
            });
          }
        })
        .catchError((e) {
          if (!_timeout) {
            setState(() {
              _hasError = true;
            });
          }
          // 错误
          print(e);
        })
        .whenComplete(() {
          print('执行到了  完毕');
        })
        .timeout(const Duration(seconds: 10))
        // .timeout(const Duration(microseconds: 10))
        .catchError((timeout) {
          _timeout = true;
          setState(() {
            _netWork = true;
            _loading = false;
            _hasError = false;
            _datas = [];
          });
          print("超时 $timeout ");
        });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
          child: _loading
              ? const Text('loading...')
              : _hasError
                  ? const Text('出错了')
                  : _netWork
                      ? const Text('网络不好')
                      : _datas.isEmpty //_datas.length == 0;
                          ? const Text('空页面站位')
                          : ListView.builder(
                              itemBuilder: (BuildContext context, int index) {
                                var item = _datas[index];
                                return ListTile(
                                  title: Text(item.name),
                                  subtitle: Container(
                                    margin: const EdgeInsets.only(top: 8),
                                    height: 20,
                                    child: Text(
                                      item.message,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  leading: Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      image: DecorationImage(
                                        image: NetworkImage(item.imageUrl),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: _datas.length,
                            )),
      appBar: AppBar(
        backgroundColor: weChatThemeColor,
        centerTitle: true,
        title: const Text(
          '微信',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          PopupMenuButton(
              color: Color.fromRGBO(0, 0, 0, 0.5),
              offset: Offset(0, 40), //40这个值是我实验出来的实际上是要算的
              child: const Icon(
                IconFont.icon_tianjia,
                color: Color.fromRGBO(33, 33, 33, 0.65),
                size: 22,
              ),
              onSelected: (value) {},
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<dynamic>>[
                  PopupMenuItem(
                      onTap: () {
                        print('点击了');
                      },
                      child: const Text(
                        '发起群聊',
                        style: TextStyle(color: Colors.white),
                      )),
                  const PopupMenuItem(
                      child: Text(
                    '添加好友',
                    style: TextStyle(color: Colors.white),
                  )),
                  const PopupMenuItem(
                      child: Text(
                    '扫一扫',
                    style: TextStyle(color: Colors.white),
                  )),
                  const PopupMenuItem(
                      child: Text(
                    '收款码',
                    style: TextStyle(color: Colors.white),
                  )),
                ];
              })
        ],
      ),
      // backgroundColor: weChatThemeColor,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

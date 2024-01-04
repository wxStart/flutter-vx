import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_vx/common/iconfont.dart';
import 'package:flutter_vx/const.dart';
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

class _ChatPageState extends State<ChatPage> {
  Future<List<Chat>> geDatas() async {
    var url =
        Uri.parse('http://rap2api.taobao.org/app/mock/316903/api/chat/list');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    print("Response body的类型:  ${response.body is String}");

    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      print(res['lists']);

      List<Chat> lists =
          res['lists'].map<Chat>((el) => Chat.fromMap(el)).toList();
      return lists;
    } else {
      throw Exception("statusCode: ${response.statusCode}");
    }

    // final chatMap = {'chat_name': 'wxx', 'message': '123141', 'chat_url': '123123'};
    // print(chatMap);
    // final chatJson = json.encode(chatMap); // 转字符串
    // print(chatJson is String);
    // final chatMap1 = json.decode(chatJson);
    // print(chatMap1 is Map);

    // final chatModel = Chat.fromMap(chatMap1);
    // print(chatModel);
  }

  @override
  void initState() {
    super.initState();
    // 获取网络数据
    // geDatas().then((value) {
    //   print("1 $value");
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: geDatas(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // print("snapshot_ ${snapshot.data}");
            if (snapshot.connectionState == ConnectionState.waiting) {
              // 网络请求中的时候
              return Container(
                child: const Text('loading... '),
              );
            }
            // 加载到了数据
            return ListView(
              children: snapshot.data.map<Widget>((Chat item) {
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
                  // leading: CircleAvatar(
                  //   backgroundImage: NetworkImage(item.imageUrl),
                  // ),
                );
              }).toList(),
            );
          },
        ),
      ),
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
}

import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          alignment: const Alignment(0, 0),
          child: Text(
            '微信页面',
            style: TextStyle(
              color: Colors.red[300],
              fontSize: 24,
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text(
            '微信',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          backgroundColor: Colors.grey[350],
        ),
        backgroundColor: Colors.amber[200]);
  }
}

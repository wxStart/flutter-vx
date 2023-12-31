import 'package:flutter/material.dart';

class FindPage extends StatefulWidget {
  const FindPage({super.key});

  @override
  State<FindPage> createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Image(image: AssetImage('images/pengyouquan.jpeg')),
      ),
      appBar: AppBar(
        title: const Text('发现页面'),
      ),
    );
  }
}

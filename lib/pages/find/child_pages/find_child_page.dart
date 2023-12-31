import 'package:flutter/material.dart';

class FindChildPage extends StatelessWidget {
  String title;

  FindChildPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        alignment: const Alignment(0, 0),
        color: Colors.cyan[300],
        child: Text(title),
      ),
    );
  }
}

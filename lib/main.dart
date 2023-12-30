import 'package:flutter/material.dart';

import 'pages/root_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        primarySwatch: Colors.grey,
        highlightColor: const Color.fromRGBO(0, 0, 0, 0),
        splashColor: const Color.fromRGBO(0, 0, 0, 0),
      ),
      home: const RootPage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: true,
    );
  }
}

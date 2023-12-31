import 'package:flutter/material.dart';
import './find_item.dart';

class FindPage extends StatefulWidget {
  const FindPage({super.key});

  @override
  State<FindPage> createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  final Color _themColor = const Color.fromRGBO(222, 222, 222, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _themColor,
      body: Container(
        height: 800,
        child: ListView(
          children: [
            const FindItem(
              title: '朋友圈',
              imageName: 'images/pengyouquan.png',
            ),
            const SizedBox(height: 10),
            const FindItem(title: '摇一摇', imageName: 'images/yaoyiyao.png'),
            Row(
              children: [
                Container(
                  width: 50,
                  height: 0.5,
                  color: Colors.white,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 10,
                    height: 0.5,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
            const FindItem(title: '定位', imageName: 'images/dingwei.png'),
            const SizedBox(height: 10),
            const FindItem(
              title: '购物',
              imageName: 'images/gouwu.png',
              subTitle: '2023跨年购物节',
              subImageName: 'images/red-round.png',
            ),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('发现'),
        backgroundColor: _themColor,
      ),
    );
  }
}

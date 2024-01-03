import 'package:flutter/material.dart';
import 'package:flutter_vx/const.dart';
import 'package:flutter_vx/pages/friends/friend_data.dart';

class IndexBar extends StatefulWidget {
  const IndexBar({super.key, required this.indexCallBack});

  final void Function(String str) indexCallBack;

  @override
  State<IndexBar> createState() => _IndexBarState();
}

class _IndexBarState extends State<IndexBar> {
  Color _bgColor = const Color.fromRGBO(1, 1, 1, 0.0);
  Color _textColor = Colors.grey;

  //
  createWord() {
    final List<Widget> words = [];
    for (int i = 0; i < indexWord.length; i++) {
      words.add(Expanded(
          child: Text(
        indexWord[i],
        style: TextStyle(fontSize: 12, color: _textColor),
      )));
    }
    return words;
  }

  String getWord(BuildContext context, Offset globalPosition) {
    RenderBox box = context.findRenderObject() as RenderBox;
    // print('更新到了 ${globalPosition}');
    // print('在盒子的坐标位置： ${box.globalToLocal(globalPosition)}');
    double y = box.globalToLocal(globalPosition).dy;
    // 算出字节高度
    var itemHeight = screenHeihgt(context) / 2 / (indexWord.length);
    // 算出是第几个item   并且限制取值范围
    int index = (y ~/ itemHeight).clamp(0, indexWord.length - 1);
    // print("现在拖到 ${indexWord[index]} 了");
    return indexWord[index];
  }

  //
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: screenHeihgt(context) / 8,
      right: 0,
      height: screenHeihgt(context) / 2,
      width: 30,
      child: GestureDetector(
        onVerticalDragDown: (DragDownDetails details) {
          print('进入到了 ${details.globalPosition}');
          // 拖拽按下事件
          setState(
            () {
              _bgColor = const Color.fromRGBO(1, 1, 1, 0.5);
              _textColor = Colors.white;
            },
          );
        },
        onVerticalDragUpdate: (details) {
          // 获取到当前小部件的盒子
          String str = getWord(context, details.globalPosition);
          widget.indexCallBack(str);
        },
        onVerticalDragEnd: (details) {
          // 拖拽按下事件
          setState(
            () {
              _bgColor = const Color.fromRGBO(1, 1, 1, 0.0);
              _textColor = Colors.grey;
            },
          );
        },
        child: Container(
          color: _bgColor,
          child: Column(
            children: createWord(),
          ),
        ),
      ),
    );
  }
}

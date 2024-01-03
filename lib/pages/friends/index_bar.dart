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

  double _indicatorY = 0.0;
  String _indicatorText = "A";
  bool _indicatorHide = true;

  //
  createWord() {
    final List<Widget> words = [];
    double width = screenHeihgt(context) / 2 / indexWord.length;
    for (int i = 0; i < indexWord.length; i++) {
      bool isAtive = _indicatorText == indexWord[i] && !_indicatorHide;

      words.add(Expanded(
        child: Container(
          decoration: BoxDecoration(
              color: isAtive ? Colors.green : Colors.transparent,
              borderRadius: BorderRadius.circular(width)),
          alignment: Alignment.center,
          // color: isAtive ? Colors.green : Colors.transparent,
          width: width,
          height: width,
          child: Text(
            indexWord[i],
            style: TextStyle(
                fontSize: 12, color: isAtive ? _textColor : Colors.grey),
          ),
        ),
      ));
    }
    return words;
  }

  int getWord(BuildContext context, Offset globalPosition) {
    RenderBox box = context.findRenderObject() as RenderBox;
    // print('更新到了 ${globalPosition}');
    // print('在盒子的坐标位置： ${box.globalToLocal(globalPosition)}');
    double y = box.globalToLocal(globalPosition).dy;
    // 算出字节高度
    var itemHeight = screenHeihgt(context) / 2 / (indexWord.length);
    // 算出是第几个item   并且限制取值范围
    int index = (y ~/ itemHeight).clamp(0, indexWord.length - 1);
    // print("现在拖到 ${indexWord[index]} 了");
    return index;
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
        width: _indicatorHide ? 30 : 90,
        child: Row(
          children: [
            // 指示器
            _indicatorHide
                ? Container(
                    width: 0,
                  )
                : Container(
                    // alignment: Alignment(0, 1.1),
                    alignment: Alignment(0, _indicatorY),
                    width: 60,
                    child: Stack(
                      alignment: const Alignment(-0.1, 0),
                      children: [
                        // 气泡
                        const Image(
                          image: AssetImage('images/tip.png'),
                          width: 60,
                        ),
                        Text(
                          _indicatorText,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 30),
                        )
                      ],
                    ),
                  ),

            // 索引条
            GestureDetector(
              onVerticalDragDown: (DragDownDetails details) {
                // print('进入到了 ${details.globalPosition}');
                int index = getWord(context, details.globalPosition);
                String str = indexWord[index];
                widget.indexCallBack(str);
                // 拖拽按下事件
                setState(
                  () {
                    _indicatorY = (2.2 / (indexWord.length - 1) * index) - 1.1;
                    _indicatorText = str;
                    _indicatorHide = false;
                    _bgColor = const Color.fromRGBO(1, 1, 1, 0.5);
                    _textColor = Colors.white;
                  },
                );
              },
              onVerticalDragUpdate: (details) {
                // 获取到当前小部件的盒子
                int index = getWord(context, details.globalPosition);
                String str = indexWord[index];

                widget.indexCallBack(str);

                setState(() {
                  _indicatorY = (2.2 / (indexWord.length - 1) * index) - 1.1;
                  print("_indicatorY $_indicatorY");
                  _indicatorText = str;
                  _indicatorHide = false;
                });
              },
              onLongPressMoveUpdate: (LongPressMoveUpdateDetails details) {
                // 获取到当前小部件的盒子
                int index = getWord(context, details.globalPosition);
                String str = indexWord[index];

                widget.indexCallBack(str);

                setState(() {
                  _indicatorY = (2.2 / (indexWord.length - 1) * index) - 1.1;
                  print("_indicatorY $_indicatorY");
                  _indicatorText = str;
                  _indicatorHide = false;
                });
              },
              onVerticalDragEnd: (details) {
                // 拖拽按下事件
                setState(
                  () {
                    _bgColor = const Color.fromRGBO(1, 1, 1, 0.0);
                    _textColor = Colors.grey;
                    _indicatorHide = true;
                  },
                );
              },
              child: Container(
                // color: _bgColor,
                width: 30,
                child: Column(
                  children: createWord(),
                ),
              ),
            ),
          ],
        ));
  }
}

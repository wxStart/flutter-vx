import 'package:flutter/material.dart';
import 'package:flutter_vx/common/iconfont.dart';
import 'package:flutter_vx/const.dart';
import 'package:flutter_vx/pages/friends/friend_cell.dart';
import 'package:flutter_vx/pages/friends/index_bar.dart';
import './friend_data.dart';

class FriendsPage extends StatefulWidget {
  FriendsPage({super.key, required this.context});

  BuildContext context;

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  // 字典   字母和对应的高度

  final Map _groupOffestMap = {
    // indexWord[0]:0.0,
  };

  final List<Friend> _lists = [];

  late ScrollController _scrollController;

  Widget _itemBuilder(
    BuildContext context,
    int index,
  ) {
    if (index < headData.length) {
      Friend item = headData[index];
      return FriendCell(name: item.name, assetImageUrl: item.imageUrl);
    }

    Friend item = _lists[index - headData.length];
    bool hideGroup = index - headData.length > 0 &&
        item.indexLetter == _lists[index - headData.length - 1].indexLetter!;

    return FriendCell(
        name: item.name,
        imageUrl: item.imageUrl,
        groupTitle: hideGroup ? null : item.indexLetter);
  }

  void indexCallBack(String str) {
    // 获取˝ str 字母的高度
    print("str $str");
    if (_groupOffestMap[str] != null) {
      _scrollController.jumpTo(_groupOffestMap[str]); // 微信的效果  直接跳转
      // _scrollController.animateTo(_groupOffestMap[str],
      //     duration: const Duration(microseconds: 50), curve: Curves.easeIn);
    }
  }

  //
  @override
  void initState() {
    print('通讯录初始化了');
    super.initState();
    _lists
      ..addAll(datas)
      ..addAll(datas);

    // 排序
    _lists
        .sort((Friend a, Friend b) => a.indexLetter!.compareTo(b.indexLetter!));

    _scrollController = ScrollController();

    // 循环计算每一个头的位置
    var _groupOffest = friendCellHeight * headData.length; // A的初始高度

    var len = _lists.length;
    var fullHeight = screenHeihgt(widget.context) - 205;
    // fullHeight 是listview的高度，205是我的设备估算的去掉头部和底部的高度
    // 感觉也是可以抽一个单独的ListView去获取高度

    var wordLen = 0; // 下方的26（26-wordLen）就是假设所有字母都有,不然就得动态算后续剩余分割符所占的高度

    for (var i = 0; i < len; i++) {
      if (i < 1) {
        _groupOffestMap.addAll({_lists[i].indexLetter: _groupOffest});
        wordLen++;
        // 第一个cell 一定有头
        if ((len - i) * friendCellHeight +
                (26 - wordLen) * friendCellSplitterHeight >
            fullHeight) {
          _groupOffest += friendCellHeight + friendCellSplitterHeight;
        }
      } else if (_lists[i].indexLetter == _lists[i - 1].indexLetter) {
        // 和前一个相同
        if ((len - i) * friendCellHeight +
                (26 - wordLen) * friendCellSplitterHeight >
            fullHeight) {
          _groupOffest += friendCellHeight;
        }
      } else {
        _groupOffestMap.addAll({_lists[i].indexLetter: _groupOffest});
        wordLen++;
        if ((len - i) * friendCellHeight +
                (26 - wordLen) * friendCellSplitterHeight >
            fullHeight) {
          _groupOffest += friendCellHeight + friendCellSplitterHeight;
        }
      }
      // 如果后续数据的高度小于屏幕（ListView）高度不加了就行 但是要考虑 分割符
    }
    print(_groupOffestMap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: weChatThemeColor,
        appBar: AppBar(
          actions: [
            Container(
                margin: const EdgeInsets.only(right: 15),
                child: const Icon(
                  IconFont.icon_sousuo1,
                  color: Color.fromRGBO(33, 33, 33, 0.65),
                  size: 24,
                )),
            Container(
                margin: const EdgeInsets.only(right: 15),
                child: const Icon(
                  IconFont.icon_tianjia,
                  color: Color.fromRGBO(33, 33, 33, 0.65),
                  size: 22,
                )),
          ],
          backgroundColor: weChatThemeColor,
          centerTitle: true,
          title: const Text('通讯录'),
        ),
        body: Stack(
          children: [
            Container(
              child: ListView.builder(
                controller: _scrollController,
                itemBuilder: (BuildContext context, int index) =>
                    _itemBuilder(context, index),
                itemCount: headData.length + _lists.length,
              ),
            ),
            IndexBar(indexCallBack: indexCallBack)
          ],
        ));
  }
}

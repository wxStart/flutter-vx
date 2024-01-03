import 'package:flutter/material.dart';
import 'package:flutter_vx/common/iconfont.dart';
import 'package:flutter_vx/const.dart';
import 'package:flutter_vx/pages/friends/friend_cell.dart';
import 'package:flutter_vx/pages/friends/index_bar.dart';
import './friend_data.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  final List<Friend> _lists = [];

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

  String indexCallBack(String str) {
    print('接收到了子组件的 $str');
    return str;
  }

  //
  @override
  void initState() {
    super.initState();
    _lists
      ..addAll(datas)
      ..addAll(datas);

    // 排序
    _lists
        .sort((Friend a, Friend b) => a.indexLetter!.compareTo(b.indexLetter!));
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

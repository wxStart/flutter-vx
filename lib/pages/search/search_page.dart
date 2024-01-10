import 'package:flutter/material.dart';
import 'package:flutter_vx/common/iconfont.dart';
import 'package:flutter_vx/const.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchBar(),
          Expanded(
            flex: 1,
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Container(
                color: Colors.red,
                child: ListView.builder(
                  itemBuilder: itemBuilder,
                  itemCount: 3,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    return Text("1111212313 --- $index");
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 94,
      color: weChatThemeColor,
      child: Column(
        children: [
          const SizedBox(
            height: 44,
          ),
          Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 35,
                      margin: const EdgeInsets.only(left: 8, right: 8),
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            IconFont.icon_sousuo1,
                            size: 16,
                          ),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              cursorColor: Colors.green,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black87,
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '搜索',
                                contentPadding: EdgeInsets.only(
                                  left: 10,
                                  bottom: 10,
                                  right: 20,
                                ), // 把输入框的内容网上面抬 对齐使用的
                              ),
                            ),
                          ),
                          Icon(
                            IconFont.icon_quxiao,
                            color: Colors.grey,
                            size: 16,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                    child: const Text('取消'),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}

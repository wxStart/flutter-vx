import 'package:flutter/material.dart';
import 'package:flutter_vx/common/iconfont.dart';
import 'package:flutter_vx/const.dart';
import 'package:flutter_vx/pages/chat/chat_page.dart';

class SearchPage extends StatefulWidget {
  List<Chat> datas;

  SearchPage({super.key, required this.datas});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Chat> _fitterDatas = [];
  String _search = '';

  final TextStyle _normalStyle =
      const TextStyle(color: Colors.black, fontSize: 16);
  final TextStyle _highlightStyle =
      const TextStyle(color: Colors.green, fontSize: 16);

  void _searchDatas(String search) {
    _fitterDatas.clear();
    if (search.isNotEmpty) {
      _fitterDatas = widget.datas
          .where((element) => element.name.contains(search))
          .toList();
    }
    setState(() {
      _search = search;
      _fitterDatas = _fitterDatas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchBar(onChangedValue: _searchDatas),
          Expanded(
            flex: 1,
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Container(
                child: ListView.builder(
                  itemBuilder: itemBuilder,
                  itemCount: _fitterDatas.length,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget itemNameBuilder(String name) {
    bool isNotEmpty = _search.isNotEmpty;

    if (isNotEmpty) {
      List<String> _nameList = isNotEmpty ? name.split(_search) : [];
      List<TextSpan> _children = [];
      for (var i = 0; i < _nameList.length; i++) {
        if (i != _nameList.length - 1) {
          _children.addAll([
            TextSpan(
              text: _nameList[i],
              style: _normalStyle,
            ),
            TextSpan(
              text: _search,
              style: _highlightStyle,
            ),
          ]);
        } else {
          _children.add(
            TextSpan(
              text: _nameList[i],
              style: _normalStyle,
            ),
          );
        }
      }

      return RichText(
        text: TextSpan(
          children: _children,
        ),
      );
    }
    return Text(name);
  }

  Widget itemBuilder(BuildContext context, int index) {
    var item = _fitterDatas[index];
    return ListTile(
      title: itemNameBuilder(item.name),
      subtitle: Container(
        margin: const EdgeInsets.only(top: 8),
        height: 20,
        child: Text(
          item.message,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          image: DecorationImage(
            image: NetworkImage(item.imageUrl),
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  final ValueChanged<String> onChangedValue;
  const SearchBar({super.key, required this.onChangedValue});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();

  bool _showClear = false;

  void _onChange(String text) {
    if (widget.onChangedValue != null && widget.onChangedValue is Function) {
      widget.onChangedValue(text);
    }
    setState(() {
      _showClear = text.isNotEmpty;
    });
  }

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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            IconFont.icon_sousuo1,
                            size: 16,
                          ),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              controller: _controller,
                              onChanged: _onChange,
                              cursorColor: Colors.green,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black87,
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: const InputDecoration(
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
                          if (_showClear)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _controller.clear();
                                  // _showClear = false;
                                  _onChange("");
                                });
                              },
                              child: const Icon(
                                IconFont.icon_quxiao,
                                color: Colors.grey,
                                size: 16,
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 40,
                      child: const Text('取消'),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_vx/const.dart';

class FriendCell extends StatefulWidget {
  FriendCell({
    super.key,
    this.assetImageUrl,
    this.imageUrl,
    required this.name,
    this.groupTitle,
  });

  String? assetImageUrl;
  String? imageUrl;
  String name;
  String? groupTitle;
  @override
  State<FriendCell> createState() => _FriendCellState();
}

class _FriendCellState extends State<FriendCell> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 8),
          alignment: Alignment.bottomLeft,
          color: weChatThemeColor,
          height: widget.groupTitle != null ? 30 : 0,
          child: widget.groupTitle != null ? Text(widget.groupTitle!) : null,
        ),
        Container(
          height: 52,
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 图标
              Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(left: 8, right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: (widget.imageUrl != null
                          ? NetworkImage(widget.imageUrl!)
                          : AssetImage(widget.assetImageUrl!)) as ImageProvider,
                    ),
                  )),

              // 文字和下划线
              Expanded(
                  flex: 1,
                  child: Container(
                      height: 52,
                      child: Column(
                        children: [
                          // 文字
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.name,
                              ),
                            ),
                          ),
                          // 下划线
                          Container(
                            height: 0.5,
                            color: weChatThemeColor,
                          )
                        ],
                      ))),
            ],
          ),
        )
      ],
    );
  }
}

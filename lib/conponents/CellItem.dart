import 'package:flutter/material.dart';

class CellItem extends StatefulWidget {
  final String title;
  final String? subTitle;
  final String imageName;
  final String? subImageName;
  final Function? onTap;

  const CellItem({
    super.key,
    required this.title,
    this.subTitle,
    required this.imageName,
    this.subImageName,
    this.onTap,
  })  : assert(title != null, 'title 不能为空'),
        assert(imageName != null, 'imageNamne 不能为空');

  @override
  State<StatefulWidget> createState() => _CellItemState();
}

class _CellItemState extends State<CellItem> {
  Color _activeColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _activeColor = Colors.white;
        });
      },
      onTapDown: (TapDownDetails details) {
        setState(() {
          _activeColor = Colors.grey;
        });
      },
      onTapCancel: () {
        setState(() {
          _activeColor = Colors.white;
        });
      },
      child: Container(
        color: _activeColor,
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // left
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // 图标
                  Image(
                    image: AssetImage(widget.imageName),
                    width: 30,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(widget.title)
                  // title
                ],
              ),
            ),
            // right
            Container(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  widget.subTitle != null
                      ? Text(widget.subTitle!)
                      : const Text(''),
                  widget.subImageName != null
                      ? Image(
                          image: AssetImage(widget.subImageName!),
                          width: 18,
                        )
                      : Container(),
                  const Image(
                    image: AssetImage('images/right-arrow.png'),
                    width: 18,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

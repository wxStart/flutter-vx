import 'package:flutter/material.dart';

import './child_pages/find_child_page.dart';

class FindItem extends StatelessWidget {
  final String title;
  final String? subTitle;
  final String imageName;
  final String? subImageName;
  final Function? onTap;

  const FindItem({
    super.key,
    required this.title,
    this.subTitle,
    required this.imageName,
    this.subImageName,
    this.onTap,
  })  : assert(title != null, 'title 不能为空'),
        assert(imageName != null, 'imageNamne 不能为空');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 这里调用方法
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => FindChildPage(title: title)));
      },
      child: Container(
        color: Colors.white,
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
                    image: AssetImage(imageName),
                    width: 30,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(title)
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
                  subTitle != null ? Text(subTitle!) : const Text(''),
                  subImageName != null
                      ? Image(
                          image: AssetImage(subImageName!),
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

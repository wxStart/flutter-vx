import 'package:flutter/material.dart';
import '../../conponents/CellItem.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  Widget headerWidget() {
    return Container(
      height: 300,
      color: Colors.white,
      child: Container(
        margin:
            const EdgeInsets.only(top: 100, right: 10, bottom: 20, left: 20),
        child: Row(
          children: [
            // 左侧头像

            Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30), // 倒角就应该使用背景图片
                image: const DecorationImage(
                  image: AssetImage('images/yangmi.jpeg'),
                ),
              ),
              // child: const Image(
              //   image: AssetImage('images/yangmi.jpeg'),
              //   width: 160,
              // ),
            ),

            // Container(
            //   width: MediaQuery.of(context).size.width - 10 - 20 - 160 - 15,
            //   margin: EdgeInsets.only(left: 15),
            //   color: Colors.black,
            // )
            Expanded(
              flex: 1,
              child: Container(
                // height: 180,
                margin: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: const Text(
                        '92岁老大爷',
                        style: TextStyle(
                          color: Color.fromRGBO(33, 33, 33, 0.7),
                          fontSize: 26,
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Container(
                              child: RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                    color: Color.fromRGBO(33, 33, 33, 0.45),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '微信号:',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    TextSpan(
                                      text: 'wx_xxxxx_19',
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(222, 222, 222, 1),
        child: Stack(
          children: [
            //列表
            Container(
              child: MediaQuery.removePadding(
                removeTop: true, // 移除顶部的状态栏 距离
                context: context,
                child: ListView(
                  children: [
                    // 头部
                    headerWidget(),
                    const SizedBox(
                      height: 15,
                    ),
                    const CellItem(title: '服务', imageName: 'images/fuwu.jpg'),
                    const SizedBox(
                      height: 15,
                    ),
                    const CellItem(title: '设置', imageName: 'images/shezhi.jpg'),
                    // 列表项
                  ],
                ),
              ),
            ),
            // 相机
            Container(
              margin: const EdgeInsets.only(top: 50, right: 5),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image(
                    image: AssetImage(
                      'images/xiangji.jpeg',
                    ),
                    height: 40,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

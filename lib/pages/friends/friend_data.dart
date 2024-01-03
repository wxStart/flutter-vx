class Friend {
  Friend({required this.imageUrl, required this.name, this.indexLetter});
  final String imageUrl;
  final String name;
  final String? indexLetter;
}

List<String> indexWord = [
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];

List<Friend> headData = [
  Friend(
    imageUrl: "images/xinpengyou.png",
    name: "新的朋友",
  ),
  Friend(
    imageUrl: "images/qunliao.png",
    name: "群聊",
  ),
  Friend(
    imageUrl: "images/biaoqian.png",
    name: "标签",
  ),
  Friend(
    imageUrl: "images/gongzhonghao.png",
    name: "公众号",
  ),
];

final List<Friend> _datas = [
  // Friend(
  //   imageUrl: "https://randomuser.me/api/portraits/women/27.jpg",
  //   name: "李磊",
  //   indexLetter: "L",
  // ),
];

List<Friend> createData(int num) {
  for (int i = 0; i < num; i++) {
    int index = i % 26;
    _datas.add(Friend(
      imageUrl: "https://randomuser.me/api/portraits/women/$index.jpg",
      name: "$i _李磊",
      indexLetter: indexWord[index],
    ));
  }
  return _datas;
}

List<Friend> datas = createData(27);

class Character {
  late int charId;
  late String name;
  late String birthday;
  late List<dynamic> occupation;
  late String img;
  late String status;
  late String nickname;
  late List<dynamic> appearance;
  late String portrayed;
  late String category;

  Character(
      {required this.charId,
      required this.name,
      required this.birthday,
      required this.occupation,
      required this.img,
      required this.status,
      required this.nickname,
      required this.appearance,
      required this.portrayed,
      required this.category});


   Character.fromJson(Map<String, dynamic> json) {
    charId = json['char_id'];
    name = json['name'];
    birthday = json['birthday'];
    occupation = json['occupation'];
    img = json['img'];
    status = json['status'];
    nickname = json['nickname'];
    appearance = json['appearance'];
    portrayed = json['portrayed'];
    category = json['category'];
  }

}

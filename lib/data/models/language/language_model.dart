class Language {
  int id;
  String title;
  String code;
  String direction;
  String left;
  String right;
  String icon;
  String boxStatus;

  Language({
    required this.id,
    required this.title,
    required this.code,
    required this.direction,
    required this.left,
    required this.right,
    required this.icon,
    required this.boxStatus,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        id: json["id"],
        title: json["title"],
        code: json["code"],
        direction: json["direction"],
        left: json["left"],
        right: json["right"],
        icon: json["icon"],
        boxStatus: json["box_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "code": code,
        "direction": direction,
        "left": left,
        "right": right,
        "icon": icon,
        "box_status": boxStatus,
      };
}

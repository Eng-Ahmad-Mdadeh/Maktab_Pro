class Feature {
  int id;
  int status;
  String arName;
  String enName;
  String icon;

  Feature({
    required this.id,
    required this.status,
    required this.arName,
    required this.enName,
    required this.icon,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        status: int.parse(json["status"]),
        arName: json["ar_name"],
        enName: json["en_name"],
        icon: 'https://maktab.sa/${json["icon"]}',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "ar_name": arName,
        "en_name": enName,
        "icon": icon,
      };
}

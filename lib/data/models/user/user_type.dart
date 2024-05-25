class UserType {
  int id;
  String arName;
  String enName;

  UserType({
    required this.id,
    required this.arName,
    required this.enName,
  });

  factory UserType.fromJson(Map<String, dynamic> json) => UserType(
        id: json["id"],
        arName: json["ar_name"],
        enName: json["en_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ar_name": arName,
        "en_name": enName,
      };
}

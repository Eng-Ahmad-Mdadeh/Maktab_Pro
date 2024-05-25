class OfficeType {
  int id;
  int status;
  String arName;
  String enName;

  OfficeType({
    required this.id,
    required this.status,
    required this.arName,
    required this.enName,
  });

  factory OfficeType.fromJson(Map<String, dynamic> json) => OfficeType(
        id: json["id"],
        status: int.parse(json["status"]),
        arName: json["ar_name"],
        enName: json["en_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "ar_name": arName,
        "en_name": enName,
      };
}

class Commission {
  int id;
  String rate;
  String isLessor;

  Commission({
    required this.id,
    required this.rate,
    required this.isLessor,
  });

  factory Commission.fromJson(Map<String, dynamic> json) => Commission(
        id: json["id"],
        rate: json["rate"],
        isLessor: json["is_lessor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rate": rate,
        "is_lessor": isLessor,
      };
}

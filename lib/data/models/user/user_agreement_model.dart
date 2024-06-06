class UserAgreement {
  int? id;
  String? titleAr;
  String? titleEn;
  String? contentAr;
  String? contentEn;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserAgreement({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.contentAr,
    required this.contentEn,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserAgreement.fromJson(Map<String, dynamic> json) => UserAgreement(
        id: json["id"],
        titleAr: json["title_ar"],
        titleEn: json["title_en"],
        contentAr: json["content_ar"],
        contentEn: json["content_en"],
        createdAt: DateTime.tryParse(json["created_at"]??''),
        updatedAt: DateTime.tryParse(json["updated_at"]??''),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title_ar": titleAr,
        "title_en": titleEn,
        "content_ar": contentAr,
        "content_en": contentEn,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

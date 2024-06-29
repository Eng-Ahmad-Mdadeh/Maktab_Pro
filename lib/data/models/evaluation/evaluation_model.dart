import 'package:maktab_lessor/data/models/user/user_model.dart';

class Evaluation {
  int id;
  num rate;
  String comment;
  String adsId;
  dynamic userBId;
  String? userOrdId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic user;
  User? userOrdinary;

  Evaluation({
    required this.id,
    required this.rate,
    required this.comment,
    required this.adsId,
    required this.userBId,
    required this.userOrdId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.userOrdinary,
  });

  factory Evaluation.fromJson(Map<String, dynamic> json) => Evaluation(
        id: json["id"],
        rate: num.parse(json["rate"]),
        comment: json["comment"],
        adsId: json["ads_id"],
        userBId: json["user_b_id"],
        userOrdId: json["user_ord_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: json["user"],
        userOrdinary: json["user_ordinary"] != null
            ? User.fromJson(json["user_ordinary"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rate": rate,
        "comment": comment,
        "ads_id": adsId,
        "user_b_id": userBId,
        "user_ord_id": userOrdId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user,
        "user_ordinary": userOrdinary?.toJson(),
      };
}

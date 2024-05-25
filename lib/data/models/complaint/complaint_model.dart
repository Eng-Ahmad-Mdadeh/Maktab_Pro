import 'package:maktab/data/models/user/user_model.dart';

class Complaint {
  int id;
  String reason;
  String text;
  String reportStatus;
  String seen;
  DateTime createdAt;
  DateTime updatedAt;
  User? userBusiness;
  dynamic userOrdinary;

  Complaint({
    required this.id,
    required this.reason,
    required this.text,
    required this.reportStatus,
    required this.seen,
    required this.createdAt,
    required this.updatedAt,
    required this.userBusiness,
    required this.userOrdinary,
  });

  factory Complaint.fromJson(Map<String, dynamic> json) => Complaint(
        id: json["id"],
        reason: json["reason"],
        text: json["text"],
        reportStatus: json["report_status"],
        seen: json["seen"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userBusiness: json["user_business"] != null
            ? User.fromJson(json["user_business"])
            : null,
        userOrdinary: json["user_ordinary"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reason": reason,
        "text": text,
        "report_status": reportStatus,
        "seen": seen,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_business": userBusiness!.toJson(),
        "user_ordinary": userOrdinary,
      };
}

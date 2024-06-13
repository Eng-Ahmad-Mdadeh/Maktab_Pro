import 'package:equatable/equatable.dart';

class Report extends Equatable {
  const Report({
    required this.id,
    required this.reason,
    required this.text,
    required this.reportStatus,
    required this.seen,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? reason;
  final String? text;
  final String? reportStatus;
  final String? seen;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Report.empty({this.id, this.reason, this.text, this.reportStatus, this.seen, this.createdAt, this.updatedAt});

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json["id"],
      reason: json["reason"],
      text: json["text"],
      reportStatus: json["report_status"],
      seen: json["seen"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "reason": reason,
        "text": text,
        "report_status": reportStatus,
        "seen": seen,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };

  @override
  String toString() {
    return "$id, $reason, $text, $reportStatus, $seen, $createdAt, $updatedAt, ";
  }

  @override
  List<Object?> get props => [
        id,
        reason,
        text,
        reportStatus,
        seen,
        createdAt,
        updatedAt,
      ];

  Report copyWith({
    int? id,
    String? reason,
    String? text,
    String? reportStatus,
    String? seen,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Report(
      id: id ?? this.id,
      reason: reason ?? this.reason,
      text: text ?? this.text,
      reportStatus: reportStatus ?? this.reportStatus,
      seen: seen ?? this.seen,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

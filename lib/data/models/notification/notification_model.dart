import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  const NotificationModel({
    required this.id,
    required this.arTitle,
    required this.enTitle,
    required this.arBody,
    required this.enBody,
    required this.nameSender,
    required this.seen,
    required this.url,
    required this.receiverAdmin,
    required this.receiverUser,
    required this.receiverOrdinary,
    required this.createdAt,
  });

  final int? id;
  final String? arTitle;
  final String? enTitle;
  final String? arBody;
  final String? enBody;
  final String? nameSender;
  final String? seen;
  final String? url;
  final String? receiverAdmin;
  final String? receiverUser;
  final String? receiverOrdinary;
  final DateTime? createdAt;

  NotificationModel copyWith({
    int? id,
    String? arTitle,
    String? enTitle,
    String? arBody,
    String? enBody,
    String? nameSender,
    String? seen,
    String? url,
    String? receiverAdmin,
    String? receiverUser,
    String? receiverOrdinary,
    DateTime? createdAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      arTitle: arTitle ?? this.arTitle,
      enTitle: enTitle ?? this.enTitle,
      arBody: arBody ?? this.arBody,
      enBody: enBody ?? this.enBody,
      nameSender: nameSender ?? this.nameSender,
      seen: seen ?? this.seen,
      url: url ?? this.url,
      receiverAdmin: receiverAdmin ?? this.receiverAdmin,
      receiverUser: receiverUser ?? this.receiverUser,
      receiverOrdinary: receiverOrdinary ?? this.receiverOrdinary,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json){
    return NotificationModel(
      id: json["id"],
      arTitle: json["ar_title"],
      enTitle: json["en_title"],
      arBody: json["ar_body"],
      enBody: json["en_body"],
      nameSender: json["name_sender"],
      seen: json["seen"],
      url: json["url"],
      receiverAdmin: json["receiver_admin"],
      receiverUser: json["receiver_user"],
      receiverOrdinary: json["receiver_ordinary"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "ar_title": arTitle,
    "en_title": enTitle,
    "ar_body": arBody,
    "en_body": enBody,
    "name_sender": nameSender,
    "seen": seen,
    "url": url,
    "receiver_admin": receiverAdmin,
    "receiver_user": receiverUser,
    "receiver_ordinary": receiverOrdinary,
    "created_at": createdAt?.toIso8601String(),
  };

  @override
  String toString(){
    return "$id, $arTitle, $enTitle, $arBody, $enBody, $nameSender, $seen, $url, $receiverAdmin, $receiverUser, $receiverOrdinary, $createdAt, ";
  }

  @override
  List<Object?> get props => [
    id, arTitle, enTitle, arBody, enBody, nameSender, seen, url, receiverAdmin, receiverUser, receiverOrdinary, createdAt, ];
}

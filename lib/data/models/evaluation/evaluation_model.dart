import 'package:equatable/equatable.dart';
import 'package:maktab_lessor/data/models/user/user_model.dart';

import '../offer/offer_model.dart';

class Evaluation {
  int id;
  num rate;
  String comment;
  String adsId;
  String? userBId;
  String? userOrdId;
  DateTime createdAt;
  DateTime updatedAt;
  Unit? unit;
  User? user;
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
    required this.unit,
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
        userOrdinary: json["user_ordinary"] != null ? User.fromJson(json["user_ordinary"]) : null,
        unit: json["unit"] != null ? Unit.fromJson(json["unit"]) : null,
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
        "unit": unit?.toJson(),
      };
}

class Unit extends Equatable {
  const Unit({
    required this.id,
    required this.title,
    required this.isFavourite,
    required this.rate,
    required this.offer,
  });

  final int? id;
  final String? title;
  final bool? isFavourite;
  final String? rate;
  final dynamic offer;

  Unit copyWith({
    int? id,
    String? title,
    bool? isFavourite,
    String? rate,
    Offer? offer,
  }) {
    return Unit(
      id: id ?? this.id,
      title: title ?? this.title,
      isFavourite: isFavourite ?? this.isFavourite,
      rate: rate ?? this.rate,
      offer: offer ?? this.offer,
    );
  }

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      id: json["id"],
      title: json["title"],
      isFavourite: json["is_favourite"],
      rate: json["rate"],
      offer: json["offer"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "is_favourite": isFavourite,
        "rate": rate,
        "offer": offer,
      };

  @override
  List<Object?> get props => [
        id,
        title,
        isFavourite,
        rate,
        offer,
      ];
}

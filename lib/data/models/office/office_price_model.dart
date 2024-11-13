import 'package:equatable/equatable.dart';

import '../aqar_filter/type_res.dart';
import '../offer/offer_model.dart';

class OfficePrice extends Equatable {
  const OfficePrice({
    required this.id,
    required this.price,
    required this.status,
    required this.typeResId,
    required this.typeRes,
    required this.offers,
  });

  final int id;
  final num price;
  final String? status;
  final int typeResId;
  final TypeRes? typeRes;
  final List<Offer> offers;

  factory OfficePrice.fromJson(Map<String, dynamic> json) {
    return OfficePrice(
      id: json["id"],
      price: num.parse(json["price"]?.toString()??'0'),
      status: json["status"].toString(),
      typeResId: int.parse(json["type_res_id"]?.toString()??'-1'),
      typeRes: json["type_res"] == null ? null : TypeRes.fromJson(json["type_res"]),
      offers: json["offers"] == null ? [] : List<Offer>.from(json["offers"]!.map((x) => Offer.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "status": status,
        "type_res_id": typeResId,
        "type_res": typeRes?.toJson(),
        "offers": offers.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$id, $price, $status, $typeResId, $typeRes, $offers, ";
  }

  @override
  List<Object?> get props => [
        id,
        price,
        status,
        typeResId,
        typeRes,
        offers,
        offers,
      ];

  OfficePrice copyWith({List<Offer>? offers}) {
    return OfficePrice(
      id: id,
      price: price,
      status: status,
      typeResId: typeResId,
      typeRes: typeRes,
      offers: offers ?? this.offers,
    );
  }
}

import 'package:equatable/equatable.dart';

import '../../../core/network/api_endpoints.dart';

class InterfaceAqar extends Equatable {
  const InterfaceAqar({
    required this.id,
    required this.status,
    required this.arName,
    required this.enName,
    required this.pivot,
    required this.icon,
    required this.price,
  });

  final int id;
  final String? status;
  final String? arName;
  final String? enName;
  final InterfaceAqarPivot? pivot;
  final String? icon;
  final String? price;

  factory InterfaceAqar.fromJson(Map<String, dynamic> json) {
    return InterfaceAqar(
      id: json["id"],
      status: json["status"].toString(),
      arName: json["ar_name"],
      enName: json["en_name"],
      pivot: json["pivot"] == null ? null : InterfaceAqarPivot.fromJson(json["pivot"]),
      icon: ApiEndpoints.siteUrl + (json["icon"]??''),
      price: json["price"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "ar_name": arName,
        "en_name": enName,
        "pivot": pivot?.toJson(),
        "icon": icon,
        "price": price,
      };

  @override
  String toString() {
    return "$id, $status, $arName, $enName, $pivot, $icon, $price, ";
  }

  @override
  List<Object?> get props => [
        id,
        status,
        arName,
        enName,
        pivot,
        icon,
        price,
      ];

  InterfaceAqar copyWith({
    int? id,
    String? status,
    String? arName,
    String? enName,
    InterfaceAqarPivot? pivot,
    String? icon,
    String? price,
  }) {
    return InterfaceAqar(
      id: id ?? this.id,
      status: status ?? this.status,
      arName: arName ?? this.arName,
      enName: enName ?? this.enName,
      pivot: pivot ?? this.pivot,
      icon: icon ?? this.icon,
      price: price ?? this.price,
    );
  }
}

class InterfaceAqarPivot extends Equatable{
  const InterfaceAqarPivot({
    required this.adsId,
    required this.comfortId,
    required this.id,
  });

  final String? adsId;
  final String? comfortId;
  final String? id;

  factory InterfaceAqarPivot.fromJson(Map<String, dynamic> json) {
    return InterfaceAqarPivot(
      adsId: json["ads_id"].toString(),
      comfortId: json["comfort_id"].toString(),
      id: json["id"].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "ads_id": adsId,
        "comfort_id": comfortId,
        "id": id,
      };

  @override
  String toString() {
    return "$adsId, $comfortId, $id, ";
  }

  @override
  List<Object?> get props => [
    adsId,
    comfortId,
    id,
  ];
}

import 'package:equatable/equatable.dart';

import '../../../core/network/api_endpoints.dart';

class CategoryAqar extends Equatable{
  final int id;
  final int status;
  final String arName;
  final String enName;
  final String icon;

  const CategoryAqar({
    required this.id,
    required this.status,
    required this.arName,
    required this.enName,
    required this.icon,
  });

  factory CategoryAqar.fromJson(Map<String, dynamic> json) => CategoryAqar(
        id: json["id"],
        status: int.parse(json["status"].toString()),
        arName: json["ar_name"],
        enName: json["en_name"],
        icon: ApiEndpoints.siteUrl + json["icon"],
      );

  @override
  String toString() {
    return 'CategoryAquar{id: $id, status: $status, arName: $arName, enName: $enName, icon: $icon}';
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "ar_name": arName,
        "en_name": enName,
        "icon": icon,
      };

  @override
  List<Object?> get props => [
    id,
    status,
    arName,
    enName,
    icon,
  ];
}

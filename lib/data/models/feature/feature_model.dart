// class Feature {
//   int? id;
//   int? status;
//   String? arName;
//   String? enName;
//   String? icon;
//
//   Feature({
//     required this.id,
//     required this.status,
//     required this.arName,
//     required this.enName,
//     required this.icon,
//   });
//
//   factory Feature.fromJson(Map<String, dynamic> json) => Feature(
//         id: json["id"],
//         status: int.parse(json["status"].toString()),
//         arName: json["ar_name"],
//         enName: json["en_name"],
//         icon: 'https://maktab.sa/${json["icon"]}',
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "status": status,
//         "ar_name": arName,
//         "en_name": enName,
//         "icon": icon,
//       };
// }
import 'package:equatable/equatable.dart';
import 'package:maktab_lessor/core/network/api_endpoints.dart';

class Feature extends Equatable {
  const Feature({
    this.id,
    this.status,
    this.arName,
    this.enName,
    this.icon,
  });

  final int? id;
  final num? status;
  final String? arName;
  final String? enName;
  final String? icon;

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      id: json["id"],
      status: json["status"],
      arName: json["ar_name"],
      enName: json["en_name"],
      icon: "${ApiEndpoints.siteUrl}/${json["icon"]}",
    );
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

import 'package:maktab_lessor/core/network/api_endpoints.dart';

class Comfort {
  int id;
  int status;
  String icon;
  String arName;
  String enName;

  //ComfortPivot pivot;

  Comfort({
    required this.id,
    required this.status,
    required this.icon,
    required this.arName,
    required this.enName,
    //required this.pivot,
  });

  factory Comfort.fromJson(Map<String, dynamic> json) => Comfort(
        id: json["id"],
        status: int.parse(json["status"].toString()),
        icon: '${ApiEndpoints.siteUrl}/${json["image"]}',
        arName: json["ar_name"],
        enName: json["en_name"],
        //pivot: ComfortPivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "image": icon,
        "ar_name": arName,
        "en_name": enName,
        //"pivot": pivot.toJson(),
      };
}

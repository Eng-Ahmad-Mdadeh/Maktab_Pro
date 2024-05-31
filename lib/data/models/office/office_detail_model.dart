import 'package:equatable/equatable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../presentation/resources/app_assets.dart';

class OfficeDetail extends Equatable{
  final int id;
  final String arName;
  final String enName;
  final int status;
  final int numberDetails;
  final int officeId;
  final dynamic icon;

  const OfficeDetail({
    required this.id,
    required this.arName,
    required this.enName,
    required this.status,
    required this.numberDetails,
    required this.officeId,
    required this.icon,
  });

  factory OfficeDetail.fromJson(Map<String, dynamic> json) {
    // final Map<String, dynamic> map = {
    //   'floor': AppAssets.merduvan,
    //   'floors': AppAssets.merduvan,
    //   'age': FontAwesomeIcons.solidBuilding,
    //   'meetingroomscount': AppAssets.livingRoomChair,
    //   'Meeting Rooms': AppAssets.livingRoomChair,
    //   'officescount': AppAssets.viewWindow,
    //   'offices numbers': AppAssets.viewWindow,
    //   'office Age': FontAwesomeIcons.solidBuilding,
    // };

    return OfficeDetail(
      id: json["id"],
      arName: json["ar_name"],
      enName: json["en_name"],
      status: int.parse(json["status"].toString()),
      numberDetails: int.parse(json["number_details"].toString()),
      officeId: int.parse(json["ads_id"].toString()),
      // icon: map[json["en_name"]],
      icon: json["icon"],
    );
  }

  @override
  String toString() {
    return 'OfficeDetail{id: $id, arName: $arName, enName: $enName, status: $status, numberDetails: $numberDetails, officeId: $officeId}';
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "ar_name": arName,
        "en_name": enName,
        "status": status,
        "number_details": numberDetails,
        "ads_id": officeId,
      };

  @override
  List<Object?> get props => [
    id,
    arName,
    enName,
    status,
    numberDetails,
    officeId,
    icon,
  ];
}

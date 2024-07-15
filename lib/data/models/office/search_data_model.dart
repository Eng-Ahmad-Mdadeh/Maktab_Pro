import 'package:maktab_lessor/data/models/category_aqar/category_aqar_model.dart';
import 'package:maktab_lessor/data/models/comfort/comfort_model.dart';
import 'package:maktab_lessor/data/models/facility/facility_model.dart';
import 'package:maktab_lessor/data/models/feature/feature_model.dart';
import 'package:maktab_lessor/data/models/interface_aqar/interface_aqar_model.dart';
import 'package:maktab_lessor/data/models/office/office_service_model.dart';
import 'package:maktab_lessor/data/models/type_aquar/type_aquar_model.dart';

class SearchData {
  List<CategoryAqar> officeCategories;
  List<TypeAquar> officeTypes;
  List<InterfaceAqar> officeInterfaces;
  List<Feature> features;
  List<Comfort> comforts;
  List<Facility> facilities;
  List<OfficeService> services;

  SearchData({
    required this.officeCategories,
    required this.officeTypes,
    required this.officeInterfaces,
    required this.features,
    required this.comforts,
    required this.facilities,
    required this.services,
  });

  factory SearchData.fromJson(Map<String, dynamic> json) => SearchData(
        officeCategories: List<CategoryAqar>.from(json["category_aqar"].map((x) => CategoryAqar.fromJson(x))),
        officeTypes: List<TypeAquar>.from(json["type_aqars"].map((x) => TypeAquar.fromJson(x))),
        officeInterfaces: List<InterfaceAqar>.from(json["interface_aqars"].map((x) => InterfaceAqar.fromJson(x))),
        features: List<Feature>.from(json["featurea_ads"].map((x) => Feature.fromJson(x))),
        comforts: List<Comfort>.from(json["comfort"].map((x) => Comfort.fromJson(x))),
        facilities: List<Facility>.from(json["facilities"].map((x) => Facility.fromJson(x))),
        services: json["services"] != null ? List<OfficeService>.from(json["services"].map((x) => OfficeService.fromJson(x))) : [],
      );

  Map<String, dynamic> toJson() => {
        "category_aqar": List<dynamic>.from(officeCategories.map((x) => x.toJson())),
        "type_aqars": List<dynamic>.from(officeTypes.map((x) => x.toJson())),
        "interface_aqars": List<dynamic>.from(officeInterfaces.map((x) => x.toJson())),
        "featurea_ads": List<dynamic>.from(features.map((x) => x.toJson())),
        "comfort": List<dynamic>.from(comforts.map((x) => x.toJson())),
        "facilities": List<dynamic>.from(facilities.map((x) => x.toJson())),
      };
}

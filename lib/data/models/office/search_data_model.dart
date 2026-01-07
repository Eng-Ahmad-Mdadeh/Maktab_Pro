// import 'package:maktab_lessor/data/models/category_aqar/category_aqar_model.dart';
// import 'package:maktab_lessor/data/models/comfort/comfort_model.dart';
// import 'package:maktab_lessor/data/models/facility/facility_model.dart';
// import 'package:maktab_lessor/data/models/feature/feature_model.dart';
// import 'package:maktab_lessor/data/models/interface_aqar/interface_aqar_model.dart';
// import 'package:maktab_lessor/data/models/office/office_service_model.dart';
// import 'package:maktab_lessor/data/models/type_aquar/type_aquar_model.dart';
//
// class SearchData {
//   List<CategoryAqar> officeCategories;
//   List<TypeAquar> officeTypes;
//   List<InterfaceAqar> officeInterfaces;
//   List<Feature> features;
//   List<Comfort> comforts;
//   List<Facility> facilities;
//   List<OfficeService> services;
//
//   SearchData({
//     required this.officeCategories,
//     required this.officeTypes,
//     required this.officeInterfaces,
//     required this.features,
//     required this.comforts,
//     required this.facilities,
//     required this.services,
//   });
//
//   factory SearchData.fromJson(Map<String, dynamic> json) => SearchData(
//         officeCategories: List<CategoryAqar>.from(json["category_aqar"].map((x) => CategoryAqar.fromJson(x))),
//         officeTypes: List<TypeAquar>.from(json["type_aqars"].map((x) => TypeAquar.fromJson(x))),
//         officeInterfaces: List<InterfaceAqar>.from(json["interface_aqars"].map((x) => InterfaceAqar.fromJson(x))),
//         features: List<Feature>.from(json["featurea_ads"].map((x) => Feature.fromJson(x))),
//         comforts: List<Comfort>.from(json["comfort"].map((x) => Comfort.fromJson(x))),
//         facilities: List<Facility>.from(json["facilities"].map((x) => Facility.fromJson(x))),
//         services: json["services"] != null ? List<OfficeService>.from(json["services"].map((x) => OfficeService.fromJson(x))) : [],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "category_aqar": List<dynamic>.from(officeCategories.map((x) => x.toJson())),
//         "type_aqars": List<dynamic>.from(officeTypes.map((x) => x.toJson())),
//         "interface_aqars": List<dynamic>.from(officeInterfaces.map((x) => x.toJson())),
//         "featurea_ads": List<dynamic>.from(features.map((x) => x.toJson())),
//         "comfort": List<dynamic>.from(comforts.map((x) => x.toJson())),
//         "facilities": List<dynamic>.from(facilities.map((x) => x.toJson())),
//       };
// }

import 'package:equatable/equatable.dart';
import 'package:maktab_lessor/data/models/category_aqar/category_aqar_model.dart';
import 'package:maktab_lessor/data/models/comfort/comfort_model.dart';
import 'package:maktab_lessor/data/models/facility/facility_model.dart';
import 'package:maktab_lessor/data/models/feature/feature_model.dart';
import 'package:maktab_lessor/data/models/interface_aqar/interface_aqar_model.dart';
import 'package:maktab_lessor/data/models/office/office_service_model.dart';
import 'package:maktab_lessor/data/models/type_aquar/type_aquar_model.dart';
import 'package:maktab_lessor/data/models/verify_license_number/verify_license_number_model.dart';

class SearchData extends Equatable {
  const SearchData({
    required this.officeCategories,
    required this.officeTypes,
    required this.officeInterfaces,
    required this.typeRes,
    required this.features,
    required this.roomDetails,
    required this.comforts,
    required this.facilities,
    // required this.maxPrice,
    // required this.minPrice,
    required this.cities,
    required this.propertyUtilities,
    required this.propertyAges,
    required this.services,
  });

  final List<CategoryAqar> officeCategories;
  final List<TypeAquar> officeTypes;
  final List<InterfaceAqar> officeInterfaces;
  final List<RoomDetail> typeRes;
  final List<Feature> features;
  final List<RoomDetail> roomDetails;
  final List<Comfort> comforts;
  final List<Facility> facilities;
  // final num? maxPrice;
  // final num ?minPrice;
  final List<City> cities;
  final List<Feature> propertyUtilities;
  final List<PropertyAge> propertyAges;
  final List<OfficeService> services;

  factory SearchData.fromJson(Map<String, dynamic> json) {
    return SearchData(
      officeCategories: json["category_aqar"] == null
          ? []
          : List<CategoryAqar>.from(json["category_aqar"]!.map((x) => CategoryAqar.fromJson(x))),
      officeTypes:
          json["type_aqars"] == null ? [] : List<TypeAquar>.from(json["type_aqars"]!.map((x) => TypeAquar.fromJson(x))),
      officeInterfaces: json["interface_aqars"] == null
          ? []
          : List<InterfaceAqar>.from(json["interface_aqars"]!.map((x) => InterfaceAqar.fromJson(x))),
      typeRes:
          json["type_res"] == null ? [] : List<RoomDetail>.from(json["type_res"]!.map((x) => RoomDetail.fromJson(x))),
      features:
          json["featurea_ads"] == null ? [] : List<Feature>.from(json["featurea_ads"]!.map((x) => Feature.fromJson(x))),
      roomDetails: json["room_details"] == null
          ? []
          : List<RoomDetail>.from(json["room_details"]!.map((x) => RoomDetail.fromJson(x))),
      comforts: json["comfort"] == null ? [] : List<Comfort>.from(json["comfort"]!.map((x) => Comfort.fromJson(x))),
      facilities:
          json["facilities"] == null ? [] : List<Facility>.from(json["facilities"]!.map((x) => Facility.fromJson(x))),
      // maxPrice: json["max_price"],
      // minPrice: json["min_price"],
      cities: json["cities"] == null ? [] : List<City>.from(json["cities"]!.map((x) => City.fromJson(x))),
      propertyUtilities: json["property_utilities"] == null
          ? []
          : List<Feature>.from(json["property_utilities"]!.map((x) => Feature.fromJson(x))),
      propertyAges: json["property_ages"] == null
          ? []
          : List<PropertyAge>.from(json["property_ages"]!.map((x) => PropertyAge.fromJson(x))),
      services: json["services"] != null
          ? List<OfficeService>.from(json["services"].map((x) => OfficeService.fromJson(x)))
          : [],
    );
  }

  @override
  List<Object?> get props => [
        officeCategories,
        officeTypes,
        officeInterfaces,
        typeRes,
        features,
        roomDetails,
        comforts,
        facilities,
        // maxPrice,
        // minPrice,
        cities,
        propertyUtilities,
        propertyAges,
        services,
      ];
}

class City extends Equatable {
  const City({
    required this.id,
    required this.city,
  });

  final int? id;
  final String? city;

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json["id"],
      city: json["city"],
    );
  }

  @override
  List<Object?> get props => [
        id,
        city,
      ];
}



class RoomDetail extends Equatable {
  const RoomDetail({
    required this.id,
    required this.arName,
    required this.enName,
    required this.adsRooms,
  });

  final int? id;
  final String? arName;
  final String? enName;
  final List<dynamic> adsRooms;

  factory RoomDetail.fromJson(Map<String, dynamic> json) {
    return RoomDetail(
      id: json["id"],
      arName: json["ar_name"],
      enName: json["en_name"],
      adsRooms: json["ads_rooms"] == null ? [] : List<dynamic>.from(json["ads_rooms"]!.map((x) => x)),
    );
  }

  @override
  List<Object?> get props => [
        id,
        arName,
        enName,
        adsRooms,
      ];
}

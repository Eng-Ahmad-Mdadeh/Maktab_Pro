import '../category_aqar/category_aqar_model.dart';
import '../comfort/comfort_model.dart';
import '../facility/facility_model.dart';
import '../feature/feature_model.dart';
import '../interface_aqar/interface_aqar_model.dart';
import '../type_aquar/type_aquar_model.dart';
import 'room_details.dart';
import 'type_res.dart';

class AqarFilterModel {
  List<CategoryAqar>? categoryAqar;
  List<TypeAquar>? typeAqars;
  List<InterfaceAqar>? interfaceAqars;
  List<TypeRes>? typeRes;
  List<Feature>? featureaAds;
  List<RoomDetails>? roomDetails;
  List<Comfort>? comfort;
  List<Facility>? facilities;
  double? maxPrice;
  double? minPrice;
  // List<CityModel>? cities;

  AqarFilterModel({this.categoryAqar, this.typeAqars, this.interfaceAqars, this.typeRes, this.featureaAds, this.roomDetails, this.comfort, this.facilities, this.maxPrice, this.minPrice});

  AqarFilterModel.empty();

  AqarFilterModel.fromJson(Map<String, dynamic> json) {
    if(json["category_aqar"] is List) {
      categoryAqar = json["category_aqar"] == null ? null : (json["category_aqar"] as List).map((e) => CategoryAqar.fromJson(e)).toList();
    }
    if(json["type_aqars"] is List) {
      typeAqars = json["type_aqars"] == null ? null : (json["type_aqars"] as List).map((e) => TypeAquar.fromJson(e)).toList();
    }
    if(json["interface_aqars"] is List) {
      interfaceAqars = json["interface_aqars"] == null ? null : (json["interface_aqars"] as List).map((e) => InterfaceAqar.fromJson(e)).toList();
    }
    if(json["type_res"] is List) {
      typeRes = json["type_res"] == null ? null : (json["type_res"] as List).map((e) => TypeRes.fromJson(e)).toList();
    }
    if(json["featurea_ads"] is List) {
      featureaAds = json["featurea_ads"] == null ? null : (json["featurea_ads"] as List).map((e) => Feature.fromJson(e)).toList();
    }
    if(json["room_details"] is List) {
      roomDetails = json["room_details"] == null ? null : (json["room_details"] as List).map((e) => RoomDetails.fromJson(e)).toList();
    }
    if(json["comfort"] is List) {
      comfort = json["comfort"] == null ? null : (json["comfort"] as List).map((e) => Comfort.fromJson(e)).toList();
    }
    if(json["facilities"] is List) {
      facilities = json["facilities"] == null ? null : (json["facilities"] as List).map((e) => Facility.fromJson(e)).toList();
    }
    if(json["max_price"] is String) {
      maxPrice = double.parse(json["max_price"]);
    }
    if(json["min_price"] is String) {
      minPrice = double.parse(json["min_price"]);
    }
    if(json["cities"] is List) {
      // todo: cities from database
      // cities = json["cities"] == null ? null : (json["cities"] as List).map((e) => CityModel.fromJson(e)).toList();
      // cities = CityModel.citiesList;
    }
  }

  @override
  String toString() {
    return 'AqarFilterModel{categoryAqar: $categoryAqar, typeAqars: $typeAqars, interfaceAqars: $interfaceAqars, typeRes: $typeRes, featureaAds: $featureaAds, roomDetails: $roomDetails, comfort: $comfort, facilities: $facilities, maxPrice: $maxPrice, minPrice: $minPrice}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(categoryAqar != null) {
      data["category_aqar"] = categoryAqar?.map((e) => e.toJson()).toList();
    }
    if(typeAqars != null) {
      data["type_aqars"] = typeAqars?.map((e) => e.toJson()).toList();
    }
    if(interfaceAqars != null) {
      data["interface_aqars"] = interfaceAqars?.map((e) => e.toJson()).toList();
    }
    if(typeRes != null) {
      data["type_res"] = typeRes?.map((e) => e.toJson()).toList();
    }
    if(featureaAds != null) {
      data["featurea_ads"] = featureaAds?.map((e) => e.toJson()).toList();
    }
    if(roomDetails != null) {
      data["room_details"] = roomDetails?.map((e) => e.toJson()).toList();
    }
    if(comfort != null) {
      data["comfort"] = comfort?.map((e) => e.toJson()).toList();
    }
    if(facilities != null) {
      data["facilities"] = facilities?.map((e) => e.toJson()).toList();
    }
    data["max_price"] = maxPrice;
    data["min_price"] = minPrice;
    // if(cities != null) {
    //   data["cities"] = cities?.map((e) => e.toJson()).toList();
    // }
    return data;
  }
}


















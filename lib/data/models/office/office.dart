// import 'package:maktab_lessor_ordinary/data/models/offer/offer_model.dart';
// import 'package:maktab_lessor_ordinary/data/models/office/featurea_office_model.dart';
// import 'package:maktab_lessor_ordinary/data/models/office/office_detail_model.dart';
// import 'package:maktab_lessor_ordinary/data/models/office/office_file.dart';
// import 'package:maktab_lessor_ordinary/data/models/office/office_location_model.dart';
// import 'package:maktab_lessor_ordinary/data/models/office/office_price_model.dart';
// import 'package:maktab_lessor_ordinary/data/models/office/office_service_model.dart';
// import 'package:maktab_lessor_ordinary/data/models/comfort/comfort_model.dart';
// import 'package:maktab_lessor_ordinary/data/models/evaluation/evaluation_model.dart';
// import 'package:maktab_lessor_ordinary/data/models/facility/facility_model.dart';
// import 'package:maktab_lessor_ordinary/data/models/feature/feature_model.dart';
// import 'package:maktab_lessor_ordinary/data/models/office/office_unit_model.dart';
// import 'package:maktab_lessor_ordinary/data/models/type_aquar/type_aquar_model.dart';
//
// import '../category_aqar/category_aqar_model.dart';
// import '../interface_aqar/interface_aqar_model.dart';
//
// class Office {
//   int? id;
//   bool? status;
//   bool? isReservation;
//   String? title;
//   String? refNumber;
//   String? licenseNumber;
//   String? viewerName;
//   String? viewerPhone;
//   String? mainImage;
//   String? furnisher;
//   int? views;
//   bool? isSpecial;
//   num? space;
//   num? width;
//   num? height;
//   String? description;
//   String? advertiserRelationship;
//   String? advertiserRelationshipType;
//   DateTime lastUpdate;
//   num? downPayment;
//   String? typeDownPayment;
//   int? categoryId;
//   int? typeAqarId;
//   int? interfaceId;
//   int? unitId;
//   DateTime createdAt;
//   DateTime updatedAt;
//   bool? isFavourite;
//   num? rate;
//   Offer? offer;
//   OfficeLocation? location;
//   List<OfficeFile> files;
//   TypeAquar? typeAqar;
//   InterfaceAqar? interfaceAqar;
//   CategoryAqar? categoryAqar;
//   List<FeatureaOffice> featureaOffice;
//   List<Feature> features;
//   List<Comfort> comforts;
//   List<OfficeService> services;
//   List<OfficePrice> prices;
//   List<OfficeDetail> details;
//   List<Facility> facilities;
//   List<Evaluation> evaluations;
//   List<OfficeUnit> units;
//
//   Office({
//     required this.id,
//     required this.status,
//     required this.isReservation,
//     required this.title,
//     required this.refNumber,
//     required this.licenseNumber,
//     required this.viewerName,
//     required this.viewerPhone,
//     required this.mainImage,
//     required this.furnisher,
//     required this.views,
//     required this.isSpecial,
//     required this.space,
//     required this.width,
//     required this.height,
//     required this.description,
//     required this.advertiserRelationship,
//     required this.advertiserRelationshipType,
//     required this.lastUpdate,
//     required this.downPayment,
//     required this.typeDownPayment,
//     required this.categoryId,
//     required this.typeAqarId,
//     required this.interfaceId,
//     required this.unitId,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.isFavourite,
//     required this.rate,
//     required this.offer,
//     required this.location,
//     required this.files,
//     required this.typeAqar,
//     required this.interfaceAqar,
//     required this.categoryAqar,
//     required this.featureaOffice,
//     required this.features,
//     required this.comforts,
//     required this.services,
//     required this.prices,
//     required this.details,
//     required this.facilities,
//     required this.evaluations,
//     required this.units,
//   });
//
//   factory Office.fromJson(Map<String, dynamic> json) {
//     return Office(
//       id: json["id"],
//       status: json["status"].toString() == "0" ? false : true,
//       isReservation: json["is_reservation"] == '0' ? false : true,
//       title: json["title"],
//       refNumber: json["ref_number"] != null ? json["ref_number"].toString() : '',
//       licenseNumber: json["license_number"] ?? '',
//       viewerName: json["viewer_name"] ?? '',
//       viewerPhone: json["viewer_phone"] ?? '',
//       mainImage: json["main_image"] ?? '',
//       furnisher: json["furnisher"] ?? '',
//       views: json["views"] != null ? int.parse(json["views"].toString()) : 0,
//       isSpecial: json["is_special"] == '0' ? false : true,
//       space: json["space"] != null ? num.parse(json["space"]) : 0.0,
//       width: json["width"] != null ? num.parse(json["width"]) : 0.0,
//       height: json["height"] != null ? num.parse(json["height"]) : 0.0,
//       description: json["description"] ?? '',
//       advertiserRelationship: json["advertiser_relationship"] ?? '',
//       advertiserRelationshipType: json["advertiser_relationship_type"] ?? '',
//       lastUpdate: DateTime.parse(json["lastUpdate"]),
//       downPayment: json["down_payment"] != null ? num.parse(json["down_payment"]) : 0.0,
//       typeDownPayment: json["type_down_payment"] ?? '',
//       categoryId: json["category_id"] != null ? int.parse(json["category_id"]) : null,
//       typeAqarId: json["type_aqar_id"] != null ? int.parse(json["type_aqar_id"]) : null,
//       interfaceId: json["interface_id"] != null ? int.parse(json["interface_id"]) : null,
//       unitId: json["unit_id"] != null ? int.parse(json["unit_id"]) : null,
//       createdAt: DateTime.parse(json["created_at"]),
//       updatedAt: DateTime.parse(json["updated_at"]),
//       isFavourite: json["is_favourite"],
//       rate: json["rate"] != null ? num.parse(json["rate"].toString()) : 0.0,
//       offer: json["offer"] != null ? Offer.fromJson(json["offer"]) : null,
//       location: json["location"] != null ? OfficeLocation.fromJson(json["location"]) : null,
//       files: json["ads_files"] != null
//           ? List<OfficeFile>.from(json["ads_files"].map((file) => OfficeFile.fromJson(file)))
//           : [],
//       typeAqar: json["type_aqar"] != null ? TypeAquar.fromJson(json["type_aqar"]) : null,
//       interfaceAqar: json["interface_aqar"] != null ? InterfaceAqar.fromJson(json["interface_aqar"]) : null,
//       categoryAqar: json["category_aqar"] != null ? CategoryAqar.fromJson(json["category_aqar"]) : null,
//       featureaOffice: json["featurea_ads"] != null
//           ? List<FeatureaOffice>.from(json["featurea_ads"].map((x) => FeatureaOffice.fromJson(x)))
//           : [],
//       features: json["features"] != null ? List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))) : [],
//       comforts: json["comforts"] != null ? List<Comfort>.from(json["comforts"].map((x) => Comfort.fromJson(x))) : [],
//       services: json["services"] != null
//           ? List<OfficeService>.from(json["services"].map((x) => OfficeService.fromJson(x)))
//           : [],
//       prices: json["ads_prices"] != null
//           ? List<OfficePrice>.from(json["ads_prices"].map((x) => OfficePrice.fromJson(x)))
//           : [],
//       details: json["ads_details"] != null
//           ? List<OfficeDetail>.from(json["ads_details"].map((x) => OfficeDetail.fromJson(x)))
//           : [],
//       facilities:
//           json["facilities"] != null ? List<Facility>.from(json["facilities"].map((x) => Facility.fromJson(x))) : [],
//       evaluations: json["evaluations"] != null
//           ? List<Evaluation>.from(json["evaluations"].map((x) => Evaluation.fromJson(x)))
//           : [],
//       units: json["units"] != null ? List<OfficeUnit>.from(json["units"].map((x) => OfficeUnit.fromJson(x))) : [],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "status": status,
//         "is_reservation": isReservation,
//         "title": title,
//         "ref_number": refNumber,
//         "license_number": licenseNumber,
//         "viewer_name": viewerName,
//         "viewer_phone": viewerPhone,
//         "main_image": mainImage,
//         "furnisher": furnisher,
//         "views": views,
//         "is_special": isSpecial,
//         "space": space,
//         "width": width,
//         "height": height,
//         "description": description,
//         "advertiser_relationship": advertiserRelationship,
//         "advertiser_relationship_type": advertiserRelationshipType,
//         "lastUpdate":
//             "${lastUpdate.year.toString().padLeft(4, '0')}-${lastUpdate.month.toString().padLeft(2, '0')}-${lastUpdate.day.toString().padLeft(2, '0')}",
//         "down_payment": downPayment,
//         "type_down_payment": typeDownPayment,
//         "category_id": categoryId,
//         "type_aqar_id": typeAqarId,
//         "interface_id": interfaceId,
//         "unit_id": unitId,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "is_favourite": isFavourite,
//         "rate": rate,
//         "offer": offer?.toJson(),
//         "location": location?.toJson(),
//         "ads_files": List<dynamic>.from(files.map((file) => file.toJson())),
//         "type_aqar": typeAqar?.toJson(),
//         "interface_aqar": interfaceAqar?.toJson(),
//         "category_aqar": categoryAqar?.toJson(),
//         "featurea_ads": List<dynamic>.from(featureaOffice.map((featurea) => featurea.toJson())),
//         "features": List<dynamic>.from(features.map((feature) => feature.toJson())),
//         "comforts": List<dynamic>.from(comforts.map((comfort) => comfort.toJson())),
//         "services": List<dynamic>.from(services.map((service) => service.toJson())),
//         "ads_prices": List<dynamic>.from(prices.map((price) => price.toJson())),
//         "ads_details": List<dynamic>.from(details.map((detail) => detail.toJson())),
//         "facilities": List<dynamic>.from(facilities.map((facility) => facility.toJson())),
//         "evaluations": List<dynamic>.from(evaluations.map((evaluation) => evaluation.toJson())),
//         "units": List<dynamic>.from(units.map((unit) => unit.toJson())),
//       };
//
//   @override
//   String toString() {
//     return 'Office{id: $id, status: $status, isReservation: $isReservation, title: $title, refNumber: $refNumber, licenseNumber: $licenseNumber, viewerName: $viewerName, viewerPhone: $viewerPhone, mainImage: $mainImage, furnisher: $furnisher, views: $views, isSpecial: $isSpecial, space: $space, width: $width, height: $height, description: $description, advertiserRelationship: $advertiserRelationship, advertiserRelationshipType: $advertiserRelationshipType, lastUpdate: $lastUpdate, downPayment: $downPayment, typeDownPayment: $typeDownPayment, categoryId: $categoryId, typeAqarId: $typeAqarId, interfaceId: $interfaceId, unitId: $unitId, createdAt: $createdAt, updatedAt: $updatedAt, isFavourite: $isFavourite, rate: $rate, offer: $offer, location: $location, files: $files, typeAqar: $typeAqar, interfaceAqar: $interfaceAqar, categoryAqar: $categoryAqar, featureaOffice: $featureaOffice, features: $features, comforts: $comforts, services: $services, prices: $prices, details: $details, facilities: $facilities, evaluations: $evaluations, units: $units}';
//   }
// }
//
// final officeData = [
//   {
//     "id": 33,
//     "status": "1",
//     "active": "1",
//     "is_marketing": "0",
//     "is_reservation": "1",
//     "title": "وحدة في الحي الشرقي",
//     "ref_number": "558833",
//     "license_number": null,
//     "viewer_name": "علي",
//     "viewer_phone": "+966512568887",
//     "main_image": "assets/images/offices/images/1713794866865519732.jpg",
//     "furnisher": "مؤثث",
//     "views": "101",
//     "is_special": "0",
//     "space": "906.00",
//     "width": null,
//     "height": null,
//     "description":
//         "تقع في شمال الرياض مطلة على بوليفارد الرياض قريبة من شارع تركي الأول. صُممت بألوان مريحة مؤثثة بأثاث مودرن. يوجد شاشة 85 بوصة واشتراك بين سبورت لمتابعة المباريات. تتميز بمساحتها الواسعة وخصوصية تامة بدخول ذكي. أتمنى لك إقامة سعيدة و حياك الله ضيفنا",
//     "advertiser_relationship": "وكيل",
//     "advertiser_relationship_type": null,
//     "lastUpdate": "2024-04-22",
//     "down_payment": "5.00",
//     "type_down_payment": "rial",
//     "category_id": "8",
//     "type_aqar_id": "2",
//     "interface_id": "5",
//     "unit_id": "28",
//     "created_at": "2024-04-22T13:57:52.000000Z",
//     "updated_at": "2024-04-24T08:08:43.000000Z",
//     "is_completed": "1",
//     "is_central": "0",
//     "is_favourite": false,
//     "rate": 0,
//     "offer": null,
//     "location": {
//       "id": 26,
//       "lat": "21.54624859484284",
//       "lng": "39.18452024459839",
//       "zoom": "12.554545402526855",
//       "address": "جدة, الورود, محمد شنكار",
//       "city": "جدة",
//       "neighborhood": "الورود",
//       "street": "محمد شنكار"
//     },
//     "ads_files": [
//       {"id": 46, "path": "assets/images/offices/images/1713794866836574842.jpg", "type_file": "image"},
//       {"id": 47, "path": "assets/images/offices/images/1713794866712791065.jpg", "type_file": "image"},
//       {"id": 50, "path": "assets/images/offices/images/1713868114803583647.webp", "type_file": "image"},
//       {"id": 51, "path": "assets/images/offices/images/17138681141003142850.webp", "type_file": "image"}
//     ],
//     "type_aqar": {"id": 2, "status": "1", "ar_name": "تجاري", "en_name": "commercial"},
//     "interface_aqar": {"id": 5, "status": "1", "ar_name": "جنوب", "en_name": "South"},
//     "category_aqar": {
//       "id": 8,
//       "status": "1",
//       "ar_name": "منطقة فعاليات",
//       "en_name": "Events Area",
//       "icon": "assets/images/category_aqar/Events_Area.png",
//       "num_sort": "5"
//     },
//     "featurea_ads": [
//       {"id": 21, "boolfeaturea_id": "1"},
//       {"id": 23, "boolfeaturea_id": "3"}
//     ],
//     "features": [
//       {
//         "id": 1,
//         "status": "1",
//         "ar_name": "سكرتارية",
//         "en_name": "Secretariat",
//         "icon": "assets/images/features/Secretariat.svg"
//       },
//       {"id": 3, "status": "1", "ar_name": "طابعة", "en_name": "Printer", "icon": "assets/images/features/printer.svg"}
//     ],
//     "comforts": [
//       {
//         "id": 2,
//         "status": "1",
//         "ar_name": "وجبة افطار",
//         "en_name": "Breakfast",
//         "pivot": {"ads_id": "33", "comfort_id": "2", "id": "22"}
//       },
//       {
//         "id": 1,
//         "status": "1",
//         "ar_name": "نادي رياضي",
//         "en_name": "Sports club",
//         "pivot": {"ads_id": "33", "comfort_id": "1", "id": "24"}
//       }
//     ],
//     "services": [],
//     "ads_prices": [
//       {
//         "id": 25,
//         "price": "5000.00",
//         "status": "1",
//         "type_res_id": "4",
//         "type_res": {"id": 4, "ar_name": "سنوي", "en_name": "yearly"}
//       },
//       {
//         "id": 27,
//         "price": "10.00",
//         "status": "1",
//         "type_res_id": "1",
//         "type_res": {"id": 1, "ar_name": "ساعة", "en_name": "hourly"}
//       },
//       {
//         "id": 28,
//         "price": "600.00",
//         "status": "1",
//         "type_res_id": "3",
//         "type_res": {"id": 3, "ar_name": "شهري", "en_name": "monthly"}
//       }
//     ],
//     "ads_details": [
//       {"id": 62, "ar_name": "الدور", "en_name": "floor", "status": "1", "number_details": "3", "ads_id": "33"},
//       {"id": 63, "ar_name": "عمر المكتب", "en_name": "age", "status": "1", "number_details": "4", "ads_id": "33"},
//       {
//         "id": 69,
//         "ar_name": "عدد المكاتب",
//         "en_name": "officescount",
//         "status": "1",
//         "number_details": "3",
//         "ads_id": "33"
//       }
//     ],
//     "facilities": [
//       {
//         "id": 1,
//         "status": "1",
//         "icon": "assets/images/facilities/bed.svg",
//         "ar_name": "غرف نوم",
//         "en_name": "Bed rooms",
//         "pivot": {"ads_id": "33", "facility_id": "1", "id": "37"}
//       },
//       {
//         "id": 4,
//         "status": "1",
//         "icon": "assets/images/facilities/mosque.svg",
//         "ar_name": "مصلى",
//         "en_name": "Mosque",
//         "pivot": {"ads_id": "33", "facility_id": "4", "id": "39"}
//       },
//       {
//         "id": 6,
//         "status": "1",
//         "icon": "assets/images/facilities/grass.svg",
//         "ar_name": "مسطحات خضراء",
//         "en_name": "Green planers",
//         "pivot": {"ads_id": "33", "facility_id": "6", "id": "42"}
//       },
//       {
//         "id": 2,
//         "status": "1",
//         "icon": "assets/images/facilities/pool.svg",
//         "ar_name": "مسبح",
//         "en_name": "Pool",
//         "pivot": {"ads_id": "33", "facility_id": "2", "id": "43"}
//       }
//     ],
//     "evaluations": []
//   }
// ];

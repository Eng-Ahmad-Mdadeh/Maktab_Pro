import 'package:maktab/data/models/calendar/calender_model.dart';
import 'package:maktab/data/models/complaint/complaint_model.dart';
import 'package:maktab/data/models/coupon/coupon_model.dart';
import 'package:maktab/data/models/offer/offer_model.dart';
import 'package:maktab/data/models/office/featurea_office_model.dart';
import 'package:maktab/data/models/office/office_category_model.dart';
import 'package:maktab/data/models/office/office_detail_model.dart';
import 'package:maktab/data/models/office/office_file.dart';
import 'package:maktab/data/models/office/office_interface_model.dart';
import 'package:maktab/data/models/office/office_location_model.dart';
import 'package:maktab/data/models/office/office_marketing.dart';
import 'package:maktab/data/models/office/office_price_model.dart';
import 'package:maktab/data/models/office/office_service_model.dart';
import 'package:maktab/data/models/comfort/comfort_model.dart';
import 'package:maktab/data/models/evaluation/evaluation_model.dart';
import 'package:maktab/data/models/facility/facility_model.dart';
import 'package:maktab/data/models/feature/feature_model.dart';
import 'package:maktab/data/models/office/office_type_model.dart';

class Office {
  int id;
  bool status;
  bool active;
  bool isMarketing;
  bool isReservation;
  bool isCentral;
  bool isCompleted;
  String title;
  String refNumber;
  String licenseNumber;
  String viewerName;
  String viewerPhone;
  String mainImage;
  String furnisher;
  int views;
  bool isSpecial;
  num? space;
  num? width;
  num? height;
  String description;
  String advertiserRelationship;
  String advertiserRelationshipType;
  DateTime? lastUpdate;
  num? downPayment;
  String? typeDownPayment;
  int? categoryId;
  int? typeAqarId;
  int? interfaceId;
  int? unitId;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool isFavourite;
  num rate;
  OfficeLocation? location;
  List<OfficeFile> files;
  OfficeType? typeAqar;
  OfficeInterface? officeInterface;
  OfficeCategory? categoryAqar;
  List<FeatureaOffice> featureaOffice;
  List<Feature> features;
  List<Comfort> comforts;
  List<OfficeService> services;
  List<OfficePrice> prices;
  List<OfficeDetail> details;
  List<Facility> facilities;
  List<Evaluation> evaluations;
  List<Offer> offers;
  List<Coupon> coupons;
  List<Complaint> complaints;
  List<Calendar> calendars;
  List<Office> units;
  OfficeMarketing? marketing;
  bool reject;

  Office({
    required this.id,
    required this.status,
    required this.active,
    required this.isMarketing,
    required this.isReservation,
    required this.isCentral,
    required this.isCompleted,
    required this.title,
    required this.refNumber,
    required this.licenseNumber,
    required this.viewerName,
    required this.viewerPhone,
    required this.mainImage,
    required this.furnisher,
    required this.views,
    required this.isSpecial,
    required this.space,
    required this.width,
    required this.height,
    required this.description,
    required this.advertiserRelationship,
    required this.advertiserRelationshipType,
    required this.lastUpdate,
    required this.downPayment,
    required this.typeDownPayment,
    required this.categoryId,
    required this.typeAqarId,
    required this.interfaceId,
    required this.unitId,
    required this.createdAt,
    required this.updatedAt,
    required this.isFavourite,
    required this.rate,
    required this.location,
    required this.files,
    required this.typeAqar,
    required this.officeInterface,
    required this.categoryAqar,
    required this.featureaOffice,
    required this.features,
    required this.comforts,
    required this.services,
    required this.prices,
    required this.details,
    required this.facilities,
    required this.evaluations,
    required this.offers,
    required this.coupons,
    required this.complaints,
    required this.calendars,
    required this.units,
    required this.marketing,
    required this.reject,
  });

  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
      id: json["id"],
      status: json["status"] is bool
          ? json["status"]
          : json["status"].toString() == "0"
              ? false
              : true,
      active: json["active"].toString() == "0" ? false : true,
      isMarketing: json["is_marketing"] == '0' ? false : true,
      isReservation: json["is_reservation"] == '0' ? false : true,
      isCentral: json["is_central"] == '0' ? false : true,
      isCompleted: json["is_completed"] == '0' ? false : true,
      title: json["title"],
      refNumber:
          json["ref_number"] != null ? json["ref_number"].toString() : '',
      licenseNumber: json["license_number"] ?? '',
      viewerName: json["viewer_name"] ?? '',
      viewerPhone: json["viewer_phone"] != null
          ? json["viewer_phone"].toString().substring(4)
          : '',
      mainImage: json["main_image"] != null
          ? 'https://maktab.sa/${json["main_image"]}'
          : '',
      furnisher: json["furnisher"] ?? '',
      views: json["views"] != null ? int.parse(json["views"].toString()) : 0,
      isSpecial: json["is_special"] == '0' ? false : true,
      space: json["space"] != null ? num.parse(json["space"]) : null,
      width: json["width"] != null ? num.parse(json["width"]) : null,
      height: json["height"] != null ? num.parse(json["height"]) : null,
      description: json["description"] ?? '',
      advertiserRelationship: json["advertiser_relationship"] ?? '',
      advertiserRelationshipType: json["advertiser_relationship_type"] ?? '',
      lastUpdate: json["lastUpdate"] != null
          ? DateTime.parse(json["lastUpdate"])
          : null,
      downPayment:
          json["down_payment"] != null ? num.parse(json["down_payment"]) : null,
      typeDownPayment: json["type_down_payment"] != null
          ? json["type_down_payment"] == 'percent'
              ? 'نسبة'
              : 'سعر'
          : null,
      categoryId:
          json["category_id"] != null ? int.parse(json["category_id"]) : null,
      typeAqarId:
          json["type_aqar_id"] != null ? int.parse(json["type_aqar_id"]) : null,
      interfaceId:
          json["interface_id"] != null ? int.parse(json["interface_id"]) : null,
      unitId: json["unit_id"] != null ? int.parse(json["unit_id"]) : null,
      createdAt: json["created_at"] != null
          ? DateTime.parse(json["created_at"])
          : null,
      updatedAt: json["updated_at"] != null
          ? DateTime.parse(json["updated_at"])
          : null,
      isFavourite: json["is_favourite"],
      rate: json["rate"] != null ? num.parse(json["rate"].toString()) : 0.0,
      location: json["location"] != null
          ? OfficeLocation.fromJson(json["location"])
          : null,
      files: json["ads_files"] != null
          ? List<OfficeFile>.from(
              json["ads_files"].map((file) => OfficeFile.fromJson(file)))
          : [],
      typeAqar: json["type_aqar"] != null
          ? OfficeType.fromJson(json["type_aqar"])
          : null,
      officeInterface: json["interface_aqar"] != null
          ? OfficeInterface.fromJson(json["interface_aqar"])
          : null,
      categoryAqar: json["category_aqar"] != null
          ? OfficeCategory.fromJson(json["category_aqar"])
          : null,
      featureaOffice: json["featurea_ads"] != null
          ? List<FeatureaOffice>.from(
              json["featurea_ads"].map((x) => FeatureaOffice.fromJson(x)))
          : [],
      features: json["features"] != null
          ? List<Feature>.from(json["features"].map((x) => Feature.fromJson(x)))
          : [],
      comforts: json["comforts"] != null
          ? List<Comfort>.from(json["comforts"].map((x) => Comfort.fromJson(x)))
          : [],
      services: json["services"] != null
          ? List<OfficeService>.from(
              json["services"].map((x) => OfficeService.fromJson(x)))
          : [],
      prices: json["ads_prices"] != null
          ? List<OfficePrice>.from(
              json["ads_prices"].map((x) => OfficePrice.fromJson(x)))
          : [],
      details: json["ads_details"] != null
          ? List<OfficeDetail>.from(
              json["ads_details"].map((x) => OfficeDetail.fromJson(x)))
          : [],
      facilities: json["facilities"] != null
          ? List<Facility>.from(
              json["facilities"].map((x) => Facility.fromJson(x)))
          : [],
      offers: json["offers"] != null
          ? List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x)))
          : [],
      coupons: json["coupons"] != null
          ? List<Coupon>.from(json["coupons"].map((x) => Coupon.fromJson(x)))
          : [],
      evaluations: json["evaluations"] != null
          ? List<Evaluation>.from(
              json["evaluations"].map((x) => Evaluation.fromJson(x)))
          : [],
      complaints: json["reports"] != null
          ? List<Complaint>.from(
              json["reports"].map((x) => Complaint.fromJson(x)))
          : [],
      calendars: json["calendar"] != null
          ? List<Calendar>.from(
              json["calendar"].map((x) => Calendar.fromJson(x)))
          : [],
      units: json["units"] != null
          ? List<Office>.from(json["units"].map((x) => Office.fromJson(x)))
          : [],
      marketing: json["marketing"] != null
          ? OfficeMarketing.fromJson(json["marketing"])
          : null,
      reject: json["reject"] != null ? true : false,
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "is_reservation": isReservation,
        "title": title,
        "ref_number": refNumber,
        "license_number": licenseNumber,
        "viewer_name": viewerName,
        "viewer_phone": viewerPhone,
        "main_image": mainImage,
        "furnisher": furnisher,
        "views": views,
        "is_special": isSpecial,
        "space": space,
        "width": width,
        "height": height,
        "description": description,
        "advertiser_relationship": advertiserRelationship,
        "advertiser_relationship_type": advertiserRelationshipType,
        "lastUpdate":
            "${lastUpdate!.year.toString().padLeft(4, '0')}-${lastUpdate!.month.toString().padLeft(2, '0')}-${lastUpdate!.day.toString().padLeft(2, '0')}",
        "down_payment": downPayment,
        "type_down_payment": typeDownPayment,
        "category_id": categoryId,
        "type_aqar_id": typeAqarId,
        "interface_id": interfaceId,
        "unit_id": unitId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "is_favourite": isFavourite,
        "rate": rate,
        "location": location?.toJson(),
        "ads_files": List<dynamic>.from(files.map((file) => file.toJson())),
        "type_aqar": typeAqar?.toJson(),
        "interface_aqar": officeInterface?.toJson(),
        "category_aqar": categoryAqar?.toJson(),
        "featurea_ads": List<dynamic>.from(
            featureaOffice.map((featurea) => featurea.toJson())),
        "features":
            List<dynamic>.from(features.map((feature) => feature.toJson())),
        "comforts":
            List<dynamic>.from(comforts.map((comfort) => comfort.toJson())),
        "services":
            List<dynamic>.from(services.map((service) => service.toJson())),
        "ads_prices": List<dynamic>.from(prices.map((price) => price.toJson())),
        "ads_details":
            List<dynamic>.from(details.map((detail) => detail.toJson())),
        "facilities":
            List<dynamic>.from(facilities.map((facility) => facility.toJson())),
        "offers": List<dynamic>.from(offers.map((offer) => offer.toJson())),
        "evaluations": List<dynamic>.from(
            evaluations.map((evaluation) => evaluation.toJson())),
        "units": List<dynamic>.from(units.map((unit) => unit.toJson())),
      };

  Office copyWith({
    int? id,
    bool? status,
    bool? active,
    bool? isMarketing,
    bool? isReservation,
    bool? isCentral,
    bool? isCompleted,
    String? title,
    String? refNumber,
    String? licenseNumber,
    String? viewerName,
    String? viewerPhone,
    String? mainImage,
    String? furnisher,
    int? views,
    bool? isSpecial,
    num? space,
    num? width,
    num? height,
    String? description,
    String? advertiserRelationship,
    String? advertiserRelationshipType,
    DateTime? lastUpdate,
    num? downPayment,
    String? typeDownPayment,
    int? categoryId,
    int? typeAqarId,
    int? interfaceId,
    int? unitId,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isFavourite,
    num? rate,
    OfficeLocation? location,
    List<OfficeFile>? files,
    OfficeType? typeAqar,
    OfficeInterface? officeInterface,
    OfficeCategory? categoryAqar,
    List<FeatureaOffice>? featureaOffice,
    List<Feature>? features,
    List<Comfort>? comforts,
    List<OfficeService>? services,
    List<OfficePrice>? prices,
    List<OfficeDetail>? details,
    List<Facility>? facilities,
    List<Offer>? offers,
    List<Coupon>? coupons,
    List<Evaluation>? evaluations,
    List<Complaint>? complaints,
    List<Calendar>? calendars,
    List<Office>? units,
    OfficeMarketing? marketing,
    bool? reject,
  }) {
    return Office(
      id: id ?? this.id,
      status: status ?? this.status,
      active: active ?? this.active,
      isMarketing: isMarketing ?? this.isMarketing,
      isReservation: isReservation ?? this.isReservation,
      isCentral: isCentral ?? this.isCentral,
      isCompleted: isCompleted ?? this.isCompleted,
      title: title ?? this.title,
      refNumber: refNumber ?? this.refNumber,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      viewerName: viewerName ?? this.viewerName,
      viewerPhone: viewerPhone ?? this.viewerPhone,
      mainImage: mainImage ?? this.mainImage,
      furnisher: furnisher ?? this.furnisher,
      views: views ?? this.views,
      isSpecial: isSpecial ?? this.isSpecial,
      space: space ?? this.space,
      width: width ?? this.width,
      height: height ?? this.height,
      description: description ?? this.description,
      advertiserRelationship:
          advertiserRelationship ?? this.advertiserRelationship,
      advertiserRelationshipType:
          advertiserRelationshipType ?? this.advertiserRelationshipType,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      downPayment: downPayment ?? this.downPayment,
      typeDownPayment: typeDownPayment ?? this.typeDownPayment,
      categoryId: categoryId ?? this.categoryId,
      typeAqarId: typeAqarId ?? this.typeAqarId,
      interfaceId: interfaceId ?? this.interfaceId,
      unitId: unitId ?? this.unitId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isFavourite: isFavourite ?? this.isFavourite,
      rate: rate ?? this.rate,
      location: location ?? this.location,
      files: files ?? this.files,
      typeAqar: typeAqar ?? this.typeAqar,
      officeInterface: officeInterface ?? this.officeInterface,
      categoryAqar: categoryAqar ?? this.categoryAqar,
      featureaOffice: featureaOffice ?? this.featureaOffice,
      features: features ?? this.features,
      comforts: comforts ?? this.comforts,
      services: services ?? this.services,
      prices: prices ?? this.prices,
      details: details ?? this.details,
      facilities: facilities ?? this.facilities,
      offers: offers ?? this.offers,
      evaluations: evaluations ?? this.evaluations,
      coupons: coupons ?? this.coupons,
      complaints: complaints ?? this.complaints,
      calendars: calendars ?? this.calendars,
      units: units ?? this.units,
      marketing: marketing ?? this.marketing,
      reject: reject ?? this.reject,
    );
  }

  static String getOfficeState(bool state, bool active) {
    if (active) {
      return 'معروض';
    } else if (state && !active) {
      return 'معلق';
    } else {
      return 'غير معروض';
    }
  }

  static int getUnitCompleteStepsCount(Office unit) {
    int count = 1;
    if (unit.details.isNotEmpty &&
        unit.space != null &&
        unit.furnisher.isNotEmpty &&
        unit.interfaceId != null &&
        unit.typeAqarId != null) {
      count = count + 2;
    }
    if (unit.description.isNotEmpty) {
      count++;
    }
    if (unit.prices.isNotEmpty &&
        unit.viewerName.isNotEmpty &&
        unit.viewerPhone.isNotEmpty) {
      count++;
    }
    return count;
  }
}

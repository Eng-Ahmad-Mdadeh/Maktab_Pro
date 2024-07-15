import 'package:equatable/equatable.dart';
import 'package:maktab_lessor/core/network/api_endpoints.dart';

import '../aqar_filter/type_res.dart';
import '../calendar/calender_model.dart';
import '../category_aqar/category_aqar_model.dart';
import '../coupon/coupon_model.dart';
import '../evaluation/evaluation_model.dart';
import '../interface_aqar/interface_aqar_model.dart';
import '../offer/offer_model.dart';
import '../report/report_model.dart';
import '../user/user_model.dart';
import 'office_detail_model.dart';
import 'office_file.dart';
import 'office_location_model.dart';
import 'office_marketing.dart';
import 'office_price_model.dart';
import 'office_service_model.dart';

class Office extends Equatable{
  const Office({
    required this.id,
    required this.status,
    required this.active,
    required this.isMarketing,
    required this.isReservation,
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
    required this.isCompleted,
    required this.isCentral,
    required this.myRate,
    required this.tenantCommission,
    required this.tax,
    required this.conditions,
    required this.isFavourite,
    required this.rate,
    required this.offer,
    required this.location,
    required this.typeRes,
    required this.files,
    required this.typeAqar,
    required this.interfaceAqar,
    required this.categoryAqar,
    required this.comforts,
    required this.complaints,
    required this.featureaAds,
    required this.features,
    required this.services,
    required this.prices,
    required this.offers,
    required this.calendars,
    required this.facilities,
    required this.details,
    required this.evaluations,
    required this.units,
    required this.user,
    required this.lastPage,
    required this.coupons,
    required this.marketing,
    required this.reject,
  });

  final int id;
  final bool status;
  final bool active;
  final bool isMarketing;
  final String? isReservation;
  final String? title;
  final String? refNumber;
  final String? licenseNumber;
  final String? viewerName;
  final String? viewerPhone;
  final String? mainImage;
  final String? furnisher;
  final String? views;
  final String? isSpecial;
  final num? space;
  final num? width;
  final num? height;
  final String? description;
  final String? advertiserRelationship;
  final String? advertiserRelationshipType;
  final DateTime? lastUpdate;
  final num? downPayment;
  final String? typeDownPayment;
  final int categoryId;
  final String? typeAqarId;
  final int? interfaceId;
  final int? unitId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? isCompleted;
  final bool isCentral;
  final num? myRate;
  final Tax? tenantCommission;
  final Tax? tax;
  final Conditions? conditions;
  final bool? isFavourite;
  final num? rate;
  final Offer? offer;
  final OfficeLocation? location;
  final List<TypeRes> typeRes;
  final List<OfficeFile> files;
  final InterfaceAqar? typeAqar;
  final InterfaceAqar? interfaceAqar;
  final CategoryAqar? categoryAqar;
  final List<InterfaceAqar> comforts;
  final List<Report> complaints;
  final List<FeatureaAd> featureaAds;
  final List<InterfaceAqar> features;
  final List<OfficeService> services;
  final List<OfficePrice> prices;
  final List<Offer> offers;
  final List<Calendar> calendars;
  final List<CategoryAqar> facilities;
  final List<OfficeDetail> details;
  final List<Evaluation> evaluations;
  final List<Office> units;
  final User? user;
  final num? lastPage;

  final List<Coupon> coupons;
  final OfficeMarketing? marketing;
  final bool reject;


  factory Office.fromJson(Map<String, dynamic> json, [num? lPage]){
    return Office(
      id: json["id"],
      status: json["status"] == '1',
      active: json["active"] == '1',
      isMarketing: json["is_marketing"] == '1',
      isReservation: json["is_reservation"].toString(),
      title: json["title"],
      refNumber: json["ref_number"],
      licenseNumber: json["license_number"].toString(),
      viewerName: json["viewer_name"],
      viewerPhone: json["viewer_phone"],
      mainImage: json["main_image"] != null ? ApiEndpoints.siteUrl + json["main_image"] : json["main_image"],
      furnisher: json["furnisher"],
      views: json["views"].toString(),
      isSpecial: json["is_special"],
      space: num.tryParse(json["space"]??''),
      width: num.tryParse(json["width"].toString()),
      height: num.tryParse(json["height"].toString()),
      description: json["description"],
      advertiserRelationship: json["advertiser_relationship"],
      advertiserRelationshipType: json["advertiser_relationship_type"],
      lastUpdate: DateTime.tryParse(json["lastUpdate"] ?? ""),
      downPayment: num.tryParse(json["down_payment"]??''),
      typeDownPayment: json["type_down_payment"],
      categoryId: int.parse(json["category_id"]??'-1'),
      typeAqarId: json["type_aqar_id"],
      interfaceId: int.tryParse(json["interface_id"]??''),
      unitId: int.tryParse(json["unit_id"]??''),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      isCompleted: json["is_completed"],
      isCentral: json["is_central"] == '1',
      myRate: json["my_rate"] == null ? null : int.parse(json["my_rate"].toString()),
      tenantCommission: json["tenant_commission"] == null ? null : Tax.fromJson(json["tenant_commission"]),
      tax: json["tax"] == null ? null : Tax.fromJson(json["tax"]),
      conditions: json['conditions'] == null ? null : Conditions.fromJson(json["conditions"]),
      isFavourite: json["is_favourite"],
      rate: json['rate'] == null ? null : int.parse(json['rate'].toString().split('.').first),
      offer: json["offer"] == null ? null : Offer.fromJson(json["offer"]),
      location: json["location"] == null ? null : OfficeLocation.fromJson(json["location"]),
      typeRes: json["type_res"] == null ? [] : List<TypeRes>.from(json["type_res"]!.map((x) => TypeRes.fromJson(x))),
      files: json["ads_files"] == null ? [] : List<OfficeFile>.from(json["ads_files"]!.map((x) => OfficeFile.fromJson(x))),
      typeAqar: json["type_aqar"] == null ? null : InterfaceAqar.fromJson(json["type_aqar"]),
      interfaceAqar: json["interface_aqar"] == null ? null : InterfaceAqar.fromJson(json["interface_aqar"]),
      categoryAqar: json["category_aqar"] == null ? null : CategoryAqar.fromJson(json["category_aqar"]),
      comforts: json["comforts"] == null ? [] : List<InterfaceAqar>.from(json["comforts"]!.map((x) => InterfaceAqar.fromJson(x))),
      complaints: json["reports"] == null ? [] : List<Report>.from(json["reports"]!.map((x) => Report.fromJson(x))),
      featureaAds: json["featurea_ads"] == null ? [] : List<FeatureaAd>.from(json["featurea_ads"]!.map((x) => FeatureaAd.fromJson(x))),
      features: json["features"] == null ? [] : List<InterfaceAqar>.from(json["features"]!.map((x) => InterfaceAqar.fromJson(x))),
      services: json["services"] == null ? [] : List<OfficeService>.from(json["services"]!.map((x) => OfficeService.fromJson(x))),
      prices: json["ads_prices"] == null ? [] : List<OfficePrice>.from(json["ads_prices"]!.map((x) => OfficePrice.fromJson(x))),
      offers: json["offers"] == null ? [] : List<Offer>.from(json["offers"]!.map((x) => Offer.fromJson(x))),
      calendars: json["calendar"] == null ? [] : List<Calendar>.from(json["calendar"]!.map((x) => Calendar.fromJson(x))),
      facilities: json["facilities"] == null ? [] : List<CategoryAqar>.from(json["facilities"]!.map((x) => CategoryAqar.fromJson(x))),
      details: json["ads_details"] == null ? [] : List<OfficeDetail>.from(json["ads_details"]!.map((x) => OfficeDetail.fromJson(x))),
      evaluations: json["evaluations"] == null ? [] : List<Evaluation>.from(json["evaluations"]!.map((x) => Evaluation.fromJson(x))),
      units: json["units"] == null ? [] : List<Office>.from(json["units"]!.map((x) => Office.fromJson(x))),
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      coupons: json["coupons"] != null
          ? List<Coupon>.from(json["coupons"].map((x) => Coupon.fromJson(x)))
          : [],
      marketing: json["marketing"] != null
          ? OfficeMarketing.fromJson(json["marketing"])
          : null,
      reject: json["reject"] != null ? true : false,
      lastPage: lPage,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "active": active,
    "is_marketing": isMarketing,
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
    "lastUpdate": "${lastUpdate!.year.toString().padLeft(4,'0')}-${lastUpdate!.month.toString().padLeft(2,'0')}-${lastUpdate!.day.toString().padLeft(2,'0')}",
    "down_payment": downPayment,
    "type_down_payment": typeDownPayment,
    "category_id": categoryId,
    "type_aqar_id": typeAqarId,
    "interface_id": interfaceId,
    "unit_id": unitId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "is_completed": isCompleted,
    "is_central": isCentral,
    "my_rate": myRate,
    "tenant_commission": tenantCommission?.toJson(),
    "tax": tax?.toJson(),
    "conditions": conditions?.toJson(),
    "is_favourite": isFavourite,
    "rate": rate,
    "offer": offer?.toJson(),
    "location": location?.toJson(),
    "type_res": typeRes.map((x) => x.toJson()).toList(),
    "ads_files": files.map((x) => x.toJson()).toList(),
    "type_aqar": typeAqar?.toJson(),
    "interface_aqar": interfaceAqar?.toJson(),
    "category_aqar": categoryAqar?.toJson(),
    "comforts": comforts.map((x) => x.toJson()).toList(),
    "reports": complaints.map((x) => x.toJson()).toList(),
    "featurea_ads": featureaAds.map((x) => x.toJson()).toList(),
    "features": features.map((x) => x.toJson()).toList(),
    "services": services.map((x) => x.toJson()).toList(),
    "ads_prices": prices.map((x) => x.toJson()).toList(),
    "offers": offers.map((x) => x.toJson()).toList(),
    "calendar": calendars.map((x) => x.toJson()).toList(),
    "facilities": facilities.map((x) => x.toJson()).toList(),
    "ads_details": details.map((x) => x.toJson()).toList(),
    "evaluations": evaluations.map((x) => x.toJson()).toList(),
    "units": units.map((x) => x.toJson()).toList(),
    "user": user?.toJson(),

  };

  @override
  String toString(){
    return "$id, $status, $active, $isMarketing, $isReservation, $title, $refNumber, $licenseNumber, $viewerName, $viewerPhone, $mainImage, $furnisher, $views, $isSpecial, $space, $width, $height, $description, $advertiserRelationship, $advertiserRelationshipType, $lastUpdate, $downPayment, $typeDownPayment, $categoryId, $typeAqarId, $interfaceId, $unitId, $createdAt, $updatedAt, $isCompleted, $isCentral, $myRate, $tenantCommission, $tax, $conditions, $isFavourite, $rate, $offer, $location, $typeRes, $files, $typeAqar, $interfaceAqar, $categoryAqar, $comforts, $complaints, $featureaAds, $features, $services, $prices, $offers, $calendars, $facilities, $details, $evaluations, $units, $user, ";
  }

  @override
  List<Object?> get props => [
    id,
    status,
    active,
    isMarketing,
    isReservation,
    title,
    refNumber,
    licenseNumber,
    viewerName,
    viewerPhone,
    mainImage,
    furnisher,
    views,
    isSpecial,
    space,
    width,
    height,
    description,
    advertiserRelationship,
    advertiserRelationshipType,
    lastUpdate,
    downPayment,
    typeDownPayment,
    categoryId,
    typeAqarId,
    interfaceId,
    unitId,
    createdAt,
    updatedAt,
    isCompleted,
    isCentral,
    myRate,
    tenantCommission,
    tax,
    conditions,
    isFavourite,
    rate,
    offer,
    location,
    typeRes,
    files,
    typeAqar,
    interfaceAqar,
    categoryAqar,
    comforts,
    complaints,
    featureaAds,
    features,
    services,
    prices,
    offers,
    calendars,
    facilities,
    details,
    evaluations,
    units,
    user,
    lastPage,
  ];

  Office copyWith({
    int? id,
    bool? status,
    bool? active,
    bool? isMarketing,
    String? isReservation,
    String? title,
    String? refNumber,
    String? licenseNumber,
    String? viewerName,
    String? viewerPhone,
    String? mainImage,
    String? furnisher,
    String? views,
    String? isSpecial,
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
    String? typeAqarId,
    int? interfaceId,
    int? unitId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? isCompleted,
    bool? isCentral,
    int? myRate,
    Tax? tenantCommission,
    Tax? tax,
    Conditions? conditions,
    bool? isFavourite,
    int? rate,
    Offer? offer,
    OfficeLocation? location,
    List<TypeRes>? typeRes,
    List<OfficeFile>? files,
    InterfaceAqar? typeAqar,
    InterfaceAqar? interfaceAqar,
    CategoryAqar? categoryAqar,
    List<InterfaceAqar>? comforts,
    List<Report>? complaints,
    List<FeatureaAd>? featureaAds,
    List<InterfaceAqar>? features,
    List<OfficeService>? services,
    List<OfficePrice>? prices,
    List<Offer>? offers,
    List<Calendar>? calendars,
    List<CategoryAqar>? facilities,
    List<OfficeDetail>? details,
    List<Evaluation>? evaluations,
    List<Office>? units,
    User? user,
    num? lastPage,
    List<Coupon>? coupons,
    OfficeMarketing? marketing,
    bool? reject,
  }) {
    return Office(
      id: id ?? this.id,
      status: status ?? this.status,
      active: active ?? this.active,
      isMarketing: isMarketing ?? this.isMarketing,
      isReservation: isReservation ?? this.isReservation,
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
      advertiserRelationship: advertiserRelationship ?? this.advertiserRelationship,
      advertiserRelationshipType: advertiserRelationshipType ?? this.advertiserRelationshipType,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      downPayment: downPayment ?? this.downPayment,
      typeDownPayment: typeDownPayment ?? this.typeDownPayment,
      categoryId: categoryId ?? this.categoryId,
      typeAqarId: typeAqarId ?? this.typeAqarId,
      interfaceId: interfaceId ?? this.interfaceId,
      unitId: unitId ?? this.unitId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isCompleted: isCompleted ?? this.isCompleted,
      isCentral: isCentral ?? this.isCentral,
      myRate: myRate ?? this.myRate,
      tenantCommission: tenantCommission ?? this.tenantCommission,
      tax: tax ?? this.tax,
      conditions: conditions ?? this.conditions,
      isFavourite: isFavourite ?? this.isFavourite,
      rate: rate ?? this.rate,
      offer: offer ?? this.offer,
      location: location ?? this.location,
      typeRes: typeRes ?? this.typeRes,
      files: files ?? this.files,
      typeAqar: typeAqar ?? this.typeAqar,
      interfaceAqar: interfaceAqar ?? this.interfaceAqar,
      categoryAqar: categoryAqar ?? this.categoryAqar,
      comforts: comforts ?? this.comforts,
      complaints: complaints ?? this.complaints,
      featureaAds: featureaAds ?? this.featureaAds,
      features: features ?? this.features,
      services: services ?? this.services,
      prices: prices ?? this.prices,
      offers: offers ?? this.offers,
      calendars: calendars ?? this.calendars,
      facilities: facilities ?? this.facilities,
      details: details ?? this.details,
      evaluations: evaluations ?? this.evaluations,
      units: units ?? this.units,
      user: user ?? this.user,
      coupons: coupons ?? this.coupons,
      marketing: marketing ?? this.marketing,
      reject: reject ?? this.reject,
      lastPage: lastPage ?? this.lastPage,
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
    if (unit.details.isNotEmpty && unit.space != null && (unit.furnisher??'').isNotEmpty && unit.interfaceId != null && unit.typeAqarId != null) {
      count = count + 2;
    }
    if ((unit.description??'').isNotEmpty) {
      count++;
    }
    if (unit.prices.isNotEmpty && (unit.viewerName??'').isNotEmpty && (unit.viewerPhone??'').isNotEmpty) {
      count++;
    }
    return count;
  }
}

class Tax extends Equatable{
  const Tax({
    required this.rate,
  });

  final String? rate;

  factory Tax.fromJson(Map<String, dynamic> json){
    return Tax(
      rate: json["rate"],
    );
  }

  Map<String, dynamic> toJson() => {
    "rate": rate,
  };

  @override
  String toString(){
    return "$rate, ";
  }

  @override
  List<Object?> get props => [rate];

  Tax copyWith({
    String? rate,
  }) {
    return Tax(
      rate: rate ?? this.rate,
    );
  }
}

class FeatureaAd extends Equatable{
  const FeatureaAd({
    required this.id,
    required this.boolfeatureaId,
  });

  final int? id;
  final String? boolfeatureaId;

  factory FeatureaAd.fromJson(Map<String, dynamic> json){
    return FeatureaAd(
      id: json["id"],
      boolfeatureaId: json["boolfeaturea_id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "boolfeaturea_id": boolfeatureaId,
  };

  @override
  String toString(){
    return "$id, $boolfeatureaId, ";
  }

  @override
  List<Object?> get props => [
    id,
    boolfeatureaId,
  ];

  FeatureaAd copyWith({
    int? id,
    String? boolfeatureaId,
  }) {
    return FeatureaAd(
      id: id ?? this.id,
      boolfeatureaId: boolfeatureaId ?? this.boolfeatureaId,
    );
  }
}

class Conditions extends Equatable{
  const Conditions({
    required this.required,
    required this.price,
    required this.text,
  });

  final String? required;
  final String? price;
  final String? text;

  factory Conditions.fromJson(Map<String, dynamic> json){
    return Conditions(
      required: json["required"],
      price: json["price"],
      text: json["text"],
    );
  }

  Map<String, dynamic> toJson() => {
    "required": required,
    "price": price,
    "text": text,
  };

  @override
  String toString(){
    return "$required, $price, $text, ";
  }

  @override
  List<Object?> get props => [
    required,
    price,
    text,
  ];

  Conditions copyWith({
    String? required,
    String? price,
    String? text,
  }) {
    return Conditions(
      required: required ?? this.required,
      price: price ?? this.price,
      text: text ?? this.text,
    );
  }
}
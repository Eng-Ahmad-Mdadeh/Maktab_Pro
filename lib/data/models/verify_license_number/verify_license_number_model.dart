import 'package:equatable/equatable.dart';
import 'package:maktab_lessor/data/models/office/office_price_model.dart';
import 'package:maktab_lessor/data/models/type_aquar/type_aquar_model.dart';

class VerifyLicenseNumberModel extends Equatable {
  const VerifyLicenseNumberModel({
    required this.status,
    required this.isMarketing,
    required this.refNumber,
    required this.licenseNumber,
    required this.viewerName,
    required this.viewerPhone,
    required this.space,
    required this.typeAqarId,
    required this.interfaceId,
    required this.propertyAgeId,
    required this.streetWidth,
    required this.transactionType,
    // required this.price,
    required this.advertiserId,
    required this.advertiserType,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.isFavourite,
    required this.rate,
    required this.offer,
    required this.propertyUtilities,
    required this.adsDetails,
    required this.location,
    required this.interfaceAqar,
    required this.typeAqar,
    required this.propertyAge,
    required this.adsPrices,
  });

  final bool? status;
  final bool? isMarketing;
  final String? refNumber;
  final String? licenseNumber;
  final String? viewerName;
  final String? viewerPhone;
  final num? space;
  final int? typeAqarId;
  final int? interfaceId;
  final int? propertyAgeId;
  final int? streetWidth;
  final String? transactionType;
  // final num? price;
  final String? advertiserId;
  final String? advertiserType;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;
  final bool? isFavourite;
  final num? rate;
  final dynamic offer;
  final List<PropertyUtility> propertyUtilities;
  final List<AdsDetail> adsDetails;
  final Location? location;
  final EAqar? interfaceAqar;
  final List<TypeAquar>? typeAqar;
  final PropertyAge? propertyAge;
  final List<OfficePrice> adsPrices;

  factory VerifyLicenseNumberModel.fromJson(Map<String, dynamic> json) {
    return VerifyLicenseNumberModel(
      status: json["status"],
      isMarketing: json["is_marketing"],
      refNumber: json["ref_number"],
      licenseNumber: json["license_number"],
      viewerName: json["viewer_name"],
      viewerPhone: json["viewer_phone"],
      space: json["space"],
      typeAqarId: json["type_aqar_id"],
      interfaceId: json["interface_id"],
      propertyAgeId: json["property_age_id"],
      streetWidth: json["street_width"],
      transactionType: json["transaction_type"],
      // price: json["price"],
      advertiserId: json["advertiser_id"],
      advertiserType: json["advertiser_type"],
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      id: json["id"],
      isFavourite: json["is_favourite"],
      rate: json["rate"],
      offer: json["offer"],
      propertyUtilities: json["property_utilities"] == null
          ? []
          : List<PropertyUtility>.from(json["property_utilities"]!.map((x) => PropertyUtility.fromJson(x))),
      adsDetails: json["ads_details"] == null
          ? []
          : List<AdsDetail>.from(json["ads_details"]!.map((x) => AdsDetail.fromJson(x))),
      location: json["location"] == null ? null : Location.fromJson(json["location"]),
      interfaceAqar: json["interface_aqar"] == null ? null : EAqar.fromJson(json["interface_aqar"]),
      typeAqar:
          json["type_aqars"] == null ? [] : List<TypeAquar>.from(json["type_aqars"]!.map((x) => TypeAquar.fromJson(x))),
      // typeAqar: json["type_aqar"] == null ? null : EAqar.fromJson(json["type_aqar"]),
      propertyAge: json["property_age"] == null ? null : PropertyAge.fromJson(json["property_age"]),
        adsPrices: json["ads_prices"] == null
          ? []
          : List<OfficePrice>.from(json["ads_prices"]!.map((x) => OfficePrice.fromJson(x))),
    );
  }

  @override
  List<Object?> get props => [
        status,
        isMarketing,
        refNumber,
        licenseNumber,
        viewerName,
        viewerPhone,
        space,
        typeAqarId,
        interfaceId,
        propertyAgeId,
        streetWidth,
        transactionType,
        // price,
        advertiserId,
        advertiserType,
        updatedAt,
        createdAt,
        id,
        isFavourite,
        rate,
        offer,
        propertyUtilities,
        adsDetails,
        location,
        interfaceAqar,
        typeAqar,
        propertyAge,
        adsPrices,
      ];
}

class AdsDetail extends Equatable {
  const AdsDetail({
    required this.id,
    required this.arName,
    required this.enName,
    required this.status,
    required this.numberDetails,
    required this.adsId,
  });

  final int? id;
  final String? arName;
  final String? enName;
  final String? status;
  final num? numberDetails;
  final int? adsId;

  factory AdsDetail.fromJson(Map<String, dynamic> json) {
    return AdsDetail(
      id: json["id"],
      arName: json["ar_name"],
      enName: json["en_name"],
      status: json["status"],
      numberDetails: json["number_details"],
      adsId: json["ads_id"],
    );
  }

  @override
  List<Object?> get props => [
        id,
        arName,
        enName,
        status,
        numberDetails,
        adsId,
      ];
}

class EAqar extends Equatable {
  const EAqar({
    required this.id,
    required this.status,
    required this.arName,
    required this.enName,
    required this.code,
  });

  final int? id;
  final num? status;
  final String? arName;
  final String? enName;
  final String? code;

  factory EAqar.fromJson(Map<String, dynamic> json) {
    return EAqar(
      id: json["id"],
      status: json["status"],
      arName: json["ar_name"],
      enName: json["en_name"],
      code: json["code"],
    );
  }

  @override
  List<Object?> get props => [
        id,
        status,
        arName,
        enName,
        code,
      ];
}

class Location extends Equatable {
  const Location({
    required this.id,
    required this.lat,
    required this.lng,
    required this.zoom,
    required this.address,
    required this.region,
    required this.city,
    required this.neighborhood,
    required this.street,
  });

  final int? id;
  final dynamic lat;
  final dynamic lng;
  final num? zoom;
  final String? address;
  final String? region;
  final String? city;
  final String? neighborhood;
  final String? street;

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json["id"],
      lat: json["lat"] ?? json["latitude"],
      lng: json["lng"] ?? json["longitude"],
      zoom: json["zoom"],
      address: json["address"],
      region: json["region"],
      city: json["city"],
      neighborhood: json["neighborhood"],
      street: json["street"],
    );
  }

  @override
  List<Object?> get props => [
        id,
        lat,
        lng,
        zoom,
        address,
        region,
        city,
        neighborhood,
        street,
      ];
}

class PropertyAge extends Equatable {
  const PropertyAge({
    required this.id,
    required this.code,
    required this.nameAr,
    required this.nameEn,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? code;
  final String? nameAr;
  final String? nameEn;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory PropertyAge.fromJson(Map<String, dynamic> json) {
    return PropertyAge(
      id: json["id"],
      code: json["code"],
      nameAr: json["name_ar"],
      nameEn: json["name_en"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  @override
  List<Object?> get props => [
        id,
        code,
        nameAr,
        nameEn,
        createdAt,
        updatedAt,
      ];
}

class PropertyUtility extends Equatable {
  const PropertyUtility({
    required this.id,
    required this.arName,
    required this.enName,
    required this.code,
    required this.icon,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  final int? id;
  final String? arName;
  final String? enName;
  final String? code;
  final String? icon;
  final dynamic createdAt;
  final dynamic updatedAt;
  final Pivot? pivot;

  factory PropertyUtility.fromJson(Map<String, dynamic> json) {
    return PropertyUtility(
      id: json["id"],
      arName: json["ar_name"],
      enName: json["en_name"],
      code: json["code"],
      icon: json["icon"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
    );
  }

  @override
  List<Object?> get props => [
        id,
        arName,
        enName,
        code,
        icon,
        createdAt,
        updatedAt,
        pivot,
      ];
}

class Pivot extends Equatable {
  const Pivot({
    required this.adId,
    required this.propertyUtilityId,
  });

  final int? adId;
  final int? propertyUtilityId;

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      adId: json["ad_id"],
      propertyUtilityId: json["property_utility_id"],
    );
  }

  @override
  List<Object?> get props => [
        adId,
        propertyUtilityId,
      ];
}

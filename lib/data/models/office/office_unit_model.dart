import 'package:maktab/data/models/offer/offer_model.dart';

class OfficeUnit {
  int id;
  int status;
  bool isReservation;
  String title;
  String refNumber;
  String licenseNumber;
  String viewerName;
  String viewerPhone;
  String mainImage;
  String furnisher;
  int views;
  bool isSpecial;
  num space;
  num width;
  num height;
  String description;
  String advertiserRelationship;
  String advertiserRelationshipType;
  DateTime lastUpdate;
  num downPayment;
  String typeDownPayment;
  int? categoryId;
  int? typeAqarId;
  int? interfaceId;
  int? unitId;
  DateTime createdAt;
  DateTime updatedAt;
  bool isFavourite;
  num rate;
  Offer? offer;

  OfficeUnit({
    required this.id,
    required this.status,
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
    required this.isFavourite,
    required this.rate,
    required this.offer,
  });

  factory OfficeUnit.fromJson(Map<String, dynamic> json) => OfficeUnit(
        id: json["id"],
        status: int.parse(json["status"].toString()),
        isReservation: json["is_reservation"] == '0' ? false : true,
        title: json["title"],
        refNumber: json["ref_number"].toString(),
        licenseNumber: json["license_number"] ?? '',
        viewerName: json["viewer_name"] ?? '',
        viewerPhone: json["viewer_phone"] ?? '',
        mainImage: json["main_image"] ?? '',
        furnisher: json["furnisher"] ?? '',
        views: json["views"] != null ? int.parse(json["views"]) : 0,
        isSpecial: json["is_special"] == '0' ? false : true,
        space: json["space"] != null ? num.parse(json["space"]) : 0.0,
        width: json["width"] != null ? num.parse(json["width"]) : 0.0,
        height: json["height"] != null ? num.parse(json["height"]) : 0.0,
        description: json["description"] ?? '',
        advertiserRelationship: json["advertiser_relationship"] ?? '',
        advertiserRelationshipType: json["advertiser_relationship_type"] ?? '',
        lastUpdate: DateTime.parse(json["lastUpdate"]),
        downPayment: json["down_payment"] != null
            ? num.parse(json["down_payment"].toString())
            : 0.0,
        typeDownPayment: json["type_down_payment"] ?? '',
        categoryId:
            json["category_id"] != null ? int.parse(json["category_id"]) : null,
        typeAqarId: json["type_aqar_id"] != null
            ? int.parse(json["type_aqar_id"])
            : null,
        interfaceId: json["interface_id"] != null
            ? int.parse(json["interface_id"])
            : null,
        unitId: json["unit_id"] != null ? int.parse(json["unit_id"]) : null,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isFavourite: json["is_favourite"],
        rate: num.parse(json["rate"].toString()),
        offer: json["offer"] != null ? Offer.fromJson(json["offer"]) : null,
      );

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
            "${lastUpdate.year.toString().padLeft(4, '0')}-${lastUpdate.month.toString().padLeft(2, '0')}-${lastUpdate.day.toString().padLeft(2, '0')}",
        "down_payment": downPayment,
        "type_down_payment": typeDownPayment,
        "category_id": categoryId,
        "type_aqar_id": typeAqarId,
        "interface_id": interfaceId,
        "unit_id": unitId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "is_favourite": isFavourite,
        "rate": rate,
        "offer": offer,
      };
}

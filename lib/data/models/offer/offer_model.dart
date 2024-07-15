import 'package:maktab_lessor/data/models/office/office_price_model.dart';

class Offer {
  int id;
  String name;
  DateTime startDate;
  DateTime endDate;
  num discount;
  String discountType;
  bool status;
  List<int> priceTypeIds;

  Offer({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.discount,
    required this.discountType,
    required this.status,
    required this.priceTypeIds,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"],
        name: json["name"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        discount: num.parse(json["discount"]),
        discountType: json["type_discount"],
        status: json["status"] is bool
            ? json["status"]
            : json["status"].toString() == "0"
                ? false
                : true,
        priceTypeIds: json["ads_prices"] != null
            ? List<int>.from(json["ads_prices"]
                .map((price) => OfficePrice.fromJson(price).typeResId))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "start_date": startDate,
        "end_date": endDate,
        "discount": discount,
        "discount_type": discountType,
        "status": status,
      };
}

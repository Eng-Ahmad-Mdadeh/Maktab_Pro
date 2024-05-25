class Coupon {
  String name;
  bool status;
  String code;
  num discount;
  String discountType;
  DateTime startDate;
  DateTime endDate;
  int numberUsed;

  Coupon({
    required this.name,
    required this.status,
    required this.code,
    required this.discount,
    required this.discountType,
    required this.startDate,
    required this.endDate,
    required this.numberUsed,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        name: json["name"],
        status: json["status"] is bool
            ? json["status"]
            : json["status"].toString() == "0"
                ? false
                : true,
        code: json["code"],
        discount: num.parse(json["discount"]),
        discountType: json["type_discount"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        numberUsed: int.parse(json["number_used"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "status": status,
        "code": code,
        "discount": discount,
        "type_discount": discountType,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "number_used": numberUsed,
      };
}

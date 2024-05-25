class OfficePrice {
  int id;
  num price;
  int status;
  int typeResId;

  OfficePrice({
    required this.id,
    required this.price,
    required this.status,
    required this.typeResId,
  });

  factory OfficePrice.fromJson(Map<String, dynamic> json) => OfficePrice(
        id: json["id"],
        price: num.parse(json["price"].toString()),
        status: int.parse(json["status"].toString()),
        typeResId: int.parse(json["type_res_id"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "status": status,
        "type_res_id": typeResId,
      };
}

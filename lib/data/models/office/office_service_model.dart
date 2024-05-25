class OfficeService {
  int id;
  String arName;
  String enName;
  num price;
  int status;

  OfficeService({
    required this.id,
    required this.arName,
    required this.enName,
    required this.price,
    required this.status,
  });

  factory OfficeService.fromJson(Map<String, dynamic> json) => OfficeService(
        id: json["id"],
        arName: json["ar_name"],
        enName: json["en_name"],
        price: num.parse(json["price"].toString()),
        status: int.parse(json["status"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ar_name": arName,
        "en_name": enName,
        "price": price,
        "status": status,
      };
}

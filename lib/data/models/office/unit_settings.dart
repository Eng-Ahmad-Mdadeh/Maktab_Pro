class UnitSettings {
  bool isInsuranceRequired;
  num price;
  String text;

  UnitSettings({
    required this.isInsuranceRequired,
    required this.price,
    required this.text,
  });

  factory UnitSettings.fromJson(Map<String, dynamic> json) => UnitSettings(
        isInsuranceRequired: json["required"].toString() == '1' ? true : false,
        price: num.parse(json["price"].toString()),
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "required": isInsuranceRequired,
        "price": price,
        "text": text,
      };
}

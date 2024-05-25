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
        isInsuranceRequired: json["required"] == '1' ? true : false,
        price: num.parse(json["price"]),
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "required": isInsuranceRequired,
        "price": price,
        "text": text,
      };
}

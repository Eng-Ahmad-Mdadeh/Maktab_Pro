class BankAccount {
  int id;
  String status;
  String arTitle;
  String enTitle;
  String image;
  String numberAccount;
  String ibanAccount;
  DateTime createdAt;
  DateTime updatedAt;

  BankAccount({
    required this.id,
    required this.status,
    required this.arTitle,
    required this.enTitle,
    required this.image,
    required this.numberAccount,
    required this.ibanAccount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) => BankAccount(
        id: json["id"],
        status: json["status"],
        arTitle: json["ar_title"],
        enTitle: json["en_title"],
        image: json["image"],
        numberAccount: json["number_account"],
        ibanAccount: json["iban_account"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "ar_title": arTitle,
        "en_title": enTitle,
        "image": image,
        "number_account": numberAccount,
        "iban_account": ibanAccount,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

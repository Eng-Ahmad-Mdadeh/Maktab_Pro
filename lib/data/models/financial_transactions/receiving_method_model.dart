class ReceivingMethod {
  int id;
  int status;
  String type;
  String bankName;
  String accountOwnerName;
  String ibanNumber;
  String mobile;
  int userBId;
  DateTime createdAt;
  DateTime updatedAt;

  ReceivingMethod({
    required this.id,
    required this.status,
    required this.type,
    required this.bankName,
    required this.accountOwnerName,
    required this.ibanNumber,
    required this.mobile,
    required this.userBId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReceivingMethod.fromJson(Map<String, dynamic> json) =>
      ReceivingMethod(
        id: json["id"] is String ? int.parse(json["id"]) : json["id"],
        status: json["status"] is String
            ? int.parse(json["status"])
            : json["status"],
        type: json["type"],
        bankName: json["bank_name"] ?? '',
        accountOwnerName: json["account_owner_name"] ?? '',
        ibanNumber: json["iban_number"] ?? '',
        mobile: json["mobile"].toString().replaceRange(0, 4, ''),
        userBId: json["user_b_id"] is String
            ? int.parse(json["user_b_id"])
            : json["user_b_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "type": type,
        "bank_name": bankName,
        "account_owner_name": accountOwnerName,
        "iban_number": ibanNumber,
        "mobile": mobile,
        "user_b_id": userBId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

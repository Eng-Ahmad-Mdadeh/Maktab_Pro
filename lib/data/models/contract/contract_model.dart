class Contract {
  int id;
  int status;
  String statusContract;
  String type;
  num totalPrice;
  int ownershipNumber;
  String contentContract;
  int orderId;

  Contract({
    required this.id,
    required this.status,
    required this.statusContract,
    required this.type,
    required this.totalPrice,
    required this.ownershipNumber,
    required this.contentContract,
    required this.orderId,
  });

  factory Contract.fromJson(Map<String, dynamic> json) => Contract(
        id: json["id"],
        status: json["status"],
        statusContract: json["status_contract"],
        type: json["type"],
        totalPrice: json["total_price"],
        ownershipNumber: json["ownership_number"],
        contentContract: json["content_contract"],
        orderId: json["order_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "status_contract": statusContract,
        "type": type,
        "total_price": totalPrice,
        "ownership_number": ownershipNumber,
        "content_contract": contentContract,
        "order_id": orderId,
      };
}

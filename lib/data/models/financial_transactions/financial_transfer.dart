class FinancialTransfer {
  int id;
  String transferStatus;
  String transferNumber;
  DateTime executionDate;
  String transferMethod;
  String numOrder;
  dynamic receiverMobile;
  String receiverIban;
  String transferFeesRate;
  String transferFeesValue;
  String entitlementAmount;
  String netAmountTransferred;
  String remainingAmount;
  String paymentDueId;
  String paymentLessorId;
  String senderId;
  String receiverId;
  DateTime createdAt;
  DateTime updatedAt;

  FinancialTransfer({
    required this.id,
    required this.transferStatus,
    required this.transferNumber,
    required this.executionDate,
    required this.transferMethod,
    required this.numOrder,
    required this.receiverMobile,
    required this.receiverIban,
    required this.transferFeesRate,
    required this.transferFeesValue,
    required this.entitlementAmount,
    required this.netAmountTransferred,
    required this.remainingAmount,
    required this.paymentDueId,
    required this.paymentLessorId,
    required this.senderId,
    required this.receiverId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FinancialTransfer.fromJson(Map<String, dynamic> json) =>
      FinancialTransfer(
        id: json["id"],
        transferStatus: json["transfer_status"],
        transferNumber: json["transfer_number"],
        executionDate: DateTime.parse(json["execution_date"]),
        transferMethod: json["transfer_method"],
        numOrder: json["num_order"],
        receiverMobile: json["receiver_mobile"],
        receiverIban: json["receiver_iban"],
        transferFeesRate: json["transfer_fees_rate"],
        transferFeesValue: json["transfer_fees_value"],
        entitlementAmount: json["entitlement_amount"],
        netAmountTransferred: json["net_amount_transferred"],
        remainingAmount: json["remaining_amount"],
        paymentDueId: json["payment_due_id"],
        paymentLessorId: json["payment_lessor_id"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "transfer_status": transferStatus,
        "transfer_number": transferNumber,
        "execution_date": executionDate.toIso8601String(),
        "transfer_method": transferMethod,
        "num_order": numOrder,
        "receiver_mobile": receiverMobile,
        "receiver_iban": receiverIban,
        "transfer_fees_rate": transferFeesRate,
        "transfer_fees_value": transferFeesValue,
        "entitlement_amount": entitlementAmount,
        "net_amount_transferred": netAmountTransferred,
        "remaining_amount": remainingAmount,
        "payment_due_id": paymentDueId,
        "payment_lessor_id": paymentLessorId,
        "sender_id": senderId,
        "receiver_id": receiverId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

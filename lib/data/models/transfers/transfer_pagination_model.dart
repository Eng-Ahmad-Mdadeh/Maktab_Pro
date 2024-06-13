// To parse this JSON data, do
//
//     final transferPagination = transferPaginationFromJson(jsonString);

import 'dart:convert';

TransferPagination transferPaginationFromJson(String str) => TransferPagination.fromJson(json.decode(str));

String transferPaginationToJson(TransferPagination data) => json.encode(data.toJson());

class TransferPagination {
  int? currentPage;
  List<TransferModel> transfers;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link> links;
  String? nextPageUrl;
  String? path;
  String? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  TransferPagination({
    required this.currentPage,
    required this.transfers,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory TransferPagination.fromJson(Map<String, dynamic> json) => TransferPagination(
    currentPage: json["current_page"],
    transfers: List<TransferModel>.from(json["data"].map((x) => TransferModel.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "transferModel": List<dynamic>.from(transfers.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}

class TransferModel {
  int id;
  String transferStatus;
  String transferNumber;
  DateTime executionDate;
  String transferMethod;
  String numOrder;
  String receiverMobile;
  String? receiverIban;
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

  TransferModel({
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

  factory TransferModel.fromJson(Map<String, dynamic> json) => TransferModel(
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

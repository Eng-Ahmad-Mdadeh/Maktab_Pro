import 'package:equatable/equatable.dart';

class AccountSummaryModel extends Equatable {
  const AccountSummaryModel({
    required this.sumPaid,
    required this.sumRemaining,
    required this.sumCommissionValue,
    required this.sumCommissionValueLessor,
    required this.accountStatement,
  });

  final String? sumPaid;
  final int? sumRemaining;
  final String? sumCommissionValue;
  final String? sumCommissionValueLessor;
  final AccountStatement? accountStatement;

  AccountSummaryModel copyWith({
    String? sumPaid,
    int? sumRemaining,
    String? sumCommissionValue,
    String? sumCommissionValueLessor,
    AccountStatement? accountStatement,
  }) {
    return AccountSummaryModel(
      sumPaid: sumPaid ?? this.sumPaid,
      sumRemaining: sumRemaining ?? this.sumRemaining,
      sumCommissionValue: sumCommissionValue ?? this.sumCommissionValue,
      sumCommissionValueLessor: sumCommissionValueLessor ?? this.sumCommissionValueLessor,
      accountStatement: accountStatement ?? this.accountStatement,
    );
  }

  factory AccountSummaryModel.fromJson(Map<String, dynamic> json){
    return AccountSummaryModel(
      sumPaid: json["sum_paid"]?.toString(),
      sumRemaining: json["sum_remaining"],
      sumCommissionValue: json["sum_commission_value"]?.toString(),
      sumCommissionValueLessor: json["sum_commission_value_lessor"]?.toString(),
      accountStatement: json["accountStatement"] == null ? null : AccountStatement.fromJson(json["accountStatement"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "sum_paid": sumPaid,
    "sum_remaining": sumRemaining,
    "sum_commission_value": sumCommissionValue,
    "sum_commission_value_lessor": sumCommissionValueLessor,
    "accountStatement": accountStatement?.toJson(),
  };

  @override
  String toString(){
    return "$sumPaid, $sumRemaining, $sumCommissionValue, $sumCommissionValueLessor, $accountStatement, ";
  }

  @override
  List<Object?> get props => [
    sumPaid, sumRemaining, sumCommissionValue, sumCommissionValueLessor, accountStatement, ];
}

class AccountStatement extends Equatable {
  const AccountStatement({
    required this.currentPage,
    required this.data,
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

  final int? currentPage;
  final List<Datum> data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link> links;
  final String? nextPageUrl;
  final String? path;
  final String? perPage;
  final String? prevPageUrl;
  final int? to;
  final int? total;

  AccountStatement copyWith({
    int? currentPage,
    List<Datum>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<Link>? links,
    String? nextPageUrl,
    String? path,
    String? perPage,
    String? prevPageUrl,
    int? to,
    int? total,
  }) {
    return AccountStatement(
      currentPage: currentPage ?? this.currentPage,
      data: data ?? this.data,
      firstPageUrl: firstPageUrl ?? this.firstPageUrl,
      from: from ?? this.from,
      lastPage: lastPage ?? this.lastPage,
      lastPageUrl: lastPageUrl ?? this.lastPageUrl,
      links: links ?? this.links,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      path: path ?? this.path,
      perPage: perPage ?? this.perPage,
      prevPageUrl: prevPageUrl ?? this.prevPageUrl,
      to: to ?? this.to,
      total: total ?? this.total,
    );
  }

  factory AccountStatement.fromJson(Map<String, dynamic> json){
    return AccountStatement(
      currentPage: json["current_page"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      firstPageUrl: json["first_page_url"],
      from: json["from"],
      lastPage: json["last_page"],
      lastPageUrl: json["last_page_url"],
      links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
      nextPageUrl: json["next_page_url"],
      path: json["path"],
      perPage: json["per_page"],
      prevPageUrl: json["prev_page_url"],
      to: json["to"],
      total: json["total"],
    );
  }

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data.map((x) => x.toJson()).toList(),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links.map((x) => x.toJson()).toList(),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };

  @override
  String toString(){
    return "$currentPage, $data, $firstPageUrl, $from, $lastPage, $lastPageUrl, $links, $nextPageUrl, $path, $perPage, $prevPageUrl, $to, $total, ";
  }

  @override
  List<Object?> get props => [
    currentPage, data, firstPageUrl, from, lastPage, lastPageUrl, links, nextPageUrl, path, perPage, prevPageUrl, to, total, ];
}

class Datum extends Equatable {
  const Datum({
    required this.id,
    required this.nameTenant,
    required this.phoneTenant,
    required this.description,
    required this.remaining,
    required this.paid,
    required this.commissionRate,
    required this.commissionValue,
    required this.orderId,
    required this.commissionRateLessor,
    required this.commissionValueLessor,
    required this.totalPriceLessor,
    required this.comissonWithTaxLessor,
    required this.totalCommissionWithTaxLessor,
    required this.netPriceLessor,
    required this.userBId,
    required this.userOId,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? nameTenant;
  final String? phoneTenant;
  final String? description;
  final String? remaining;
  final String? paid;
  final String? commissionRate;
  final String? commissionValue;
  final String? orderId;
  final String? commissionRateLessor;
  final String? commissionValueLessor;
  final String? totalPriceLessor;
  final String? comissonWithTaxLessor;
  final String? totalCommissionWithTaxLessor;
  final String? netPriceLessor;
  final String? userBId;
  final String? userOId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Datum copyWith({
    int? id,
    String? nameTenant,
    String? phoneTenant,
    String? description,
    String? remaining,
    String? paid,
    String? commissionRate,
    String? commissionValue,
    String? orderId,
    String? commissionRateLessor,
    String? commissionValueLessor,
    String? totalPriceLessor,
    String? comissonWithTaxLessor,
    String? totalCommissionWithTaxLessor,
    String? netPriceLessor,
    String? userBId,
    String? userOId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Datum(
      id: id ?? this.id,
      nameTenant: nameTenant ?? this.nameTenant,
      phoneTenant: phoneTenant ?? this.phoneTenant,
      description: description ?? this.description,
      remaining: remaining ?? this.remaining,
      paid: paid ?? this.paid,
      commissionRate: commissionRate ?? this.commissionRate,
      commissionValue: commissionValue ?? this.commissionValue,
      orderId: orderId ?? this.orderId,
      commissionRateLessor: commissionRateLessor ?? this.commissionRateLessor,
      commissionValueLessor: commissionValueLessor ?? this.commissionValueLessor,
      totalPriceLessor: totalPriceLessor ?? this.totalPriceLessor,
      comissonWithTaxLessor: comissonWithTaxLessor ?? this.comissonWithTaxLessor,
      totalCommissionWithTaxLessor: totalCommissionWithTaxLessor ?? this.totalCommissionWithTaxLessor,
      netPriceLessor: netPriceLessor ?? this.netPriceLessor,
      userBId: userBId ?? this.userBId,
      userOId: userOId ?? this.userOId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["id"],
      nameTenant: json["name_tenant"],
      phoneTenant: json["phone_tenant"],
      description: json["description"],
      remaining: json["remaining"],
      paid: json["paid"],
      commissionRate: json["commission_rate"],
      commissionValue: json["commission_value"],
      orderId: json["order_id"],
      commissionRateLessor: json["commission_rate_lessor"],
      commissionValueLessor: json["commission_value_lessor"],
      totalPriceLessor: json["total_price_lessor"],
      comissonWithTaxLessor: json["comisson_with_tax_lessor"],
      totalCommissionWithTaxLessor: json["total_commission_with_tax_lessor"],
      netPriceLessor: json["net_price_lessor"],
      userBId: json["user_b_id"],
      userOId: json["user_o_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_tenant": nameTenant,
    "phone_tenant": phoneTenant,
    "description": description,
    "remaining": remaining,
    "paid": paid,
    "commission_rate": commissionRate,
    "commission_value": commissionValue,
    "order_id": orderId,
    "commission_rate_lessor": commissionRateLessor,
    "commission_value_lessor": commissionValueLessor,
    "total_price_lessor": totalPriceLessor,
    "comisson_with_tax_lessor": comissonWithTaxLessor,
    "total_commission_with_tax_lessor": totalCommissionWithTaxLessor,
    "net_price_lessor": netPriceLessor,
    "user_b_id": userBId,
    "user_o_id": userOId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

  @override
  String toString(){
    return "$id, $nameTenant, $phoneTenant, $description, $remaining, $paid, $commissionRate, $commissionValue, $orderId, $commissionRateLessor, $commissionValueLessor, $totalPriceLessor, $comissonWithTaxLessor, $totalCommissionWithTaxLessor, $netPriceLessor, $userBId, $userOId, $createdAt, $updatedAt, ";
  }

  @override
  List<Object?> get props => [
    id, nameTenant, phoneTenant, description, remaining, paid, commissionRate, commissionValue, orderId, commissionRateLessor, commissionValueLessor, totalPriceLessor, comissonWithTaxLessor, totalCommissionWithTaxLessor, netPriceLessor, userBId, userOId, createdAt, updatedAt, ];
}

class Link extends Equatable {
  const Link({
    required this.url,
    required this.label,
    required this.active,
  });

  final String? url;
  final String? label;
  final bool? active;

  Link copyWith({
    String? url,
    String? label,
    bool? active,
  }) {
    return Link(
      url: url ?? this.url,
      label: label ?? this.label,
      active: active ?? this.active,
    );
  }

  factory Link.fromJson(Map<String, dynamic> json){
    return Link(
      url: json["url"],
      label: json["label"],
      active: json["active"],
    );
  }

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };

  @override
  String toString(){
    return "$url, $label, $active, ";
  }

  @override
  List<Object?> get props => [
    url, label, active, ];
}

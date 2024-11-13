import 'package:equatable/equatable.dart';

import '../pagination/pagination_model.dart';
import '../user/admin_model.dart';

class InvoiceModel extends Equatable {
  const InvoiceModel({
    required this.admin,
    required this.invoicePagination,
  });

  final Admin? admin;
  final PaginationModel? invoicePagination;

  InvoiceModel copyWith({
    Admin? admin,
    PaginationModel? invoicePagination,
  }) {
    return InvoiceModel(
      admin: admin ?? this.admin,
      invoicePagination: invoicePagination ?? this.invoicePagination,
    );
  }

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      admin: json["admin"] == null ? null : Admin.fromJson(json["admin"]),
      invoicePagination: json["data"] == null ? null : PaginationModel.fromJson(json["data"]).copyWith(
        data: List<Invoice>.from(json["data"]['data']!.map((x) => Invoice.fromJson(x))),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        "admin": admin?.toJson(),
        "data": invoicePagination?.toJson(),
      };

  @override
  String toString() {
    return "$admin, $invoicePagination, ";
  }

  @override
  List<Object?> get props => [
        admin,
        invoicePagination,
      ];
}

class Invoice extends Equatable {
  const Invoice({
    required this.id,
    required this.invoiceNumber,
    required this.releaseDate,
    required this.quantity,
    required this.totalAmount,
    required this.remainingAmount,
    required this.paidAmount,
    required this.taxValue,
    required this.description,
    required this.invoiceStatus,
    required this.paymentMethod,
    required this.createdAt,
    required this.updatedAt,
    required this.paymentTenantsImage,
    required this.admin,
    required this.lessor,
  });

  final int? id;
  final String? invoiceNumber;
  final DateTime? releaseDate;
  final String? quantity;
  final String? totalAmount;
  final String? remainingAmount;
  final String? paidAmount;
  final String? taxValue;
  final String? description;
  final String? invoiceStatus;
  final String? paymentMethod;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? paymentTenantsImage;
  final Admin? admin;
  final Lessor? lessor;

  Invoice copyWith({
    int? id,
    String? invoiceNumber,
    DateTime? releaseDate,
    String? quantity,
    String? totalAmount,
    String? remainingAmount,
    String? paidAmount,
    String? taxValue,
    String? description,
    String? invoiceStatus,
    String? paymentMethod,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? paymentTenantsImage,
    Admin? admin,
    Lessor? lessor,
  }) {
    return Invoice(
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      releaseDate: releaseDate ?? this.releaseDate,
      quantity: quantity ?? this.quantity,
      totalAmount: totalAmount ?? this.totalAmount,
      remainingAmount: remainingAmount ?? this.remainingAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      taxValue: taxValue ?? this.taxValue,
      description: description ?? this.description,
      invoiceStatus: invoiceStatus ?? this.invoiceStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      paymentTenantsImage: paymentTenantsImage ?? this.paymentTenantsImage,
      admin: admin ?? this.admin,
      lessor: lessor ?? this.lessor,
    );
  }

  factory Invoice.fromJson(Map<String, dynamic> json){
    return Invoice(
      id: json["id"],
      invoiceNumber: json["invoice_number"],
      releaseDate: DateTime.tryParse(json["release_date"] ?? ""),
      quantity: json["quantity"].toString(),
      totalAmount: json["total_amount"].toString(),
      remainingAmount: json["remaining_amount"].toString(),
      paidAmount: json["paid_amount"].toString(),
      taxValue: json["tax_value"].toString(),
      description: json["description"],
      invoiceStatus: json["invoice_status"],
      paymentMethod: json["payment_method"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      paymentTenantsImage: json["payment_tenants_image"],
      admin: json["admin"] == null ? null : Admin.fromJson(json["admin"]),
      lessor: json["lessor"] == null ? null : Lessor.fromJson(json["lessor"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "invoice_number": invoiceNumber,
    "release_date": releaseDate?.toIso8601String(),
    "quantity": quantity,
    "total_amount": totalAmount,
    "remaining_amount": remainingAmount,
    "paid_amount": paidAmount,
    "tax_value": taxValue,
    "description": description,
    "invoice_status": invoiceStatus,
    "payment_method": paymentMethod,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "payment_tenants_image": paymentTenantsImage,
    "admin": admin?.toJson(),
    "lessor": lessor?.toJson(),
  };

  @override
  String toString(){
    return "$id, $invoiceNumber, $releaseDate, $quantity, $totalAmount, $remainingAmount, $paidAmount, $taxValue, $description, $invoiceStatus, $paymentMethod, $createdAt, $updatedAt, $paymentTenantsImage, $admin, $lessor, ";
  }

  @override
  List<Object?> get props => [
    id, invoiceNumber, releaseDate, quantity, totalAmount, remainingAmount, paidAmount, taxValue, description, invoiceStatus, paymentMethod, createdAt, updatedAt, paymentTenantsImage, admin, lessor, ];
}

class Lessor extends Equatable {
  const Lessor({
    required this.id,
    required this.username,
    required this.phone,
    required this.email,
    required this.city,
    required this.neighborhood,
  });

  final int? id;
  final String? username;
  final String? phone;
  final String? email;
  final String? city;
  final String? neighborhood;

  Lessor copyWith({
    int? id,
    String? username,
    String? phone,
    String? email,
    String? city,
    String? neighborhood,
  }) {
    return Lessor(
      id: id ?? this.id,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      city: city ?? this.city,
      neighborhood: neighborhood ?? this.neighborhood,
    );
  }

  factory Lessor.fromJson(Map<String, dynamic> json){
    return Lessor(
      id: json["id"],
      username: json["username"],
      phone: json["phone"],
      email: json["email"],
      city: json["city"],
      neighborhood: json["neighborhood"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "phone": phone,
    "email": email,
    "city": city,
    "neighborhood": neighborhood,
  };

  @override
  String toString(){
    return "$id, $username, $phone, $email, $city, $neighborhood, ";
  }

  @override
  List<Object?> get props => [
    id, username, phone, email, city, neighborhood, ];
}

import 'package:equatable/equatable.dart';

import '../coupon/coupon_model.dart';
import '../offer/offer_model.dart';
import '../office/office_model.dart';
import '../office/office_price_model.dart';
import '../office/office_service_model.dart';

class OrderModel extends Equatable {
  const OrderModel({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.price,
    required this.totalPriceTenant,
    required this.totalPriceLessor,
    required this.paymentMethod,
    required this.typeReservation,
    required this.reservation,
    required this.durationRes,
    required this.requiredServicesPrice,
    required this.optionalServicesPrice,
    required this.offerDiscount,
    required this.offerDiscountValue,
    required this.offerDiscountType,
    required this.couponDiscount,
    required this.couponDiscountValue,
    required this.couponDiscountType,
    required this.commissionRateTenant,
    required this.commissionValueTenant,
    required this.commissionRateLessor,
    required this.commissionValueLessor,
    required this.taxRate,
    required this.taxValueLessor,
    required this.taxValueTenant,
    required this.status,
    required this.tenantId,
    required this.lessorId,
    required this.adsId,
    required this.adsPriceId,
    required this.createdAt,
    required this.updatedAt,
    required this.lessor,
    required this.tenant,
    required this.office,
    required this.adsPrice,
    required this.services,
    required this.coupons,
    required this.offers,
    required this.paymentTenants,
    required this.lastPage,
  });

  final int? id;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? price;
  final num? totalPriceTenant;
  final num? totalPriceLessor;
  final String? paymentMethod;
  final String? typeReservation;
  final String? reservation;
  final num? durationRes;
  final num? requiredServicesPrice;
  final num? optionalServicesPrice;
  final num? offerDiscount;
  final num? offerDiscountValue;
  final String? offerDiscountType;
  final num? couponDiscount;
  final num? couponDiscountValue;
  final String? couponDiscountType;
  final String? commissionRateTenant;
  final num? commissionValueTenant;
  final String? commissionRateLessor;
  final num? commissionValueLessor;
  final String? taxRate;
  final num? taxValueLessor;
  final num? taxValueTenant;
  final String? status;
  final String? tenantId;
  final String? lessorId;
  final String? adsId;
  final String? adsPriceId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Lessor? lessor;
  final Tenant? tenant;
  final Office? office;
  final OfficePrice? adsPrice;
  final List<OfficeService> services;
  final List<Coupon> coupons;
  final List<Offer> offers;
  final List<PaymentTenant> paymentTenants;
  final int lastPage;

  OrderModel copyWith({
    int? id,
    DateTime? startDate,
    DateTime? endDate,
    double? price,
    num? totalPriceTenant,
    num? totalPriceLessor,
    String? paymentMethod,
    String? typeReservation,
    String? reservation,
    num? durationRes,
    num? requiredServicesPrice,
    num? optionalServicesPrice,
    num? offerDiscount,
    num? offerDiscountValue,
    String? offerDiscountType,
    num? couponDiscount,
    num? couponDiscountValue,
    String? couponDiscountType,
    String? commissionRateTenant,
    num? commissionValueTenant,
    String? commissionRateLessor,
    num? commissionValueLessor,
    String? taxRate,
    num? taxValueLessor,
    num? taxValueTenant,
    String? status,
    String? tenantId,
    String? lessorId,
    String? adsId,
    String? adsPriceId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Lessor? lessor,
    Tenant? tenant,
    Office? office,
    OfficePrice? adsPrice,
    List<OfficeService>? services,
    List<Coupon>? coupons,
    List<Offer>? offers,
    List<PaymentTenant>? paymentTenants,
    int? lastPage
  }) {
    return OrderModel(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      price: price ?? this.price,
      totalPriceTenant: totalPriceTenant ?? this.totalPriceTenant,
      totalPriceLessor: totalPriceLessor ?? this.totalPriceLessor,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      typeReservation: typeReservation ?? this.typeReservation,
      reservation: reservation ?? this.reservation,
      durationRes: durationRes ?? this.durationRes,
      requiredServicesPrice: requiredServicesPrice ?? this.requiredServicesPrice,
      optionalServicesPrice: optionalServicesPrice ?? this.optionalServicesPrice,
      offerDiscount: offerDiscount ?? this.offerDiscount,
      offerDiscountValue: offerDiscountValue ?? this.offerDiscountValue,
      offerDiscountType: offerDiscountType ?? this.offerDiscountType,
      couponDiscount: couponDiscount ?? this.couponDiscount,
      couponDiscountValue: couponDiscountValue ?? this.couponDiscountValue,
      couponDiscountType: couponDiscountType ?? this.couponDiscountType,
      commissionRateTenant: commissionRateTenant ?? this.commissionRateTenant,
      commissionValueTenant: commissionValueTenant ?? this.commissionValueTenant,
      commissionRateLessor: commissionRateLessor ?? this.commissionRateLessor,
      commissionValueLessor: commissionValueLessor ?? this.commissionValueLessor,
      taxRate: taxRate ?? this.taxRate,
      taxValueLessor: taxValueLessor ?? this.taxValueLessor,
      taxValueTenant: taxValueTenant ?? this.taxValueTenant,
      status: status ?? this.status,
      tenantId: tenantId ?? this.tenantId,
      lessorId: lessorId ?? this.lessorId,
      adsId: adsId ?? this.adsId,
      adsPriceId: adsPriceId ?? this.adsPriceId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lessor: lessor ?? this.lessor,
      tenant: tenant ?? this.tenant,
      office: office ?? this.office,
      adsPrice: adsPrice ?? this.adsPrice,
      services: services ?? this.services,
      coupons: coupons ?? this.coupons,
      offers: offers ?? this.offers,
      paymentTenants: paymentTenants ?? this.paymentTenants,
      lastPage: lastPage?? this.lastPage
    );
  }

  factory OrderModel.fromJson(Map<String, dynamic> json, [int? lastPage]){
    return OrderModel(
      id: json["id"],
      startDate: DateTime.tryParse(json["start_date"] ?? ""),
      endDate: DateTime.tryParse(json["end_date"] ?? ""),
      price: double.tryParse(json["price"]),
      totalPriceTenant: json["total_price_tenant"],
      totalPriceLessor: json["total_price_lessor"],
      paymentMethod: json["payment_method"],
      typeReservation: json["type_reservation"],
      reservation: json["reservation"],
      durationRes: num.tryParse(json["duration_res"]),
      requiredServicesPrice: json["required_services_price"],
      optionalServicesPrice: json["optional_services_price"],
      offerDiscount: json["offer_discount"],
      offerDiscountValue: json["offer_discount_value"],
      offerDiscountType: json["offer_discount_type"],
      couponDiscount: json["coupon_discount"],
      couponDiscountValue: json["coupon_discount_value"],
      couponDiscountType: json["coupon_discount_type"],
      commissionRateTenant: json["commission_rate_tenant"],
      commissionValueTenant: json["commission_value_tenant"],
      commissionRateLessor: json["commission_rate_lessor"],
      commissionValueLessor: json["commission_value_lessor"],
      taxRate: json["tax_rate"],
      taxValueLessor: json["tax_value_lessor"],
      taxValueTenant: json["tax_value_tenant"],
      status: json["status"],
      tenantId: json["tenant_id"],
      lessorId: json["lessor_id"],
      adsId: json["ads_id"],
      adsPriceId: json["order_price_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      lessor: json["lessor"] == null ? null : Lessor.fromJson(json["lessor"]),
      tenant: json["tenant"] == null ? null : Tenant.fromJson(json["tenant"]),
      office: json["ads"] == null ? null : Office.fromJson(json["ads"]),
      adsPrice: json["ads_price"] == null ? null : OfficePrice.fromJson(json["ads_price"]),
      services: json["services"] == null ? [] : List<OfficeService>.from(json["services"]!.map((x) => OfficeService.fromJson(x))),
      coupons: json["coupons"] == null ? [] : List<Coupon>.from(json["coupons"]!.map((x) => Coupon.fromJson(x))),
      offers: json["offers"] == null ? [] : List<Offer>.from(json["offers"]!.map((x) => Offer.fromJson(x))),
      paymentTenants: json["payment_tenants"] == null ? [] : List<PaymentTenant>.from(json["payment_tenants"]!.map((x) => PaymentTenant.fromJson(x))),
      lastPage: lastPage??1,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "start_date": startDate?.toIso8601String(),
    "end_date": endDate?.toIso8601String(),
    "price": price,
    "total_price_tenant": totalPriceTenant,
    "total_price_lessor": totalPriceLessor,
    "payment_method": paymentMethod,
    "type_reservation": typeReservation,
    "reservation": reservation,
    "duration_res": durationRes,
    "required_services_price": requiredServicesPrice,
    "optional_services_price": optionalServicesPrice,
    "offer_discount": offerDiscount,
    "offer_discount_value": offerDiscountValue,
    "offer_discount_type": offerDiscountType,
    "coupon_discount": couponDiscount,
    "coupon_discount_value": couponDiscountValue,
    "coupon_discount_type": couponDiscountType,
    "commission_rate_tenant": commissionRateTenant,
    "commission_value_tenant": commissionValueTenant,
    "commission_rate_lessor": commissionRateLessor,
    "commission_value_lessor": commissionValueLessor,
    "tax_rate": taxRate,
    "tax_value_lessor": taxValueLessor,
    "tax_value_tenant": taxValueTenant,
    "status": status,
    "tenant_id": tenantId,
    "lessor_id": lessorId,
    "ads_id": adsId,
    "ads_price_id": adsPriceId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "lessor": lessor?.toJson(),
    "tenant": tenant?.toJson(),
    "ads": office?.toJson(),
    "ads_price": adsPrice?.toJson(),
    "services": services.map((x) => x).toList(),
    "coupons": coupons.map((x) => x).toList(),
    "offers": offers.map((x) => x).toList(),
    "payment_tenants": paymentTenants.map((x) => x.toJson()).toList(),
  };

  @override
  String toString(){
    return "$id, $startDate, $endDate, $price, $totalPriceTenant, $totalPriceLessor, $paymentMethod, $typeReservation, $reservation, $durationRes, $requiredServicesPrice, $optionalServicesPrice, $offerDiscount, $offerDiscountValue, $offerDiscountType, $couponDiscount, $couponDiscountValue, $couponDiscountType, $commissionRateTenant, $commissionValueTenant, $commissionRateLessor, $commissionValueLessor, $taxRate, $taxValueLessor, $taxValueTenant, $status, $tenantId, $lessorId, $adsId, $adsPriceId, $createdAt, $updatedAt, $lessor, $tenant, $office, $adsPrice, $services, $coupons, $offers, $paymentTenants, ";
  }

  @override
  List<Object?> get props => [
    id, startDate, endDate,lastPage, price, totalPriceTenant, totalPriceLessor, paymentMethod, typeReservation, reservation, durationRes, requiredServicesPrice, optionalServicesPrice, offerDiscount, offerDiscountValue, offerDiscountType, couponDiscount, couponDiscountValue, couponDiscountType, commissionRateTenant, commissionValueTenant, commissionRateLessor, commissionValueLessor, taxRate, taxValueLessor, taxValueTenant, status, tenantId, lessorId, adsId, adsPriceId, createdAt, updatedAt, lessor, tenant, office, adsPrice, services, coupons, offers, paymentTenants, ];

  static String getCounterReservationType(String type) {
    switch (type) {
      case 'yearly':
        return 'سنة';
      case 'monthly':
        return 'شهر';
      case 'daily':
        return 'يوم';
      case 'hourly':
        return 'ساعة';
      default:
        return '';
    }
  }
}

class Location extends Equatable {
  const Location({
    required this.id,
    required this.lat,
    required this.lng,
    required this.zoom,
    required this.address,
    required this.city,
    required this.neighborhood,
    required this.street,
  });

  final int? id;
  final String? lat;
  final String? lng;
  final String? zoom;
  final String? address;
  final String? city;
  final String? neighborhood;
  final String? street;

  Location copyWith({
    int? id,
    String? lat,
    String? lng,
    String? zoom,
    String? address,
    String? city,
    String? neighborhood,
    String? street,
  }) {
    return Location(
      id: id ?? this.id,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      zoom: zoom ?? this.zoom,
      address: address ?? this.address,
      city: city ?? this.city,
      neighborhood: neighborhood ?? this.neighborhood,
      street: street ?? this.street,
    );
  }

  factory Location.fromJson(Map<String, dynamic> json){
    return Location(
      id: json["id"],
      lat: json["lat"],
      lng: json["lng"],
      zoom: json["zoom"],
      address: json["address"],
      city: json["city"],
      neighborhood: json["neighborhood"],
      street: json["street"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "lat": lat,
    "lng": lng,
    "zoom": zoom,
    "address": address,
    "city": city,
    "neighborhood": neighborhood,
    "street": street,
  };

  @override
  String toString(){
    return "$id, $lat, $lng, $zoom, $address, $city, $neighborhood, $street, ";
  }

  @override
  List<Object?> get props => [
    id, lat, lng, zoom, address, city, neighborhood, street, ];
}

class Lessor extends Equatable {
  const Lessor({
    required this.id,
    required this.username,
    required this.companyName,
    required this.code,
    required this.phone,
    required this.email,
    required this.officeName,
    required this.about,
    required this.licenseLink,
    required this.licenseNumber,
    required this.city,
    required this.neighborhood,
    required this.commercialRecord,
    required this.membershipValidity,
    required this.idNumber,
    required this.residenceId,
    required this.isNafath,
  });

  final int? id;
  final String? username;
  final dynamic companyName;
  final String? code;
  final String? phone;
  final String? email;
  final dynamic officeName;
  final String? about;
  final String? licenseLink;
  final String? licenseNumber;
  final String? city;
  final String? neighborhood;
  final String? commercialRecord;
  final dynamic membershipValidity;
  final String? idNumber;
  final dynamic residenceId;
  final String? isNafath;

  Lessor copyWith({
    int? id,
    String? username,
    String? companyName,
    String? code,
    String? phone,
    String? email,
    String? officeName,
    String? about,
    String? licenseLink,
    String? licenseNumber,
    String? city,
    String? neighborhood,
    String? commercialRecord,
    String? membershipValidity,
    String? idNumber,
    String? residenceId,
    String? isNafath,
  }) {
    return Lessor(
      id: id ?? this.id,
      username: username ?? this.username,
      companyName: companyName ?? this.companyName,
      code: code ?? this.code,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      officeName: officeName ?? this.officeName,
      about: about ?? this.about,
      licenseLink: licenseLink ?? this.licenseLink,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      city: city ?? this.city,
      neighborhood: neighborhood ?? this.neighborhood,
      commercialRecord: commercialRecord ?? this.commercialRecord,
      membershipValidity: membershipValidity ?? this.membershipValidity,
      idNumber: idNumber ?? this.idNumber,
      residenceId: residenceId ?? this.residenceId,
      isNafath: isNafath ?? this.isNafath,
    );
  }

  factory Lessor.fromJson(Map<String, dynamic> json){
    return Lessor(
      id: json["id"],
      username: json["username"],
      companyName: json["company_name"],
      code: json["code"],
      phone: json["phone"],
      email: json["email"],
      officeName: json["office_name"],
      about: json["about"],
      licenseLink: json["licenseLink"],
      licenseNumber: json["license_number"],
      city: json["city"],
      neighborhood: json["neighborhood"],
      commercialRecord: json["commercial_record"],
      membershipValidity: json["membership_validity"],
      idNumber: json["IdNumber"],
      residenceId: json["residence_id"],
      isNafath: json["is_nafath"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "company_name": companyName,
    "code": code,
    "phone": phone,
    "email": email,
    "office_name": officeName,
    "about": about,
    "licenseLink": licenseLink,
    "license_number": licenseNumber,
    "city": city,
    "neighborhood": neighborhood,
    "commercial_record": commercialRecord,
    "membership_validity": membershipValidity,
    "IdNumber": idNumber,
    "residence_id": residenceId,
    "is_nafath": isNafath,
  };

  @override
  String toString(){
    return "$id, $username, $companyName, $code, $phone, $email, $officeName, $about, $licenseLink, $licenseNumber, $city, $neighborhood, $commercialRecord, $membershipValidity, $idNumber, $residenceId, $isNafath, ";
  }

  @override
  List<Object?> get props => [
    id, username, companyName, code, phone, email, officeName, about, licenseLink, licenseNumber, city, neighborhood, commercialRecord, membershipValidity, idNumber, residenceId, isNafath, ];
}

class PaymentTenant extends Equatable {
  const PaymentTenant({
    required this.id,
    required this.image,
    required this.paymentMethod,
    required this.totalAmount,
    required this.paid,
    required this.remaining,
    required this.isDownPayment,
    required this.tenantId,
    required this.orderId,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? image;
  final String? paymentMethod;
  final String? totalAmount;
  final String? paid;
  final String? remaining;
  final String? isDownPayment;
  final String? tenantId;
  final String? orderId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PaymentTenant copyWith({
    int? id,
    String? image,
    String? paymentMethod,
    String? totalAmount,
    String? paid,
    String? remaining,
    String? isDownPayment,
    String? tenantId,
    String? orderId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PaymentTenant(
      id: id ?? this.id,
      image: image ?? this.image,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      totalAmount: totalAmount ?? this.totalAmount,
      paid: paid ?? this.paid,
      remaining: remaining ?? this.remaining,
      isDownPayment: isDownPayment ?? this.isDownPayment,
      tenantId: tenantId ?? this.tenantId,
      orderId: orderId ?? this.orderId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory PaymentTenant.fromJson(Map<String, dynamic> json){
    return PaymentTenant(
      id: json["id"],
      image: json["image"],
      paymentMethod: json["payment_method"],
      totalAmount: json["total_amount"],
      paid: json["paid"],
      remaining: json["remaining"],
      isDownPayment: json["is_down_payment"],
      tenantId: json["tenant_id"],
      orderId: json["order_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "payment_method": paymentMethod,
    "total_amount": totalAmount,
    "paid": paid,
    "remaining": remaining,
    "is_down_payment": isDownPayment,
    "tenant_id": tenantId,
    "order_id": orderId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

  @override
  String toString(){
    return "$id, $image, $paymentMethod, $totalAmount, $paid, $remaining, $isDownPayment, $tenantId, $orderId, $createdAt, $updatedAt, ";
  }

  @override
  List<Object?> get props => [
    id, image, paymentMethod, totalAmount, paid, remaining, isDownPayment, tenantId, orderId, createdAt, updatedAt, ];
}

class Tenant extends Equatable {
  const Tenant({
    required this.id,
    required this.status,
    required this.username,
    required this.code,
    required this.phone,
    required this.email,
    required this.city,
    required this.neighborhood,
    required this.idNumber,
  });

  final int? id;
  final String? status;
  final String? username;
  final String? code;
  final String? phone;
  final String? email;
  final String? city;
  final String? neighborhood;
  final String? idNumber;

  Tenant copyWith({
    int? id,
    String? status,
    String? username,
    String? code,
    String? phone,
    String? email,
    String? city,
    String? neighborhood,
    String? idNumber,
  }) {
    return Tenant(
      id: id ?? this.id,
      status: status ?? this.status,
      username: username ?? this.username,
      code: code ?? this.code,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      city: city ?? this.city,
      neighborhood: neighborhood ?? this.neighborhood,
      idNumber: idNumber ?? this.idNumber,
    );
  }

  factory Tenant.fromJson(Map<String, dynamic> json){
    return Tenant(
      id: json["id"],
      status: json["status"],
      username: json["username"],
      code: json["code"],
      phone: json["phone"],
      email: json["email"],
      city: json["city"],
      neighborhood: json["neighborhood"],
      idNumber: json["IdNumber"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "username": username,
    "code": code,
    "phone": phone,
    "email": email,
    "city": city,
    "neighborhood": neighborhood,
    "IdNumber": idNumber,
  };

  @override
  String toString(){
    return "$id, $status, $username, $code, $phone, $email, $city, $neighborhood, $idNumber, ";
  }

  @override
  List<Object?> get props => [
    id, status, username, code, phone, email, city, neighborhood, idNumber, ];

}

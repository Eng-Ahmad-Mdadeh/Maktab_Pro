import 'package:equatable/equatable.dart';

import '../order/order_model.dart';
import '../user/admin_model.dart';

enum ContractType { waiting, accepted, expired, canceled, none }

class ContractModel extends Equatable {
  const ContractModel({
    required this.id,
    required this.status,
    required this.actionDate,
    required this.contractEndDate,
    required this.contractStartDate,
    required this.contractNumber,
    required this.contractType,
    required this.contractContent,
    required this.contractApplicant,
    required this.propertyOwner,
    required this.acceptOrdinaries,
    required this.lessorDateBirth,
    required this.lessorFullName,
    required this.lessorIdentityNum,
    required this.lessorIdentityType,
    required this.lessorNationality,
    required this.lessorPhone,
    required this.lessorAddress,
    required this.lessorIban,
    required this.lessorRoyalDeedType,
    required this.lessorRoyalDeedNumber,
    required this.tenantDateBirth,
    required this.tenantFullName,
    required this.tenantIdentityNum,
    required this.tenantIdentityType,
    required this.tenantNationality,
    required this.tenantPhone,
    required this.tenantAddress,
    required this.officeAdditionalNo,
    required this.officeBuildingNo,
    required this.officeAddress,
    required this.officeCity,
    required this.officeNeighborhood,
    required this.officeLatitude,
    required this.officeLongitude,
    required this.officeStreet,
    required this.officePostalCode,
    required this.officeName,
    required this.officeUnitNo,
    required this.officeNoFloor,
    required this.officeTypeAqar,
    required this.officeCategoryAqar,
    required this.officeSpace,
    required this.officeLengthFrontEnd,
    required this.officeIsMushtab,
    required this.recordFile,
    required this.recordNumber,
    required this.noCentralConditioners,
    required this.noWindowConditioners,
    required this.noSplitConditioners,
    required this.waterConstAmount,
    required this.waterMoney,
    required this.electricityConstAmount,
    required this.electricityMoney,
    required this.rentPaymentCycle,
    required this.durationDaysOpenContract,
    required this.durationDaysCancelContract,
    required this.notes,
    required this.typeReservation,
    required this.downPayment,
    required this.insuranceAmount,
    required this.totalPrice,
    required this.orderId,
    required this.contractModelId,
    required this.lessorId,
    required this.tenantId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.lessorApproved,
    required this.tenantApproved,
    required this.facilityType,
    required this.facilityName,
    required this.unifiedNumber,
    required this.commercialRecordDate,
    required this.tenantType,
    required this.requiredApprove,
    required this.order,
    required this.admin,
    required this.customContractType,
  });

  final int? id;
  final String? status;
  final DateTime? actionDate;
  final DateTime? contractEndDate;
  final DateTime? contractStartDate;
  final String? contractNumber;
  final String? contractType;
  final String? contractContent;
  final String? contractApplicant;
  final String? propertyOwner;
  final bool? acceptOrdinaries;
  final DateTime? lessorDateBirth;
  final String? lessorFullName;
  final String? lessorIdentityNum;
  final String? lessorIdentityType;
  final String? lessorNationality;
  final String? lessorPhone;
  final String? lessorAddress;
  final String? lessorIban;
  final String? lessorRoyalDeedType;
  final String? lessorRoyalDeedNumber;
  final DateTime? tenantDateBirth;
  final String? tenantFullName;
  final String? tenantIdentityNum;
  final String? tenantIdentityType;
  final String? tenantNationality;
  final String? tenantPhone;
  final String? tenantAddress;
  final String? officeAdditionalNo;
  final String? officeBuildingNo;
  final String? officeAddress;
  final String? officeCity;
  final String? officeNeighborhood;
  final String? officeLatitude;
  final String? officeLongitude;
  final String? officeStreet;
  final String? officePostalCode;
  final String? officeName;
  final String? officeUnitNo;
  final String? officeNoFloor;
  final String? officeTypeAqar;
  final String? officeCategoryAqar;
  final String? officeSpace;
  final String? officeLengthFrontEnd;
  final String? officeIsMushtab;
  final String? recordFile;
  final String? recordNumber;
  final String? noCentralConditioners;
  final String? noWindowConditioners;
  final String? noSplitConditioners;
  final String? waterConstAmount;
  final String? waterMoney;
  final String? electricityConstAmount;
  final String? electricityMoney;
  final String? rentPaymentCycle;
  final String? durationDaysOpenContract;
  final String? durationDaysCancelContract;
  final String? notes;
  final String? typeReservation;
  final String? downPayment;
  final String? insuranceAmount;
  final String? totalPrice;
  final String? orderId;
  final String? contractModelId;
  final String? lessorId;
  final String? tenantId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final bool? lessorApproved;
  final bool? tenantApproved;
  final String? facilityType;
  final String? facilityName;
  final String? unifiedNumber;
  final String? commercialRecordDate;
  final String? tenantType;
  final String? requiredApprove;
  final ContractType customContractType;
  final OrderModel? order;
  final Admin? admin;

  ContractModel copyWith({
    int? id,
    String? status,
    DateTime? actionDate,
    DateTime? contractEndDate,
    DateTime? contractStartDate,
    String? contractNumber,
    String? contractType,
    String? contractContent,
    String? contractApplicant,
    String? propertyOwner,
    bool? acceptOrdinaries,
    DateTime? lessorDateBirth,
    String? lessorFullName,
    String? lessorIdentityNum,
    String? lessorIdentityType,
    String? lessorNationality,
    String? lessorPhone,
    String? lessorAddress,
    String? lessorIban,
    String? lessorRoyalDeedType,
    String? lessorRoyalDeedNumber,
    DateTime? tenantDateBirth,
    String? tenantFullName,
    String? tenantIdentityNum,
    String? tenantIdentityType,
    String? tenantNationality,
    String? tenantPhone,
    String? tenantAddress,
    String? officeAdditionalNo,
    String? officeBuildingNo,
    String? officeAddress,
    String? officeCity,
    String? officeNeighborhood,
    String? officeLatitude,
    String? officeLongitude,
    String? officeStreet,
    String? officePostalCode,
    String? officeName,
    String? officeUnitNo,
    String? officeNoFloor,
    String? officeTypeAqar,
    String? officeCategoryAqar,
    String? officeSpace,
    String? officeLengthFrontEnd,
    String? officeIsMushtab,
    String? recordFile,
    String? recordNumber,
    String? noCentralConditioners,
    String? noWindowConditioners,
    String? noSplitConditioners,
    String? waterConstAmount,
    String? waterMoney,
    String? electricityConstAmount,
    String? electricityMoney,
    String? rentPaymentCycle,
    String? durationDaysOpenContract,
    String? durationDaysCancelContract,
    String? notes,
    String? typeReservation,
    String? downPayment,
    String? insuranceAmount,
    String? totalPrice,
    String? orderId,
    String? contractModelId,
    String? lessorId,
    String? tenantId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    bool? lessorApproved,
    bool? tenantApproved,
    String? facilityType,
    String? facilityName,
    String? unifiedNumber,
    String? commercialRecordDate,
    String? tenantType,
    String? requiredApprove,
    OrderModel? order,
    Admin? admin,
    ContractType? customContractType,
  }) {
    return ContractModel(
      id: id ?? this.id,
      status: status ?? this.status,
      actionDate: actionDate ?? this.actionDate,
      contractEndDate: contractEndDate ?? this.contractEndDate,
      contractStartDate: contractStartDate ?? this.contractStartDate,
      contractNumber: contractNumber ?? this.contractNumber,
      contractType: contractType ?? this.contractType,
      contractContent: contractContent ?? this.contractContent,
      contractApplicant: contractApplicant ?? this.contractApplicant,
      propertyOwner: propertyOwner ?? this.propertyOwner,
      acceptOrdinaries: acceptOrdinaries ?? this.acceptOrdinaries,
      lessorDateBirth: lessorDateBirth ?? this.lessorDateBirth,
      lessorFullName: lessorFullName ?? this.lessorFullName,
      lessorIdentityNum: lessorIdentityNum ?? this.lessorIdentityNum,
      lessorIdentityType: lessorIdentityType ?? this.lessorIdentityType,
      lessorNationality: lessorNationality ?? this.lessorNationality,
      lessorPhone: lessorPhone ?? this.lessorPhone,
      lessorAddress: lessorAddress ?? this.lessorAddress,
      lessorIban: lessorIban ?? this.lessorIban,
      lessorRoyalDeedType: lessorRoyalDeedType ?? this.lessorRoyalDeedType,
      lessorRoyalDeedNumber: lessorRoyalDeedNumber ?? this.lessorRoyalDeedNumber,
      tenantDateBirth: tenantDateBirth ?? this.tenantDateBirth,
      tenantFullName: tenantFullName ?? this.tenantFullName,
      tenantIdentityNum: tenantIdentityNum ?? this.tenantIdentityNum,
      tenantIdentityType: tenantIdentityType ?? this.tenantIdentityType,
      tenantNationality: tenantNationality ?? this.tenantNationality,
      tenantPhone: tenantPhone ?? this.tenantPhone,
      tenantAddress: tenantAddress ?? this.tenantAddress,
      officeAdditionalNo: officeAdditionalNo ?? this.officeAdditionalNo,
      officeBuildingNo: officeBuildingNo ?? this.officeBuildingNo,
      officeAddress: officeAddress ?? this.officeAddress,
      officeCity: officeCity ?? this.officeCity,
      officeNeighborhood: officeNeighborhood ?? this.officeNeighborhood,
      officeLatitude: officeLatitude ?? this.officeLatitude,
      officeLongitude: officeLongitude ?? this.officeLongitude,
      officeStreet: officeStreet ?? this.officeStreet,
      officePostalCode: officePostalCode ?? this.officePostalCode,
      officeName: officeName ?? this.officeName,
      officeUnitNo: officeUnitNo ?? this.officeUnitNo,
      officeNoFloor: officeNoFloor ?? this.officeNoFloor,
      officeTypeAqar: officeTypeAqar ?? this.officeTypeAqar,
      officeCategoryAqar: officeCategoryAqar ?? this.officeCategoryAqar,
      officeSpace: officeSpace ?? this.officeSpace,
      officeLengthFrontEnd: officeLengthFrontEnd ?? this.officeLengthFrontEnd,
      officeIsMushtab: officeIsMushtab ?? this.officeIsMushtab,
      recordFile: recordFile ?? this.recordFile,
      recordNumber: recordNumber ?? this.recordNumber,
      noCentralConditioners: noCentralConditioners ?? this.noCentralConditioners,
      noWindowConditioners: noWindowConditioners ?? this.noWindowConditioners,
      noSplitConditioners: noSplitConditioners ?? this.noSplitConditioners,
      waterConstAmount: waterConstAmount ?? this.waterConstAmount,
      waterMoney: waterMoney ?? this.waterMoney,
      electricityConstAmount: electricityConstAmount ?? this.electricityConstAmount,
      electricityMoney: electricityMoney ?? this.electricityMoney,
      rentPaymentCycle: rentPaymentCycle ?? this.rentPaymentCycle,
      durationDaysOpenContract: durationDaysOpenContract ?? this.durationDaysOpenContract,
      durationDaysCancelContract: durationDaysCancelContract ?? this.durationDaysCancelContract,
      notes: notes ?? this.notes,
      typeReservation: typeReservation ?? this.typeReservation,
      downPayment: downPayment ?? this.downPayment,
      insuranceAmount: insuranceAmount ?? this.insuranceAmount,
      totalPrice: totalPrice ?? this.totalPrice,
      orderId: orderId ?? this.orderId,
      contractModelId: contractModelId ?? this.contractModelId,
      lessorId: lessorId ?? this.lessorId,
      tenantId: tenantId ?? this.tenantId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      lessorApproved: lessorApproved ?? this.lessorApproved,
      tenantApproved: tenantApproved ?? this.tenantApproved,
      facilityType: facilityType ?? this.facilityType,
      facilityName: facilityName ?? this.facilityName,
      unifiedNumber: unifiedNumber ?? this.unifiedNumber,
      commercialRecordDate: commercialRecordDate ?? this.commercialRecordDate,
      tenantType: tenantType ?? this.tenantType,
      requiredApprove: requiredApprove ?? this.requiredApprove,
      order: order ?? this.order,
      admin: admin ?? this.admin,
      customContractType: customContractType ?? this.customContractType,
    );
  }

  factory ContractModel.fromJson(Map<String, dynamic> json) {
    // 'New', 'Renewed', 'Finished'
    // 'منتهي', 'ملغي', 'بأنتظار الموافقة', 'مقبول'
    ContractType getType() {
      if (DateTime.tryParse(json["contract_end_date"] ?? "")!.isBefore(DateTime.now())) return ContractType.expired;
      if ((json["lessor_approved"] ?? false) && (json["tenant_approved"] ?? false)) {
        if (json["required_approve"] == '1') return ContractType.canceled;
        if (json["required_approve"] == '2') return ContractType.none;
      }
      if (json["contract_type"] == '') {
        if (json["required_approve"] == '1') return ContractType.waiting;
        if (json["required_approve"] == '2') return ContractType.none;
      }
      if (json["contract_type"] == 'New') {
        if (json["required_approve"] == '1') return ContractType.accepted;
        if (json["required_approve"] == '2') return ContractType.none;
      }
      return ContractType.none;
    }


    return ContractModel(
      id: json["id"],
      status: json["status"],
      actionDate: DateTime.tryParse(json["action_date"] ?? ""),
      contractEndDate: DateTime.tryParse(json["contract_end_date"] ?? ""),
      contractStartDate: DateTime.tryParse(json["contract_start_date"] ?? ""),
      contractNumber: json["contract_number"],
      contractType: json["contract_type"],
      contractContent: json["contract_content"],
      contractApplicant: json["contract_applicant"],
      propertyOwner: json["property_owner"],
      acceptOrdinaries: json["accept_ordinaries"],
      lessorDateBirth: DateTime.tryParse(json["lessor_date_birth"] ?? ""),
      lessorFullName: json["lessor_full_name"],
      lessorIdentityNum: json["lessor_identity_num"],
      lessorIdentityType: json["lessor_identity_type"],
      lessorNationality: json["lessor_nationality"],
      lessorPhone: json["lessor_phone"],
      lessorAddress: json["lessor_address"],
      lessorIban: json["lessor_iban"],
      lessorRoyalDeedType: json["lessor_royal_deed_type"],
      lessorRoyalDeedNumber: json["lessor_royal_deed_number"],
      tenantDateBirth: DateTime.tryParse(json["tenant_date_birth"] ?? ""),
      tenantFullName: json["tenant_full_name"],
      tenantIdentityNum: json["tenant_identity_num"],
      tenantIdentityType: json["tenant_identity_type"],
      tenantNationality: json["tenant_nationality"],
      tenantPhone: json["tenant_phone"],
      tenantAddress: json["tenant_address"],
      officeAdditionalNo: json["office_additional_no"],
      officeBuildingNo: json["office_building_no"],
      officeAddress: json["office_address"],
      officeCity: json["office_city"],
      officeNeighborhood: json["office_neighborhood"],
      officeLatitude: json["office_latitude"],
      officeLongitude: json["office_longitude"],
      officeStreet: json["office_street"],
      officePostalCode: json["office_postal_code"],
      officeName: json["office_name"],
      officeUnitNo: json["office_unit_no"].toString(),
      officeNoFloor: json["office_no_floor"].toString(),
      officeTypeAqar: json["office_type_aqar"],
      officeCategoryAqar: json["office_category_aqar"],
      officeSpace: json["office_space"].toString(),
      officeLengthFrontEnd: json["office_length_front_end"].toString(),
      officeIsMushtab: json["office_is_mushtab"].toString(),
      recordFile: json["record_file"],
      recordNumber: json["record_number"],
      noCentralConditioners: json["no_central_conditioners"].toString(),
      noWindowConditioners: json["no_window_conditioners"].toString(),
      noSplitConditioners: json["no_split_conditioners"].toString(),
      waterConstAmount: json["water_const_amount"].toString(),
      waterMoney: json["water_money"],
      electricityConstAmount: json["electricity_const_amount"].toString(),
      electricityMoney: json["electricity_money"],
      rentPaymentCycle: json["rent_payment_cycle"],
      durationDaysOpenContract: json["duration_days_open_contract"].toString(),
      durationDaysCancelContract: json["duration_days_cancel_contract"].toString(),
      notes: json["notes"],
      typeReservation: json["type_reservation"],
      downPayment: json["down_payment"].toString(),
      insuranceAmount: json["insurance_amount"].toString(),
      totalPrice: json["total_price"].toString(),
      orderId: json["order_id"],
      contractModelId: json["contract_model_id"].toString(),
      lessorId: json["lessor_id"],
      tenantId: json["tenant_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      lessorApproved: json["lessor_approved"],
      tenantApproved: json["tenant_approved"],
      facilityType: json["facility_type"],
      facilityName: json["facility_name"],
      unifiedNumber: json["unified_number"],
      commercialRecordDate: json["commercial_record_date"],
      tenantType: json["tenant_type"],
      requiredApprove: json["required_approve"].toString(),
      order: json["order"] == null ? null : OrderModel.fromJson(json["order"]),
      admin: json["admin"] == null ? null : Admin.fromJson(json["admin"]),
      customContractType: getType(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "action_date": actionDate?.toIso8601String(),
        "contract_end_date": contractEndDate?.toIso8601String(),
        "contract_start_date": contractStartDate?.toIso8601String(),
        "contract_number": contractNumber,
        "contract_type": contractType,
        "contract_content": contractContent,
        "contract_applicant": contractApplicant,
        "property_owner": propertyOwner,
        "accept_ordinaries": acceptOrdinaries,
        "lessor_date_birth": lessorDateBirth?.toIso8601String(),
        "lessor_full_name": lessorFullName,
        "lessor_identity_num": lessorIdentityNum,
        "lessor_identity_type": lessorIdentityType,
        "lessor_nationality": lessorNationality,
        "lessor_phone": lessorPhone,
        "lessor_address": lessorAddress,
        "lessor_iban": lessorIban,
        "lessor_royal_deed_type": lessorRoyalDeedType,
        "lessor_royal_deed_number": lessorRoyalDeedNumber,
        "tenant_date_birth": tenantDateBirth?.toIso8601String(),
        "tenant_full_name": tenantFullName,
        "tenant_identity_num": tenantIdentityNum,
        "tenant_identity_type": tenantIdentityType,
        "tenant_nationality": tenantNationality,
        "tenant_phone": tenantPhone,
        "tenant_address": tenantAddress,
        "office_additional_no": officeAdditionalNo,
        "office_building_no": officeBuildingNo,
        "office_address": officeAddress,
        "office_city": officeCity,
        "office_neighborhood": officeNeighborhood,
        "office_latitude": officeLatitude,
        "office_longitude": officeLongitude,
        "office_street": officeStreet,
        "office_postal_code": officePostalCode,
        "office_name": officeName,
        "office_unit_no": officeUnitNo,
        "office_no_floor": officeNoFloor,
        "office_type_aqar": officeTypeAqar,
        "office_category_aqar": officeCategoryAqar,
        "office_space": officeSpace,
        "office_length_front_end": officeLengthFrontEnd,
        "office_is_mushtab": officeIsMushtab,
        "record_file": recordFile,
        "record_number": recordNumber,
        "no_central_conditioners": noCentralConditioners,
        "no_window_conditioners": noWindowConditioners,
        "no_split_conditioners": noSplitConditioners,
        "water_const_amount": waterConstAmount,
        "water_money": waterMoney,
        "electricity_const_amount": electricityConstAmount,
        "electricity_money": electricityMoney,
        "rent_payment_cycle": rentPaymentCycle,
        "duration_days_open_contract": durationDaysOpenContract,
        "duration_days_cancel_contract": durationDaysCancelContract,
        "notes": notes,
        "type_reservation": typeReservation,
        "down_payment": downPayment,
        "insurance_amount": insuranceAmount,
        "total_price": totalPrice,
        "order_id": orderId,
        "contract_model_id": contractModelId,
        "lessor_id": lessorId,
        "tenant_id": tenantId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "lessor_approved": lessorApproved,
        "tenant_approved": tenantApproved,
        "facility_type": facilityType,
        "facility_name": facilityName,
        "unified_number": unifiedNumber,
        "commercial_record_date": commercialRecordDate,
        "tenant_type": tenantType,
        "required_approve": requiredApprove,
        "order": order?.toJson(),
        "admin": admin?.toJson(),
      };

  @override
  String toString() {
    return "$id, $status, $actionDate, $contractEndDate, $contractStartDate, $contractNumber, $contractType, $contractContent, $contractApplicant, $propertyOwner, $acceptOrdinaries, $lessorDateBirth, $lessorFullName, $lessorIdentityNum, $lessorIdentityType, $lessorNationality, $lessorPhone, $lessorAddress, $lessorIban, $lessorRoyalDeedType, $lessorRoyalDeedNumber, $tenantDateBirth, $tenantFullName, $tenantIdentityNum, $tenantIdentityType, $tenantNationality, $tenantPhone, $tenantAddress, $officeAdditionalNo, $officeBuildingNo, $officeAddress, $officeCity, $officeNeighborhood, $officeLatitude, $officeLongitude, $officeStreet, $officePostalCode, $officeName, $officeUnitNo, $officeNoFloor, $officeTypeAqar, $officeCategoryAqar, $officeSpace, $officeLengthFrontEnd, $officeIsMushtab, $recordFile, $recordNumber, $noCentralConditioners, $noWindowConditioners, $noSplitConditioners, $waterConstAmount, $waterMoney, $electricityConstAmount, $electricityMoney, $rentPaymentCycle, $durationDaysOpenContract, $durationDaysCancelContract, $notes, $typeReservation, $downPayment, $insuranceAmount, $totalPrice, $orderId, $contractModelId, $lessorId, $tenantId, $createdAt, $updatedAt, $deletedAt, $lessorApproved, $tenantApproved, $facilityType, $facilityName, $unifiedNumber, $commercialRecordDate, $order, $admin";
  }

  @override
  List<Object?> get props => [
        id,
        status,
        admin,
        actionDate,
        tenantType,
        contractEndDate,
        contractStartDate,
        contractNumber,
        contractType,
        contractContent,
        contractApplicant,
        propertyOwner,
        acceptOrdinaries,
        lessorDateBirth,
        lessorFullName,
        lessorIdentityNum,
        lessorIdentityType,
        lessorNationality,
        lessorPhone,
        lessorAddress,
        lessorIban,
        lessorRoyalDeedType,
        lessorRoyalDeedNumber,
        tenantDateBirth,
        tenantFullName,
        tenantIdentityNum,
        tenantIdentityType,
        tenantNationality,
        tenantPhone,
        tenantAddress,
        officeAdditionalNo,
        officeBuildingNo,
        officeAddress,
        officeCity,
        officeNeighborhood,
        officeLatitude,
        officeLongitude,
        officeStreet,
        officePostalCode,
        officeName,
        officeUnitNo,
        officeNoFloor,
        officeTypeAqar,
        officeCategoryAqar,
        officeSpace,
        officeLengthFrontEnd,
        officeIsMushtab,
        recordFile,
        recordNumber,
        noCentralConditioners,
        noWindowConditioners,
        noSplitConditioners,
        waterConstAmount,
        waterMoney,
        electricityConstAmount,
        electricityMoney,
        rentPaymentCycle,
        durationDaysOpenContract,
        durationDaysCancelContract,
        notes,
        typeReservation,
        downPayment,
        insuranceAmount,
        totalPrice,
        orderId,
        contractModelId,
        lessorId,
        tenantId,
        createdAt,
        updatedAt,
        deletedAt,
        lessorApproved,
        tenantApproved,
        facilityType,
        facilityName,
        unifiedNumber,
        commercialRecordDate,
        order,
      ];
}

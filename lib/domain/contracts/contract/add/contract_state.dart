import 'package:equatable/equatable.dart';

import '../../../../data/models/order/order_model.dart';
import '../../../../presentation/contracts_menu/screens/contracts/screens/contract/screens/add/widgets/step2/additional_info_widget.dart';
import '../../../../presentation/contracts_menu/screens/contracts/screens/contract/screens/add/widgets/step2/order_info_widget.dart';
import 'contract_cubit.dart';

class ContractEntity extends Equatable {
  final PropertyOwnerType? propertyOwner;
  final ContractApplicantType? contractApplicant;
  final LessorRoyalDeedType? lessorRoyalDeedType;
  final String? lessorRoyalDeedNumber;
  final String? lessorFullName;
  final String? lessorIdentityNum;
  final IdentityType? lessorIdentityType;
  final String? lessorNationality;
  final String? lessorPhone;
  final String? lessorAddress;
  final String? lessorDateBirth;
  final String? lessorIban;
  final String? tenantFullName;
  final String? tenantIdentityNum;
  final IdentityType? tenantIdentityType;
  final TenantType? tenantType;
  final String? tenantNationality;
  final String? tenantPhone;
  final String? tenantAddress;
  final String? tenantDateBirth;
  final String? tenantOrgName;
  final String? tenantOrgType;
  final String? tenantOrgNumber;
  final String? recordDate;
  final String? recordNumber;
  final String? recordFile;
  final bool? isOrderOn;
  final bool? mustAccept;
  final OrderModel? order;
  final String? officeName;
  final String? officeCategoryAqar;
  final String? officeTypeAqar;
  final String? officeCity;
  final String? officeAddress;
  final String? officeNeighborhood;
  final String? officeStreet;
  final String? officePostalCode;
  final String? officeAdditionalNo;
  final String? officeBuildingNo;
  final String? officeUnitNo;
  final String? officeSpace;
  final String? officeLengthFrontEnd;
  final YesOrNoType? officeIsMushtab;
  final String? officeNoFloor;
  final bool? isConditions;
  final String? conditionsCount;
  final ConditionsType? conditionsType;
  final PaymentCycleType? rentPaymentCycle;
  final TypeReservationType? idTypeReservation;
  final String? actionDate;
  final String? contractStartDate;
  final String? contractEndDate;
  final String? durationDaysOpenContract;
  final String? durationDaysCancelContract;
  final String? notes;
  final num? waterConstAmount;
  final WaterElectricityType? waterType;
  final String? electricityConstAmount;
  final WaterElectricityType? electricityType;
  final String? officeLatitude;
  final String? officeLongitude;
  final String? downPayment;
  final String? insuranceAmount;
  final String? totalPrice;
  final String? contractContent;
  final String? contractModelId;

  @override
  List<Object?> get props => [
        propertyOwner,
        contractApplicant,
        lessorRoyalDeedType,
        lessorRoyalDeedNumber,
        lessorFullName,
        lessorIdentityNum,
        lessorIdentityType,
        lessorNationality,
        lessorPhone,
        lessorAddress,
        lessorDateBirth,
        lessorIban,
        tenantFullName,
        tenantIdentityNum,
        tenantIdentityType,
        tenantType,
        tenantNationality,
        tenantPhone,
        tenantAddress,
        tenantDateBirth,
        tenantOrgName,
        tenantOrgType,
        tenantOrgNumber,
        recordDate,
        recordNumber,
        recordFile,
        isOrderOn,
    mustAccept,
        order,
        officeName,
        officeCategoryAqar,
        officeTypeAqar,
        officeCity,
        officeAddress,
        officeNeighborhood,
        officeStreet,
        officePostalCode,
        officeAdditionalNo,
        officeBuildingNo,
        officeUnitNo,
        officeSpace,
        officeLengthFrontEnd,
        officeIsMushtab,
        officeNoFloor,
        isConditions,
        conditionsCount,
        conditionsType,
        rentPaymentCycle,
        idTypeReservation,
        actionDate,
        contractStartDate,
        contractEndDate,
        durationDaysOpenContract,
        durationDaysCancelContract,
        notes,
        waterConstAmount,
        waterType,
        electricityConstAmount,
        electricityType,
        officeLatitude,
        officeLongitude,
        downPayment,
        insuranceAmount,
        totalPrice,
        contractContent,
        contractModelId,
      ];

  factory ContractEntity.empty() => const ContractEntity();

  const ContractEntity({
    this.propertyOwner,
    this.contractApplicant,
    this.lessorRoyalDeedType,
    this.lessorRoyalDeedNumber,
    this.lessorFullName,
    this.lessorIdentityNum,
    this.lessorIdentityType,
    this.lessorNationality,
    this.lessorPhone,
    this.lessorAddress,
    this.lessorDateBirth,
    this.lessorIban,
    this.tenantFullName,
    this.tenantIdentityNum,
    this.tenantIdentityType,
    this.tenantType,
    this.tenantNationality,
    this.tenantPhone,
    this.tenantAddress,
    this.tenantDateBirth,
    this.tenantOrgName,
    this.tenantOrgType,
    this.tenantOrgNumber,
    this.recordDate,
    this.recordNumber,
    this.recordFile,
    this.isOrderOn,
    this.mustAccept,
    this.order,
    this.officeName,
    this.officeCategoryAqar,
    this.officeTypeAqar,
    this.officeCity,
    this.officeAddress,
    this.officeNeighborhood,
    this.officeStreet,
    this.officePostalCode,
    this.officeAdditionalNo,
    this.officeBuildingNo,
    this.officeUnitNo,
    this.officeSpace,
    this.officeLengthFrontEnd,
    this.officeIsMushtab,
    this.officeNoFloor,
    this.isConditions,
    this.conditionsCount,
    this.conditionsType,
    this.rentPaymentCycle,
    this.idTypeReservation,
    this.actionDate,
    this.contractStartDate,
    this.contractEndDate,
    this.durationDaysOpenContract,
    this.durationDaysCancelContract,
    this.notes,
    this.waterConstAmount,
    this.waterType,
    this.electricityConstAmount,
    this.electricityType,
    this.officeLatitude,
    this.officeLongitude,
    this.downPayment,
    this.insuranceAmount,
    this.totalPrice,
    this.contractContent,
    this.contractModelId,
  });

  ContractEntity setNull({
    bool propertyOwner = false,
    bool contractApplicant = false,
    bool lessorRoyalDeedType = false,
    bool lessorRoyalDeedNumber = false,
    bool lessorFullName = false,
    bool lessorIdentityNum = false,
    bool lessorIdentityType = false,
    bool lessorNationality = false,
    bool lessorPhone = false,
    bool lessorAddress = false,
    bool lessorDateBirth = false,
    bool lessorIban = false,
    bool tenantFullName = false,
    bool tenantIdentityNum = false,
    bool tenantIdentityType = false,
    bool tenantType = false,
    bool tenantNationality = false,
    bool tenantPhone = false,
    bool tenantAddress = false,
    bool tenantDateBirth = false,
    bool recordNumber = false,
    bool tenantOrgName = false,
    bool tenantOrgType = false,
    bool tenantOrgNumber = false,
    bool recordDate = false,
    bool recordFile = false,
    bool isOrderOn = false,
    bool mustAccept = false,
    bool order = false,
    bool officeName = false,
    bool officeCategoryAqar = false,
    bool officeTypeAqar = false,
    bool officeCity = false,
    bool officeAddress = false,
    bool officeNeighborhood = false,
    bool officeStreet = false,
    bool officePostalCode = false,
    bool officeAdditionalNo = false,
    bool officeBuildingNo = false,
    bool officeUnitNo = false,
    bool officeSpace = false,
    bool officeLengthFrontEnd = false,
    bool officeIsMushtab = false,
    bool officeNoFloor = false,
    bool isConditions = false,
    bool conditionsCount = false,
    bool conditionsType = false,
    bool rentPaymentCycle = false,
    bool idTypeReservation = false,
    bool actionDate = false,
    bool contractStartDate = false,
    bool contractEndDate = false,
    bool durationDaysOpenContract = false,
    bool durationDaysCancelContract = false,
    bool notes = false,
    bool waterConstAmount = false,
    bool waterType = false,
    bool electricityConstAmount = false,
    bool electricityType = false,
    bool officeLatitude = false,
    bool officeLongitude = false,
    bool downPayment = false,
    bool insuranceAmount = false,
    bool totalPrice = false,
    bool contractContent = false,
    bool contractModelId = false,
  }) {
    return ContractEntity(
      propertyOwner: propertyOwner ? null : this.propertyOwner,
      contractApplicant: contractApplicant ? null : this.contractApplicant,
      lessorRoyalDeedType: lessorRoyalDeedType ? null : this.lessorRoyalDeedType,
      lessorRoyalDeedNumber: lessorRoyalDeedNumber ? null : this.lessorRoyalDeedNumber,
      lessorFullName: lessorFullName ? null : this.lessorFullName,
      lessorIdentityNum: lessorIdentityNum ? null : this.lessorIdentityNum,
      lessorIdentityType: lessorIdentityType ? null : this.lessorIdentityType,
      lessorNationality: lessorNationality ? null : this.lessorNationality,
      lessorPhone: lessorPhone ? null : this.lessorPhone,
      lessorAddress: lessorAddress ? null : this.lessorAddress,
      lessorDateBirth: lessorDateBirth ? null : this.lessorDateBirth,
      lessorIban: lessorIban ? null : this.lessorIban,
      tenantFullName: tenantFullName ? null : this.tenantFullName,
      tenantIdentityNum: tenantIdentityNum ? null : this.tenantIdentityNum,
      tenantIdentityType: tenantIdentityType ? null : this.tenantIdentityType,
      tenantType: tenantType ? null : this.tenantType,
      tenantNationality: tenantNationality ? null : this.tenantNationality,
      tenantPhone: tenantPhone ? null : this.tenantPhone,
      tenantAddress: tenantAddress ? null : this.tenantAddress,
      tenantDateBirth: tenantDateBirth ? null : this.tenantDateBirth,
      tenantOrgName: tenantOrgName ? null : this.tenantOrgName,
      tenantOrgType: tenantOrgType ? null : this.tenantOrgType,
      tenantOrgNumber: tenantOrgNumber ? null : this.tenantOrgNumber,
      recordDate: recordDate ? null : this.recordDate,
      recordNumber: recordNumber ? null : this.recordNumber,
      recordFile: recordFile ? null : this.recordFile,
      isOrderOn: isOrderOn ? null : this.isOrderOn,
      mustAccept: mustAccept ? null : this.mustAccept,
      order: order ? null : this.order,
      officeName: officeName ? null : this.officeName,
      officeCategoryAqar: officeCategoryAqar ? null : this.officeCategoryAqar,
      officeTypeAqar: officeTypeAqar ? null : this.officeTypeAqar,
      officeCity: officeCity ? null : this.officeCity,
      officeAddress: officeAddress ? null : this.officeAddress,
      officeNeighborhood: officeNeighborhood ? null : this.officeNeighborhood,
      officeStreet: officeStreet ? null : this.officeStreet,
      officePostalCode: officePostalCode ? null : this.officePostalCode,
      officeAdditionalNo: officeAdditionalNo ? null : this.officeAdditionalNo,
      officeBuildingNo: officeBuildingNo ? null : this.officeBuildingNo,
      officeUnitNo: officeUnitNo ? null : this.officeUnitNo,
      officeSpace: officeSpace ? null : this.officeSpace,
      officeLengthFrontEnd: officeLengthFrontEnd ? null : this.officeLengthFrontEnd,
      officeIsMushtab: officeIsMushtab ? null : this.officeIsMushtab,
      officeNoFloor: officeNoFloor ? null : this.officeNoFloor,
      isConditions: isConditions ? null : this.isConditions,
      conditionsCount: conditionsCount ? null : this.conditionsCount,
      conditionsType: conditionsType ? null : this.conditionsType,
      rentPaymentCycle: rentPaymentCycle ? null : this.rentPaymentCycle,
      idTypeReservation: idTypeReservation ? null : this.idTypeReservation,
      actionDate: actionDate ? null : this.actionDate,
      contractStartDate: contractStartDate ? null : this.contractStartDate,
      contractEndDate: contractEndDate ? null : this.contractEndDate,
      durationDaysOpenContract: durationDaysOpenContract ? null : this.durationDaysOpenContract,
      durationDaysCancelContract: durationDaysCancelContract ? null : this.durationDaysCancelContract,
      notes: notes ? null : this.notes,
      waterConstAmount: waterConstAmount ? null : this.waterConstAmount,
      waterType: waterType ? null : this.waterType,
      electricityConstAmount: electricityConstAmount ? null : this.electricityConstAmount,
      electricityType: electricityType ? null : this.electricityType,
      officeLatitude: officeLatitude ? null : this.officeLatitude,
      officeLongitude: officeLongitude ? null : this.officeLongitude,
      downPayment: downPayment ? null : this.downPayment,
      insuranceAmount: insuranceAmount ? null : this.insuranceAmount,
      totalPrice: totalPrice ? null : this.totalPrice,
      contractContent: contractContent ? null : this.contractContent,
      contractModelId: contractModelId ? null : this.contractModelId,
    );
  }

  ContractEntity copyWith({
    PropertyOwnerType? propertyOwner,
    ContractApplicantType? contractApplicant,
    LessorRoyalDeedType? lessorRoyalDeedType,
    String? lessorRoyalDeedNumber,
    String? lessorFullName,
    String? lessorIdentityNum,
    IdentityType? lessorIdentityType,
    String? lessorNationality,
    String? lessorPhone,
    String? lessorAddress,
    String? lessorDateBirth,
    String? lessorIban,
    String? tenantFullName,
    String? tenantOrgName,
    String? tenantOrgType,
    String? tenantOrgNumber,
    String? recordDate,
    String? recordNumber,
    String? recordFile,
    String? tenantIdentityNum,
    IdentityType? tenantIdentityType,
    TenantType? tenantType,
    String? tenantNationality,
    String? tenantPhone,
    String? tenantAddress,
    String? tenantDateBirth,
    bool? isOrderOn,
    bool? mustAccept,
    OrderModel? order,
    String? officeName,
    String? officeCategoryAqar,
    String? officeTypeAqar,
    String? officeCity,
    String? officeAddress,
    String? officeNeighborhood,
    String? officeStreet,
    String? officePostalCode,
    String? officeAdditionalNo,
    String? officeBuildingNo,
    String? officeUnitNo,
    String? officeSpace,
    String? officeLengthFrontEnd,
    YesOrNoType? officeIsMushtab,
    String? officeNoFloor,
    bool? isConditions,
    String? conditionsCount,
    ConditionsType? conditionsType,
    PaymentCycleType? rentPaymentCycle,
    TypeReservationType? idTypeReservation,
    String? actionDate,
    String? contractStartDate,
    String? contractEndDate,
    String? durationDaysOpenContract,
    String? durationDaysCancelContract,
    String? notes,
    num? waterConstAmount,
    WaterElectricityType? waterType,
    String? electricityConstAmount,
    WaterElectricityType? electricityType,
    String? officeLatitude,
    String? officeLongitude,
    String? downPayment,
    String? insuranceAmount,
    String? totalPrice,
    String? contractContent,
    String? contractModelId,
  }) {
    return ContractEntity(
      propertyOwner: propertyOwner ?? this.propertyOwner,
      contractApplicant: contractApplicant ?? this.contractApplicant,
      lessorRoyalDeedType: lessorRoyalDeedType ?? this.lessorRoyalDeedType,
      lessorRoyalDeedNumber: lessorRoyalDeedNumber ?? this.lessorRoyalDeedNumber,
      lessorFullName: lessorFullName ?? this.lessorFullName,
      lessorIdentityNum: lessorIdentityNum ?? this.lessorIdentityNum,
      lessorIdentityType: lessorIdentityType ?? this.lessorIdentityType,
      lessorNationality: lessorNationality ?? this.lessorNationality,
      lessorPhone: lessorPhone ?? this.lessorPhone,
      lessorAddress: lessorAddress ?? this.lessorAddress,
      lessorDateBirth: lessorDateBirth ?? this.lessorDateBirth,
      lessorIban: lessorIban ?? this.lessorIban,
      tenantFullName: tenantFullName ?? this.tenantFullName,
      tenantIdentityNum: tenantIdentityNum ?? this.tenantIdentityNum,
      tenantIdentityType: tenantIdentityType ?? this.tenantIdentityType,
      tenantType: tenantType ?? this.tenantType,
      tenantNationality: tenantNationality ?? this.tenantNationality,
      tenantPhone: tenantPhone ?? this.tenantPhone,
      tenantAddress: tenantAddress ?? this.tenantAddress,
      tenantDateBirth: tenantDateBirth ?? this.tenantDateBirth,
      tenantOrgName: tenantOrgName ?? this.tenantOrgName,
      tenantOrgType: tenantOrgType ?? this.tenantOrgType,
      tenantOrgNumber: tenantOrgNumber ?? this.tenantOrgNumber,
      recordDate: recordDate ?? this.recordDate,
      recordNumber: recordNumber ?? this.recordNumber,
      recordFile: recordFile ?? this.recordFile,
      isOrderOn: isOrderOn ?? this.isOrderOn,
      mustAccept: mustAccept ?? this.mustAccept,
      order: order ?? this.order,
      officeName: officeName ?? this.officeName,
      officeCategoryAqar: officeCategoryAqar ?? this.officeCategoryAqar,
      officeTypeAqar: officeTypeAqar ?? this.officeTypeAqar,
      officeCity: officeCity ?? this.officeCity,
      officeAddress: officeAddress ?? this.officeAddress,
      officeNeighborhood: officeNeighborhood ?? this.officeNeighborhood,
      officeStreet: officeStreet ?? this.officeStreet,
      officePostalCode: officePostalCode ?? this.officePostalCode,
      officeAdditionalNo: officeAdditionalNo ?? this.officeAdditionalNo,
      officeBuildingNo: officeBuildingNo ?? this.officeBuildingNo,
      officeUnitNo: officeUnitNo ?? this.officeUnitNo,
      officeSpace: officeSpace ?? this.officeSpace,
      officeLengthFrontEnd: officeLengthFrontEnd ?? this.officeLengthFrontEnd,
      officeIsMushtab: officeIsMushtab ?? this.officeIsMushtab,
      officeNoFloor: officeNoFloor ?? this.officeNoFloor,
      isConditions: isConditions ?? this.isConditions,
      conditionsCount: conditionsCount ?? this.conditionsCount,
      conditionsType: conditionsType ?? this.conditionsType,
      rentPaymentCycle: rentPaymentCycle ?? this.rentPaymentCycle,
      idTypeReservation: idTypeReservation ?? this.idTypeReservation,
      actionDate: actionDate ?? this.actionDate,
      contractStartDate: contractStartDate ?? this.contractStartDate,
      contractEndDate: contractEndDate ?? this.contractEndDate,
      durationDaysOpenContract: durationDaysOpenContract ?? this.durationDaysOpenContract,
      durationDaysCancelContract: durationDaysCancelContract ?? this.durationDaysCancelContract,
      notes: notes ?? this.notes,
      waterConstAmount: waterConstAmount ?? this.waterConstAmount,
      waterType: waterType ?? this.waterType,
      electricityConstAmount: electricityConstAmount ?? this.electricityConstAmount,
      electricityType: electricityType ?? this.electricityType,
      officeLatitude: officeLatitude ?? this.officeLatitude,
      officeLongitude: officeLongitude ?? this.officeLongitude,
      downPayment: downPayment ?? this.downPayment,
      insuranceAmount: insuranceAmount ?? this.insuranceAmount,
      totalPrice: totalPrice ?? this.totalPrice,
      contractContent: contractContent ?? this.contractContent,
      contractModelId: contractModelId ?? this.contractModelId,
    );
  }

  factory ContractEntity.fromJson(Map<String, dynamic> json) {
    return ContractEntity(
      propertyOwner: json['property_owner'],
      contractApplicant: json['contract_applicant'],
      lessorRoyalDeedType: json['lessor_royal_deed_type'],
      lessorRoyalDeedNumber: json['lessor_royal_deed_number'],
      lessorFullName: json['lessor_full_name'],
      lessorIdentityNum: json['lessor_identity_num'],
      lessorIdentityType: json['lessor_identity_type'],
      lessorNationality: json['lessor_nationality'],
      lessorPhone: json['lessor_phone'],
      lessorAddress: json['lessor_address'],
      lessorDateBirth: json['lessor_date_birth'],
      lessorIban: json['lessor_iban'],
      tenantFullName: json['tenant_full_name'],
      tenantIdentityNum: json['tenant_identity_num'],
      tenantIdentityType: json['tenant_identity_type'],
      tenantNationality: json['tenant_nationality'],
      tenantPhone: json['tenant_phone'],
      tenantAddress: json['tenant_address'],
      tenantDateBirth: json['tenant_date_birth'],
      tenantOrgName: json['facility_name'],
      tenantOrgType: json['tenant_type'],
      tenantOrgNumber: json['unified_number'],
      recordDate: json['commercial_record_date'],
      recordNumber: json['record_number'],
      officeName: json['office_name'],
      officeCategoryAqar: json['office_category_aqar'],
      officeTypeAqar: json['office_type_aqar'],
      officeCity: json['office_city'],
      officeAddress: json['office_address'],
      officeNeighborhood: json['office_neighborhood'],
      officeStreet: json['office_street'],
      officePostalCode: json['office_postal_code'],
      officeAdditionalNo: json['office_additional_no'],
      officeBuildingNo: json['office_building_no'],
      officeUnitNo: json['office_unit_no'],
      officeSpace: json['office_space'],
      officeLengthFrontEnd: json['office_length_front_end'],
      officeIsMushtab: json['office_is_mushtab'],
      officeNoFloor: json['office_no_floor'],
      rentPaymentCycle: json['rent_payment_cycle'],
      idTypeReservation: json['id_type_reservation'],
      actionDate: json['action_date'],
      contractStartDate: json['contract_start_date'],
      contractEndDate: json['contract_end_date'],
      durationDaysOpenContract: json['duration_days_open_contract'],
      durationDaysCancelContract: json['duration_days_cancel_contract'],
      notes: json['notes'],
      waterConstAmount: json['water_const_amount'].toDouble(),
      electricityConstAmount: json['electricity_const_amount'].toDouble(),
      officeLatitude: json['office_latitude'].toDouble(),
      officeLongitude: json['office_longitude'].toDouble(),
      downPayment: json['down_payment'].toDouble(),
      insuranceAmount: json['insurance_amount'].toDouble(),
      totalPrice: json['total_price'].toDouble(),
      contractContent: json['contract_content'],
      contractModelId: json['contract_model_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'action_date': actionDate,
      'contract_end_date': contractEndDate,
      'contract_start_date': contractStartDate,
      'contract_content': contractContent,
      'contract_applicant': _getContractApplicant(contractApplicant),
      'property_owner': _getPropertyOwner(propertyOwner),
      'lessor_date_birth': lessorDateBirth,
      'lessor_full_name': lessorFullName,
      'lessor_identity_num': "\"$lessorIdentityNum\"",
      'lessor_identity_type': _getLessorIdentityType(lessorIdentityType),
      'lessor_nationality': lessorNationality,
      'lessor_phone': lessorPhone,
      'lessor_address': lessorAddress,
      'lessor_iban': lessorIban,
      'lessor_royal_deed_type': _getLessorRoyalDeedType(lessorRoyalDeedType),
      'lessor_royal_deed_number': lessorRoyalDeedNumber,
      'tenant_date_birth': tenantDateBirth,
      'tenant_full_name': tenantFullName,
      'tenant_identity_num': tenantIdentityNum,
      'tenant_identity_type': _getLessorIdentityType(tenantIdentityType),
      'tenant_nationality': tenantNationality,
      'tenant_phone': tenantPhone,
      'tenant_address': tenantAddress,
      'facility_name': tenantOrgName,
      'tenant_type': _getTenantType(tenantType),
      'unified_number': tenantOrgNumber,
      'commercial_record_date': recordDate,
      'record_file': recordFile,
      'record_number': recordNumber,
      'office_additional_no': officeAdditionalNo,
      'office_building_no': officeBuildingNo,
      'office_address': officeAddress ?? _getAddress(),
      'office_city': officeCity,
      'office_neighborhood': officeNeighborhood,
      'office_latitude': officeLatitude,
      'office_longitude': officeLongitude,
      'office_street': officeStreet,
      'office_postal_code': officePostalCode,
      'office_name': officeName,
      'office_unit_no': officeUnitNo,
      'office_no_floor': officeNoFloor,
      'office_type_aqar': officeTypeAqar,
      'office_category_aqar': officeCategoryAqar,
      'office_space': officeSpace,
      'office_length_front_end': officeLengthFrontEnd,
      'office_is_mushtab': _getOfficeIsMushtab(officeIsMushtab),
      'no_central_conditioners': conditionsType == ConditionsType.central ? conditionsCount : 0,
      'no_window_conditioners': conditionsType == ConditionsType.window ? conditionsCount : 0,
      'no_split_conditioners': conditionsType == ConditionsType.split ? conditionsCount : 0,
      'water_const_amount': waterType == WaterElectricityType.sameWithCounter ? 0 : 1,
      'water_money': waterType == WaterElectricityType.amount ? waterConstAmount : null,
      'electricity_const_amount': electricityType == WaterElectricityType.sameWithCounter ? 0 : 1,
      'electricity_money': electricityType == WaterElectricityType.amount ? electricityConstAmount : null,
      'rent_payment_cycle': _getPaymentCycle(rentPaymentCycle),
      'duration_days_open_contract': durationDaysOpenContract,
      'duration_days_cancel_contract': durationDaysCancelContract,
      'notes': notes,
      'id_type_reservation': _getTypeReservation(idTypeReservation),
      'down_payment': downPayment,
      'insurance_amount': insuranceAmount,
      'total_price': totalPrice,
      'contract_model_id': contractModelId,
      'order_id': order?.id.toString(),
      'required_approve': (mustAccept??false) ? 2 : 1,

      // 'lessor_id': ,
      // 'facility_type': ,
      // 'facility_name': ,
      // 'unified_number': ,
      // 'commercial_record_date': ,
    };
  }

  String? _getAddress() {
    if (officeCity != null && officeNeighborhood != null && officeStreet != null) {
      return '${officeCity!}, ${officeNeighborhood!}, ${officeStreet!}';
    }
    if (officeCity != null && officeNeighborhood != null) return '${officeCity!}, ${officeNeighborhood!}';
    if (officeCity != null) return officeCity!;
    return null;
  }

  String? _getOfficeIsMushtab(YesOrNoType? officeIsMushtab) {
    switch (officeIsMushtab) {
      case null:
        return '1';
      case YesOrNoType.yes:
        return '1';
      case YesOrNoType.no:
        return '0';
    }
  }

  String? _getLessorRoyalDeedType(LessorRoyalDeedType? lessorRoyalDeedType) {
    switch (lessorRoyalDeedType) {
      case null:
        return "Nothing";
      case LessorRoyalDeedType.electronic:
        return "Electronic";
      case LessorRoyalDeedType.bank:
        return "Bank";
      case LessorRoyalDeedType.paper:
        return "Paper";
      case LessorRoyalDeedType.nothing:
        return "Nothing";
    }
  }

  String? _getLessorIdentityType(IdentityType? lessorIdentityType) {
    switch (lessorIdentityType) {
      case null:
        return null;
      case IdentityType.national:
        return "National";
      case IdentityType.residence:
        return "Residence";
    }
  }

  String? _getPropertyOwner(PropertyOwnerType? propertyOwner) {
    switch (propertyOwner) {
      case null:
        return null;
      case PropertyOwnerType.owner:
        return "Owner";
      case PropertyOwnerType.agent:
        return "Agent";
    }
  }

  String? _getContractApplicant(ContractApplicantType? contractApplicant) {
    switch (contractApplicant) {
      case ContractApplicantType.lessor:
        return "Lessor";
      case ContractApplicantType.tenant:
        return "Tenant";
      default:
        return null;
    }
  }

  // 'Monthly','Quarterly Yearly','Mid Yearly','Yearly'
  String? _getPaymentCycle(PaymentCycleType? rentPaymentCycle) {
    switch (rentPaymentCycle) {
      case PaymentCycleType.monthly:
        return 'Monthly';
      case PaymentCycleType.quarterlyYearly:
        return 'Quarterly Yearly';
      case PaymentCycleType.midYearly:
        return 'Mid Yearly';
      case PaymentCycleType.yearly:
        return 'Yearly';
      default:
        return 'Monthly';
    }
  }

  String? _getTypeReservation(TypeReservationType? typeReservationType) {
    switch (typeReservationType) {
      case TypeReservationType.monthly:
        return "3";
      case TypeReservationType.yearly:
        return "4";
      default:
        return "3";
    }
  }

  // individual,facility
  String? _getTenantType(TenantType? tenantType) {
    switch (tenantType) {
      case TenantType.organisation:
        return "facility";
      case TenantType.personally:
        return "individual";
      default:
        return "individual";
    }
  }

// var data = FormData.fromMap({
//   // 'files': [
//   //   await MultipartFile.fromFile('/C:/Users/Mohammad/Desktop/صورة واتساب بتاريخ 1445-08-10 في 23.45.56_7c9d818a.jpg', filename: '/C:/Users/Mohammad/Desktop/صورة واتساب بتاريخ 1445-08-10 في 23.45.56_7c9d818a.jpg')
//   // ],
//   'status': '1',
//   'action_date': '2024-2-14 16:11:31',
//   'contract_start_date': '2024-2-14 16:11:31',
//   'contract_end_date': '2024-4-14 16:11:31',
//   'contract_content': 'content',
//   'contract_applicant': 'Lessor',
//   'property_owner': 'Owner',
//   'lessor_date_birth': '1975-4-14',
//   'lessor_full_name': 'Mohammad Ali',
//   'lessor_identity_num': '123456789',
//   'lessor_identity_type': 'National',
//   'lessor_nationality': 'Saudian',
//   'lessor_phone': '0512345678',
//   'lessor_address': 'Saudi Arabia - Riyadh',
//   'lessor_iban': '12345678912345',
//   'lessor_royal_deed_type': 'Electronic',
//   'lessor_royal_deed_number': '12345678',
//   'tenant_date_birth': '1965-4-14',
//   'tenant_full_name': 'Ali Mohammad',
//   'tenant_identity_num': 'tenant_identity_type',
//   'tenant_identity_type': 'Residence',
//   'tenant_nationality': 'Syrian',
//   'tenant_phone': '0587654321',
//   'tenant_address': 'Saudi Arabia - Riyadh',
//   'office_additional_no': '121212',
//   'office_building_no': '10',
//   'office_address': 'Saudi Arabia - Riyadh',
//   'office_city': 'Riyadh',
//   'office_neighborhood': 'Riyadh',
//   'office_street': 'Riyadh',
//   'office_postal_code': '+966',
//   'office_name': 'Office 1',
//   'office_unit_no': '1',
//   'office_no_floor': '1',
//   'office_type_aqar': 'تجاري وسكني',
//   'office_category_aqar': 'مكتب مؤثث',
//   'office_space': '222',
//   'office_length_front_end': '100',
//   'office_is_mushtab': '1',
//   'record_number': '1111111',
//   'no_central_conditioners': '1',
//   'no_window_conditioners': '0',
//   'no_split_conditioners': '1',
//   'water_const_amount': '1',
//   'electricity_const_amount': '1',
//   'rent_payment_cycle': 'Monthly',
//   'duration_days_open_contract': '1',
//   'duration_days_cancel_contract': '2',
//   'down_payment': '200',
//   'insurance_amount': '100',
//   'total_price': '30000',
//   'id_type_reservation': '3',
//   'order_id': '1',
//   'office_latitude': '36.5222',
//   'office_longitude': '36.5222'
// });

// water_money, electricity_money, notes, contract_model_id
// Map<String, dynamic> toJson() {
//   return {
//     'property_owner': propertyOwner,
//     'contract_applicant': contractApplicant,
//     'lessor_royal_deed_type': lessorRoyalDeedType,
//     'lessor_royal_deed_number': lessorRoyalDeedNumber,
//     'lessor_full_name': lessorFullName,
//     'lessor_identity_num': lessorIdentityNum,
//     'lessor_identity_type': lessorIdentityType,
//     'lessor_nationality': lessorNationality,
//     'lessor_phone': lessorPhone,
//     'lessor_address': lessorAddress,
//     'lessor_date_birth': lessorDateBirth,
//     'lessor_iban': lessorIban,
//     'tenant_full_name': tenantFullName,
//     'tenant_identity_num': tenantIdentityNum,
//     'tenant_identity_type': tenantIdentityType,
//     'tenant_nationality': tenantNationality,
//     'tenant_phone': tenantPhone,
//     'tenant_address': tenantAddress,
//     'tenant_date_birth': tenantDateBirth,
//     'record_number': recordNumber,
//     'office_name': officeName,
//     'office_category_aqar': officeCategoryAqar,
//     'office_type_aqar': officeTypeAqar,
//     'office_city': officeCity,
//     'office_address': officeAddress,
//     'office_neighborhood': officeNeighborhood,
//     'office_street': officeStreet,
//     'office_postal_code': officePostalCode,
//     'office_additional_no': officeAdditionalNo,
//     'office_building_no': officeBuildingNo,
//     'office_unit_no': officeUnitNo,
//     'office_space': officeSpace,
//     'office_length_front_end': officeLengthFrontEnd,
//     'office_is_mushtab': officeIsMushtab,
//     'office_no_floor': officeNoFloor,
//     'rent_payment_cycle': rentPaymentCycle,
//     'id_type_reservation': idTypeReservation,
//     'action_date': actionDate,
//     'contract_start_date': contractStartDate,
//     'contract_end_date': contractEndDate,
//     'duration_days_open_contract': durationDaysOpenContract,
//     'duration_days_cancel_contract': durationDaysCancelContract,
//     'notes': notes,
//     'water_const_amount': waterConstAmount,
//     'electricity_const_amount': electricityConstAmount,
//     'office_latitude': officeLatitude,
//     'office_longitude': officeLongitude,
//     'down_payment': downPayment,
//     'insurance_amount': insuranceAmount,
//     'total_price': totalPrice,
//     'contract_content': contractContent,
//   };
// }

// water_money, electricity_money, notes, contract_model_id
// Map<String, dynamic> toJson() {
//   return {
//     'status': 1,
//     'action_date': actionDate,
//     'contract_start_date': contractStartDate,
//     'contract_end_date': contractEndDate,
//     'contract_content': contractContent,
//     'contract_applicant': contractApplicant,
//     'property_owner': propertyOwner,
//     'lessor_date_birth': lessorDateBirth,
//     'lessor_full_name': lessorFullName,
//     'lessor_identity_num': lessorIdentityNum,
//     'lessor_identity_type': lessorIdentityType,
//     'lessor_nationality': lessorNationality,
//     'lessor_phone': lessorPhone,
//     'lessor_address': lessorAddress,
//     'lessor_iban': lessorIban,
//     'lessor_royal_deed_type': lessorRoyalDeedType,
//     'lessor_royal_deed_number': lessorRoyalDeedNumber,
//     'tenant_date_birth': tenantDateBirth,
//     'tenant_full_name': tenantFullName,
//     'tenant_identity_num': tenantIdentityNum,
//     'tenant_identity_type': tenantIdentityType,
//     'tenant_nationality': tenantNationality,
//     'tenant_phone': tenantPhone,
//     'tenant_address': tenantAddress,
//     'office_additional_no': officeAdditionalNo,
//     'office_building_no': officeBuildingNo,
//     'office_address': officeAddress,
//     'office_city': officeCity,
//     'office_neighborhood': officeNeighborhood,
//     'office_street': officeStreet,
//     'office_postal_code': officePostalCode,
//     'office_name': officeName,
//     'office_unit_no': officeUnitNo,
//     'office_no_floor': officeNoFloor,
//     'office_type_aqar': officeTypeAqar,
//     'office_category_aqar': officeCategoryAqar,
//     'office_space': officeSpace,
//     'office_length_front_end': officeLengthFrontEnd,
//     'office_is_mushtab': officeIsMushtab,
//     'record_number': recordNumber,
//     'no_central_conditioners': conditionsType == ConditionsType.central ? conditionsCount : 0,
//     'no_window_conditioners': conditionsType == ConditionsType.window ? conditionsCount : 0,
//     'no_split_conditioners': conditionsType == ConditionsType.split ? conditionsCount : 0,
//     'water_const_amount': waterConstAmount,
//     'electricity_const_amount': electricityConstAmount,
//     'rent_payment_cycle': rentPaymentCycle,
//     'duration_days_open_contract': durationDaysOpenContract,
//     'duration_days_cancel_contract': durationDaysCancelContract,
//     'down_payment': downPayment,
//     'insurance_amount': insuranceAmount,
//     'total_price': totalPrice,
//     'id_type_reservation': idTypeReservation,
//     'order_id': orderId,
//     'office_latitude': officeLatitude,
//     'office_longitude': officeLongitude,
//     'notes': notes,
//     // 'contract_model_id': contractModelId
//   };
// }
}

/*
    'status'
    'action_date'
    'contract_end_date'
    'contract_start_date'
    'contract_number'
    'contract_type'
    'contract_content'
    'contract_applicant'
    'property_owner'

    'lessor_date_birth'
    'lessor_full_name'
    'lessor_identity_num'
    'lessor_identity_type'
    'lessor_nationality'
    'lessor_phone'
    'lessor_address'
    'lessor_iban'
    'lessor_royal_deed_type'
    'lessor_royal_deed_number'

    'tenant_date_birth'
    'tenant_full_name'
    'tenant_identity_num'
    'tenant_identity_type'
    'tenant_nationality'
    'tenant_phone'
    'tenant_address'

    'office_additional_no'
    'office_building_no'
    'office_address'
    'office_city'
    'office_neighborhood'
    'office_latitude'
    'office_longitude'
    'office_street'
    'office_postal_code'
    'office_name'
    'office_unit_no'
    'office_no_floor'
    'office_type_aqar'
    'office_category_aqar'
    'office_space'
    'office_length_front_end'
    'office_is_mushtab'
    'facility_type'
    'facility_name'
    'unified_number'

    'record_file'
    'record_number'
    'commercial_record_date'

    'no_central_conditioners'
    'no_window_conditioners'
    'no_split_conditioners'

    'water_const_amount'
    'water_money'
    'electricity_const_amount'
    'electricity_money'

    'rent_payment_cycle'
    'duration_days_open_contract'
    'duration_days_cancel_contract'
    'notes'

    'type_reservation'
    'down_payment'
    'insurance_amount'
    'total_price'
    'lessor_id'
    'contract_model_id'
 **/
/*
property_owner: Owner
contract_applicant: Lessor
lessor_royal_deed_type: Paper
lessor_royal_deed_number: 665
lessor_full_name: شين شان
lessor_identity_num: 3424324
lessor_identity_type: National
lessor_nationality: صيني
lessor_phone: 32432534234
lessor_address: شينغهاي
lessor_date_birth: 2024-05-16
lessor_iban: 5464446465465465646484
tenant_full_name: سوشي
tenant_identity_num: 3424324
tenant_identity_type: National
tenant_nationality: ياباني
tenant_phone: 32423423432
tenant_address: كيوتو
tenant_date_birth: 2024-06-24
record_number: 000000000000
office_name: عقار الرياض
office_category_aqar: غير مجهز
office_type_aqar: تجاري
office_city: الرياض
office_address: السعودية
office_neighborhood: الملك عبد العزيز
office_street: غازي بن عبدالرحمن القصيبي
office_postal_code: 10000
office_additional_no: 1
office_building_no: undefined
office_unit_no: undefined
office_space: 100
office_length_front_end: 100
office_is_mushtab: 1
office_no_floor: 1
rent_payment_cycle: Monthly
id_type_reservation: 3
action_date: 2024-06-12
contract_start_date: 2024-06-26
contract_end_date: 2024-07-05
duration_days_open_contract: 1
duration_days_cancel_contract: 1
notes: undefined
water_const_amount: 0
electricity_const_amount: 0
office_latitude: 24.726192770494045
office_longitude: 46.70785989615991
down_payment: 5
insurance_amount: 5
total_price: 5
contract_content: <p>شروط التاجير لايمكن استرداد المبلغ بعد الدفع</p><p><br></p><p><br></p><p><br></p><p><br></p>
 */
/*
{
  "property_owner": "Owner",
  "contract_applicant": "Lessor",
  "lessor_royal_deed_type": "Paper",
  "lessor_royal_deed_number": "665",
  "lessor_full_name": "شين شان",
  "lessor_identity_num": "3424324",
  "lessor_identity_type": "National",
  "lessor_nationality": "صيني",
  "lessor_phone": "32432534234",
  "lessor_address": "شينغهاي",
  "lessor_date_birth": "2024-05-16",
  "lessor_iban": "5464446465465465646484",
  "tenant_full_name": "سوشي",
  "tenant_identity_num": "3424324",
  "tenant_identity_type": "National",
  "tenant_nationality": "ياباني",
  "tenant_phone": "32423423432",
  "tenant_address": "كيوتو",
  "tenant_date_birth": "2024-06-24",
  "record_number": "000000000000",
  "order_id": "60",
  "office_name": "مكتب رشيد",
  "office_category_aqar": "مكتب مؤثث",
  "office_type_aqar": "تجاري وسكني",
  "office_city": "الرياض",
  "office_address": "السعودية",
  "office_neighborhood": "العليا",
  "office_street": "المهندس مساعد العنقري",
  "office_postal_code": "10000",
  "office_additional_no": "1",
  "office_building_no": "55",
  "office_unit_no": "3",
  "office_space": "200.00",
  "office_length_front_end": "100",
  "office_is_mushtab": "1",
  "office_no_floor": "1",
  "rent_payment_cycle": "Monthly",
  "id_type_reservation": "3",
  "action_date": "2024-06-12",
  "contract_start_date": "2024-06-12",
  "contract_end_date": "2025-06-05",
  "duration_days_open_contract": "1",
  "duration_days_cancel_contract": "1",
  "notes": "ملاحظات إضافية",
  "water_const_amount": "0",
  "electricity_const_amount": "0",
  "office_latitude": "24.711472912693",
  "office_longitude": "46.684319286565",
  "down_payment": "19.00",
  "insurance_amount": "5",
  "total_price": "6900",
  "contract_content": "s"
}
 */
/*
Sure, here are the converted terms in camelCase:

- propertyOwner
- contractApplicant
- lessorRoyalDeedType
- lessorRoyalDeedNumber
- lessorFullName
- lessorIdentityNum
- lessorIdentityType
- lessorNationality
- lessorPhone
- lessorAddress
- lessorDateBirth
- lessorIban
- tenantFullName
- tenantIdentityNum
- tenantIdentityType
- tenantNationality
- tenantPhone
- tenantAddress
- tenantDateBirth
- recordNumber
- orderId
- officeName
- officeCategoryAqar
- officeTypeAqar
- officeCity
- officeAddress
- officeNeighborhood
- officeStreet
- officePostalCode
- officeAdditionalNo
- officeBuildingNo
- officeUnitNo
- officeSpace
- officeLengthFrontEnd
- officeIsMushtab
- officeNoFloor
- rentPaymentCycle
- idTypeReservation
- actionDate
- contractStartDate
- contractEndDate
- durationDaysOpenContract
- durationDaysCancelContract
- notes
- waterConstAmount
- electricityConstAmount
- officeLatitude
- officeLongitude
- downPayment
- insuranceAmount
- totalPrice
- contractContent
 */

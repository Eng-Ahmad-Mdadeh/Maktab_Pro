import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maktab_lessor/core/services/service_locator.dart';
import 'package:maktab_lessor/data/repositories/order_repository.dart';

import '../../../../presentation/contracts_menu/screens/contracts/screens/contract/screens/add/widgets/step2/additional_info_widget.dart';
import '../../../../presentation/contracts_menu/screens/contracts/screens/contract/screens/add/widgets/step2/order_info_widget.dart';
import '../../../../presentation/widgets/maktab_snack_bar.dart';
import "../../../../core/extension/date_time_extension.dart";
import '../../../../data/models/contract/contract_model_model.dart';
import '../../../../data/models/order/order_model.dart';
import '../../contracts_step_cubit.dart';
import 'contract_state.dart';

class ContractCubit extends Cubit<ContractEntity> {
  late final PageController _controller;

  ContractCubit(ContractStepCubit contractStepCubit, this._order) : super(ContractEntity.empty()) {
    _controller = PageController(initialPage: 0)
      ..addListener(() {
        final i = _controller.page?.round() ?? 0;
        contractStepCubit.changeStep(i + 1);
        // if(i == 1){
        //   log("GetOrdersWithoutPaginationEvent: $i");
        //   locator<OrdersBloc>().add(GetOrdersWithoutPaginationEvent());
        // }
      });
  }

  final GlobalKey<FormState> step1Key = GlobalKey<FormState>();
  final GlobalKey<FormState> step2Key = GlobalKey<FormState>();
  final GlobalKey<FormState> step3Key = GlobalKey<FormState>();
  final GlobalKey<FormState> step4Key = GlobalKey<FormState>();

  late LatLng _position;

  final OrderModel? _order;

  OrderModel? get order => _order;

  PageController get pageController => _controller;
  bool _step1Completed = false;

  bool get step1Completed => _step1Completed;
  bool _step2Completed = false;

  bool get step2Completed => _step2Completed;
  bool _step3Completed = false;

  bool get step3Completed => _step3Completed;

  List<String?> get _step1 => [
        state.lessorFullName,
        state.lessorIdentityNum,
        state.lessorNationality,
        state.lessorPhone,
        state.lessorAddress,
        state.lessorDateBirth,
        state.lessorIban,
        state.tenantFullName,
        state.tenantIdentityNum,
        state.tenantNationality,
        state.tenantPhone,
        state.tenantAddress,
        state.tenantDateBirth,
      ];

  List<String?> get _step2 => [
        state.officeName,
        state.officeCategoryAqar,
        state.officeTypeAqar,
        state.officeCity,
        state.officeAddress,
        state.officeNeighborhood,
        state.officeStreet,
        state.officeSpace,
        state.officeLengthFrontEnd,
        state.officeNoFloor,
        state.actionDate,
        state.contractStartDate,
        state.contractEndDate,
        state.durationDaysOpenContract,
        state.durationDaysCancelContract,
        state.electricityConstAmount,
      ];

  List<String?> get _step3 => [
        state.downPayment,
        state.insuranceAmount,
        state.totalPrice,
      ];

  Future<bool> nextPage(int i, BuildContext context) async {
    if (i == 3) {
      final step1Validator = _step1.every((e) => (e ?? '').isEmpty);
      _step1Completed = step1Validator;
      if (step1Validator) {
        animateToPage(0);
        MaktabSnackbar.showWarning(context, "يجب تعبئة جميع الحقول الاجباري");
        return false;
      }
      final step2Validator = _step2.every((e) => (e ?? '').isEmpty);
      _step2Completed = step2Validator;
      if (step2Validator) {
        animateToPage(1);
        MaktabSnackbar.showWarning(context, "يجب تعبئة جميع الحقول الاجباري");
        return false;
      }
      if ((state.isConditions ?? false)) {
        if ((state.conditionsCount ?? '').isEmpty) {
          animateToPage(1);
          MaktabSnackbar.showWarning(context, "اذا كان هناك مكيفات يجب تحديد عددهم");
        }
      }

      final step3Validator = _step3.every((e) => (e ?? '').isEmpty);
      _step3Completed = step3Validator;
      if (step3Validator) {
        animateToPage(2);
        MaktabSnackbar.showWarning(context, "يجب تعبئة جميع الحقول الاجباري");
        return false;
      }
      if (state.propertyOwner == null) {
        animateToPage(0);
        MaktabSnackbar.showWarning(context, "يجب تحديد ما اذا كنت المالك او الوكيل");
        return false;
      }
      if (state.contractApplicant == null) {
        animateToPage(0);
        MaktabSnackbar.showWarning(context, "يجب تحديد ما اذا كنت المؤجر او المستأجر");
        return false;
      }
      if (state.lessorIdentityType == null) {
        animateToPage(0);
        MaktabSnackbar.showWarning(context, "يجب تحديد نوع هوية المؤجر");
        return false;
      }
      if (state.tenantIdentityType == null) {
        animateToPage(0);
        MaktabSnackbar.showWarning(context, "يجب تحديد نوع هوية المستأجر");
        return false;
      }
      final content = _quillController.document.toPlainText();
      emit(state.copyWith(contractContent: content));

      log("HERE THE STATE: ");
      for (int i = 0; i < _step1.length; i++) {
        if (_step1[i] == null) {
          log("_step1 INDEX($i) is ${_step1[i]}");
        }
      }
      for (int i = 0; i < _step2.length; i++) {
        if (_step2[i] == null) {
          log("_step2 INDEX($i) is ${_step2[i]}");
        }
      }
      for (int i = 0; i < _step3.length; i++) {
        if (_step3[i] == null) {
          log("_step3 INDEX($i) is ${_step3[i]}");
        }
      }
      log("DEED NUMBER: ");
      log(state.toJson().toString());
      return true;
    }
    if ([step1Key, step2Key, step3Key, step4Key][i].currentState!.validate()) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
    return false;
  }

  void previousPage() {
    _controller.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  Future<void> animateToPage(int i) async {
    return await _controller.animateToPage(
      i,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  Future<void> onContractCameraIdle() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(_position.latitude, _position.longitude);
    String placeName = placemarks[0].locality ?? '';
    log("CITY");
    log(placeName);
    log("placemarks");
    log(placemarks[0].toString());

    officeCity.text = placemarks[0].locality ?? '';
    officeNeighborhood.text = placemarks[0].subLocality ?? '';
    officeStreet.text = placemarks[0].thoroughfare ?? '';

    emit(state.copyWith(
      officeCity: placemarks[0].locality,
      officeNeighborhood: placemarks[0].subLocality,
      officeStreet: placemarks[0].thoroughfare,
      officeLatitude: _position.latitude.toString(),
      officeLongitude: _position.longitude.toString(),
    ));
  }

  void onContractMapCreated(GoogleMapController controller) {
    _position = const LatLng(24.7113719, 46.6744867);
  }

  void onContractCameraMove(CameraPosition position) {
    _position = position.target;
  }

  /// ContractStep1
  /// BaseInfoWidget
  void setpropertyOwner(PropertyOwnerType? value) => emit(state.copyWith(propertyOwner: value));

  void setcontractApplicant(ContractApplicantType? value) => emit(state.copyWith(contractApplicant: value));

  void setlessorRoyalDeedType(LessorRoyalDeedType? value) => emit(state.copyWith(lessorRoyalDeedType: value));

  void setlessorRoyalDeedNumber(String? value) => emit(state.copyWith(lessorRoyalDeedNumber: value));
  final TextEditingController lessorRoyalDeedNumber = TextEditingController();

  /// LessorInfoWidget
  void setlessorFullName(String? value) => emit(state.copyWith(lessorFullName: value));
  final TextEditingController lessorFullName = TextEditingController();

  void setlessorIdentityNum(String? value) => emit(state.copyWith(lessorIdentityNum: value));
  final TextEditingController lessorIdentityNum = TextEditingController();

  void setlessorIdentityType(IdentityType? value) => emit(state.copyWith(lessorIdentityType: value));
  final TextEditingController lessorIdentityType = TextEditingController();

  void setlessorNationality(String? value) => emit(state.copyWith(lessorNationality: value));
  final TextEditingController lessorNationality = TextEditingController();

  void setlessorPhone(String? value) => emit(state.copyWith(lessorPhone: value));
  final TextEditingController lessorPhone = TextEditingController();

  void setlessorAddress(String? value) => emit(state.copyWith(lessorAddress: value));
  final TextEditingController lessorAddress = TextEditingController();

  void setlessorDateBirthDT(DateTime? value) {
    lessorDateBirth.text = value?.dayFormatWithLocale('ar') ?? '';
    emit(state.copyWith(lessorDateBirth: value.toString()));
  }

  void setlessorDateBirth(String? value) => emit(state.copyWith(lessorDateBirth: value));
  final TextEditingController lessorDateBirth = TextEditingController();

  void setlessorIban(String? value) => emit(state.copyWith(lessorIban: value));
  final TextEditingController lessorIban = TextEditingController();

  /// TenantInfoWidget
  void settenantFullName(String? value) => emit(state.copyWith(tenantFullName: value));
  final TextEditingController tenantFullName = TextEditingController();

  void settenantIdentityNum(String? value) => emit(state.copyWith(tenantIdentityNum: value));
  final TextEditingController tenantIdentityNum = TextEditingController();

  void settenantIdentityType(IdentityType? value) => emit(state.copyWith(tenantIdentityType: value));

  void settenantType(TenantType? value) => emit(state.copyWith(tenantType: value));
  final TextEditingController tenantIdentityType = TextEditingController();

  void settenantNationality(String? value) => emit(state.copyWith(tenantNationality: value));
  final TextEditingController tenantNationality = TextEditingController();

  void settenantOrgNumber(String? value) => emit(state.copyWith(tenantOrgNumber: value));
  final TextEditingController tenantOrgNumber = TextEditingController();

  void settenantOrgName(String? value) => emit(state.copyWith(tenantOrgName: value));
  final TextEditingController tenantOrgName = TextEditingController();

  void settenantOrgType(String? value) => emit(state.copyWith(tenantOrgType: value));
  final TextEditingController tenantOrgType = TextEditingController();

  void setrecordDateDT(DateTime? value) {
    recordDate.text = value?.dayFormatWithLocale('ar') ?? '';
    emit(state.copyWith(recordDate: value.toString()));
  }

  void setrecordDate(String? value) => emit(state.copyWith(recordDate: value));
  final TextEditingController recordDate = TextEditingController();

  void settenantPhone(String? value) => emit(state.copyWith(tenantPhone: value));
  final TextEditingController tenantPhone = TextEditingController();

  void settenantAddress(String? value) => emit(state.copyWith(tenantAddress: value));
  final TextEditingController tenantAddress = TextEditingController();

  void settenantDateBirthDT(DateTime? value) {
    tenantDateBirth.text = value?.dayFormatWithLocale('ar') ?? '';
    emit(state.copyWith(tenantDateBirth: value.toString()));
  }

  void settenantDateBirth(String? value) => emit(state.copyWith(tenantDateBirth: value));
  final TextEditingController tenantDateBirth = TextEditingController();

  void setrecordNumber(String? value) => emit(state.copyWith(recordNumber: value));
  final TextEditingController recordNumber = TextEditingController();

  void setrecordFile(String? value) => emit(state.copyWith(recordFile: value));

  /// ContractStep2
  /// OrderInfoWidget
  Future<void> setisOrderOn(bool? value, [int? orderId]) async {
    officeCity.clear();
    officeNeighborhood.clear();
    officeStreet.clear();
    if (orderId != null) {
      if ((value ?? false)) {
        final result = await locator<OrderRepository>().getOrdersWithoutPage();
        result.fold((l) {}, (orders) {
          final order = orders.firstWhereOrNull((e) => e.id == orderId);
          setorder(order);
        });
      }
    }
    emit(state
        .copyWith(
          isOrderOn: value,
        )
        .setNull(
          officeLatitude: true,
          officeLongitude: true,
          order: true,
        ));
  }

  void setmustAccept(bool? value) => emit(state.copyWith(mustAccept: value));

  void setorder(OrderModel? value) {
    officeName.text = value?.office?.title ?? '';
    // officeCategoryAqar.text = value?.office?.categoryAqar?.enName ?? '';
    // officeTypeAqar.text = value?.office?.typeAqar?.enName ?? '';
    officeCity.text = value?.office?.location?.city ?? '';
    officeNeighborhood.text = value?.office?.location?.neighborhood ?? '';

    officeStreet.text = value?.office?.location?.street ?? '';
    officeSpace.text = value?.office?.space?.toString() ?? '';
    totalPrice.text = value?.totalPriceTenant?.toString() ?? '';
    downPayment.text = value?.office?.downPayment?.toString() ?? '';

    emit(
      state.copyWith(
        order: value,
        officeName: value?.office?.title,
        officeCategoryAqar: value?.office?.categoryAqar?.enName,
        officeTypeAqar: value?.office?.typeAqar?.enName,
        officeCity: value?.office?.location?.city,
        officeNeighborhood: value?.office?.location?.neighborhood,
        officeStreet: value?.office?.location?.street,
        officeSpace: value?.office?.space?.toString(),
        totalPrice: value?.totalPriceTenant?.toString(),
        downPayment: value?.office?.downPayment?.toString(),
      ),
    );
  }

  void setorderId(OrderModel? value) => emit(state.copyWith(order: value));

  void setofficeName(String? value) => emit(state.copyWith(officeName: value));
  final TextEditingController officeName = TextEditingController();

  void setofficeCategoryAqar(String? value) => emit(state.copyWith(officeCategoryAqar: value));
  final TextEditingController officeCategoryAqar = TextEditingController();

  void setofficeTypeAqar(String? value) => emit(state.copyWith(officeTypeAqar: value));
  final TextEditingController officeTypeAqar = TextEditingController();

  void setofficeCity(String? value) => emit(state.copyWith(officeCity: value));
  final TextEditingController officeCity = TextEditingController();

  void setofficeAddress(String? value) => emit(state.copyWith(officeAddress: value));
  final TextEditingController officeAddress = TextEditingController();

  void setofficeNeighborhood(String? value) => emit(state.copyWith(officeNeighborhood: value));
  final TextEditingController officeNeighborhood = TextEditingController();

  void setofficeStreet(String? value) => emit(state.copyWith(officeStreet: value));
  final TextEditingController officeStreet = TextEditingController();

  void setofficePostalCode(String? value) => emit(state.copyWith(officePostalCode: value));
  final TextEditingController officePostalCode = TextEditingController();

  void setofficeAdditionalNo(String? value) => emit(state.copyWith(officeAdditionalNo: value));
  final TextEditingController officeAdditionalNo = TextEditingController();

  void setofficeBuildingNo(String? value) => emit(state.copyWith(officeBuildingNo: value));
  final TextEditingController officeBuildingNo = TextEditingController();

  void setofficeUnitNo(String? value) => emit(state.copyWith(officeUnitNo: value));
  final TextEditingController officeUnitNo = TextEditingController();

  void setofficeSpace(String? value) => emit(state.copyWith(officeSpace: value));
  final TextEditingController officeSpace = TextEditingController();

  void setofficeLengthFrontEnd(String? value) => emit(state.copyWith(officeLengthFrontEnd: value));
  final TextEditingController officeLengthFrontEnd = TextEditingController();

  void setofficeIsMushtab(YesOrNoType? value) => emit(state.copyWith(officeIsMushtab: value));
  final TextEditingController officeIsMushtab = TextEditingController();

  void setofficeNoFloor(String? value) => emit(state.copyWith(officeNoFloor: value));
  final TextEditingController officeNoFloor = TextEditingController();

  /// AdditionalInfoWidget
  void setisConditions(bool? value) => emit(state.copyWith(isConditions: value));

  void setconditionsCount(String? value) => emit(state.copyWith(conditionsCount: value));
  final TextEditingController conditionsCount = TextEditingController();

  void setconditionsType(ConditionsType? value) => emit(state.copyWith(conditionsType: value));

  void setrentPaymentCycle(PaymentCycleType? value) => emit(state.copyWith(rentPaymentCycle: value));

  void setidTypeReservation(TypeReservationType? value) => emit(state.copyWith(idTypeReservation: value));

  void setactionDate(String? value) => emit(state.copyWith(actionDate: value));

  void setactionDateDT(DateTime? value) {
    actionDate.text = value?.dayFormatWithLocale('ar') ?? '';
    emit(state.copyWith(actionDate: value.toString()));
  }

  final TextEditingController actionDate = TextEditingController();

  void setcontractStartDate(String? value) => emit(state.copyWith(contractStartDate: value));

  void setcontractStartDateDT(DateTime? value) {
    contractStartDate.text = value?.dayFormatWithLocale('ar') ?? '';
    emit(state.copyWith(contractStartDate: value.toString()));
  }

  final TextEditingController contractStartDate = TextEditingController();

  void setcontractEndDate(String? value) => emit(state.copyWith(contractEndDate: value));

  void setcontractEndDateDT(DateTime? value) {
    contractEndDate.text = value?.dayFormatWithLocale('ar') ?? '';
    emit(state.copyWith(contractEndDate: value.toString()));
  }

  final TextEditingController contractEndDate = TextEditingController();

  void setdurationDaysOpenContract(String? value) => emit(state.copyWith(durationDaysOpenContract: value));
  final TextEditingController durationDaysOpenContract = TextEditingController();

  void setdurationDaysCancelContract(String? value) => emit(state.copyWith(durationDaysCancelContract: value));
  final TextEditingController durationDaysCancelContract = TextEditingController();

  void setnotes(String? value) => emit(state.copyWith(notes: value));
  final TextEditingController notes = TextEditingController();

  void setwaterConstAmount(String? value) => emit(state.copyWith(waterConstAmount: int.tryParse(value ?? '0')));
  final TextEditingController waterConstAmount = TextEditingController();

  void setwaterType(WaterElectricityType? value) => emit(state.copyWith(waterType: value));

  void setelectricityConstAmount(String? value) => emit(state.copyWith(electricityConstAmount: value));
  final TextEditingController electricityConstAmount = TextEditingController();

  void setelectricityType(WaterElectricityType? value) => emit(state.copyWith(electricityType: value));

  void setofficeLatitude(String? value) => emit(state.copyWith(officeLatitude: value));
  final TextEditingController officeLatitude = TextEditingController();

  void setofficeLongitude(String? value) => emit(state.copyWith(officeLongitude: value));
  final TextEditingController officeLongitude = TextEditingController();

  void setdownPayment(String? value) => emit(state.copyWith(downPayment: value));
  final TextEditingController downPayment = TextEditingController();

  void setinsuranceAmount(String? value) => emit(state.copyWith(insuranceAmount: value));
  final TextEditingController insuranceAmount = TextEditingController();

  void settotalPrice(String? value) => emit(state.copyWith(totalPrice: value));
  final TextEditingController totalPrice = TextEditingController();

  void setcontractContent(ContractModelModel? value) {
    if (value?.contentContractModel != null) {
      _quillController.document.insert(0, value!.contentContractModel!);
    }
    emit(state.copyWith(contractContent: value?.contentContractModel));
    emit(state.copyWith(contractModelId: value?.id?.toString()));
  }

  void clearContractContent() {
    _quillController.document.insert(0, '');
    emit(state.copyWith(contractContent: '', contractModelId: ''));
  }

  final QuillController _quillController = QuillController(
    selection: TextSelection.fromPosition(
      const TextPosition(offset: 1),
    ),
    document: Document(),
  );

  QuillController get quillController => _quillController;

  String getName(dynamic type) {
    if (type == null) return "null";
    // select
    if (type is PropertyOwnerType) {
      switch (type) {
        case PropertyOwnerType.owner:
          return "المالك";
        case PropertyOwnerType.agent:
          return "الوكيل";
      }
    }
    if (type is ContractApplicantType) {
      switch (type) {
        case ContractApplicantType.lessor:
          return "المؤجر";
        case ContractApplicantType.tenant:
          return "المستأجر";
      }
    }
    if (type is LessorRoyalDeedType) {
      switch (type) {
        case LessorRoyalDeedType.electronic:
          return "إلكتروني";
        case LessorRoyalDeedType.bank:
          return "بنكي";
        case LessorRoyalDeedType.paper:
          return "ورقي";
        case LessorRoyalDeedType.nothing:
          return "لا شيء";
      }
    }
    if (type is IdentityType) {
      switch (type) {
        case IdentityType.national:
          return "هوية وطنية";
        case IdentityType.residence:
          return "هوية اقامة";
      }
    }

    // button group
    if (type is ConditionsType) {
      switch (type) {
        case ConditionsType.central:
          return "مركزي";
        case ConditionsType.window:
          return "شباك";
        case ConditionsType.split:
          return "إسبيلت";
      }
    }
    if (type is WaterElectricityType) {
      switch (type) {
        case WaterElectricityType.sameWithCounter:
          return "حسب قراءة العداد";
        case WaterElectricityType.amount:
          return "مبلغ ثابت";
      }
    }
    if (type is PaymentCycleType) {
      switch (type) {
        case PaymentCycleType.monthly:
          return "شهري";
        case PaymentCycleType.quarterlyYearly:
          return "ربع سنوي";
        case PaymentCycleType.midYearly:
          return "نصف سنوي";
        case PaymentCycleType.yearly:
          return "سنوي";
      }
    }
    if (type is TypeReservationType) {
      switch (type) {
        case TypeReservationType.monthly:
          return "شهري";
        case TypeReservationType.yearly:
          return "سنوي";
      }
    }
    if (type is YesOrNoType) {
      switch (type) {
        case YesOrNoType.yes:
          return "نعم";
        case YesOrNoType.no:
          return "لا";
      }
    }
    if (type is TenantType) {
      switch (type) {
        case TenantType.personally:
          return "فرد";
        case TenantType.organisation:
          return "منشأة";
      }
    }
    return "Unknown";
  }
}

// 	enum('Owner', 'Agent')
enum PropertyOwnerType { owner, agent }

// contract_applicant
// enum('Lessor', 'Tenant')
enum ContractApplicantType { lessor, tenant }

// lessor_royal_deed_type
// enum('Electronic', 'Bank', 'Paper', 'Nothing')
enum LessorRoyalDeedType { electronic, bank, paper, nothing }

// lessor_identity_type
// enum('National', 'Residence')
enum IdentityType { national, residence }

enum TenantType { personally, organisation }

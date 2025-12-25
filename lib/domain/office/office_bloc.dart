import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';
import 'package:maktab_lessor/core/helpers/file_picker_helper.dart';
import 'package:maktab_lessor/core/helpers/image_cropper_helper.dart';
import 'package:maktab_lessor/core/helpers/location_helper.dart';
import 'package:maktab_lessor/core/services/service_locator.dart';
import 'package:maktab_lessor/data/models/office/office_detail_model.dart';
import 'package:maktab_lessor/data/models/office/office_model.dart';
import 'package:maktab_lessor/data/models/office/office_price_model.dart';
import 'package:maktab_lessor/data/models/office/search_data_model.dart';
import 'package:maktab_lessor/data/repositories/map_repository.dart';
import 'package:maktab_lessor/data/repositories/office_repository.dart';
import 'package:flutter/material.dart';
import 'package:maktab_lessor/domain/unit/unit_bloc.dart' as unit;

part 'office_event.dart';

part 'office_state.dart';

class OfficeBloc extends Bloc<OfficeEvent, OfficeState> {
  List<int> facilities = [];
  List<int> features = [];
  List<int> services = [];
  Map<UniqueKey, GlobalKey<FormState>> additionalServiceKeys = {};
  Map<UniqueKey, Map<String, dynamic>> additionalServices = {};
  List<int> comforts = [];
  Position? currentPosition;
  List<UnitPriceOptions> selectedUnitPriceOptions = [];
  Map<UnitPriceOptions, num> selectedUnitPrices = {};
  String? selectedImage;
  String? croppedImage;
  Map<UniqueKey, String> imagesMap = {};
  String? selectedFile;
  final OfficeRepository _officeRepository;
  final MapRepository _mapRepository;

  OfficeBloc({required OfficeRepository officeRepository, required MapRepository mapRepository})
      : _officeRepository = officeRepository,
        _mapRepository = mapRepository,
        super(OfficeState(
            selectedImagesMap: {},
            selectedUnitPrices: {},
            selectedUnitPriceOptions: [],
            additionalServices: {},
            additionalServiceKeys: {},
            detailsMap: {'floor': 0, 'age': 1})) {
    on<InitialOfficeEvent>((event, emit) {
      if (event.searchData != null) {
        state.searchData = event.searchData;
      }
      if (event.office != null) {
        state.progressValue = 0;
        state.createdOffice = event.office;
        state.createdUnit = event.office!.units.firstWhereOrNull((unit) => unit.isCentral);
        state.marketingRequestState =
            (state.createdUnit?.isMarketing ?? false) ? VisibilityStates.show : VisibilityStates.hide;
        state.licenseOfficeState =
            !(state.createdUnit?.isMarketing ?? false) ? VisibilityStates.show : VisibilityStates.hide;
        log("-----------------------------------------------");
        log(state.marketingRequestState.toString());
        log(state.licenseOfficeState.toString());
        log(state.licenseNumber.toString());
        log(state.createdUnit?.isMarketing.toString() ?? '');
        log("-----------------------------------------------");
        // _toggleAddingLicenseOffice(emit);
        // _toggleAddingMarketingRequest(emit);
        state.name = state.createdUnit?.title ?? '';
        state.categoryId = state.createdUnit?.categoryId ?? 0;
        if ((state.createdUnit?.advertiserRelationship ?? '').isNotEmpty) {
          state.advertiserRelationshipOption = getAdvertiserRelationship(state.createdUnit!.advertiserRelationship!);
        }
        if ((state.createdUnit?.advertiserRelationshipType ?? '').isNotEmpty) {
          state.marketerTypeOption = getAdvertiserRelationshipType(state.createdUnit!.advertiserRelationshipType);
        }
        if (state.createdUnit?.space != null) {
          state.space = state.createdUnit!.space.toString();
        }
        if ((state.createdUnit?.furnisher ?? '').isNotEmpty) {
          state.equipment = state.createdUnit!.furnisher!;
        }
        if (state.createdUnit?.typeAqarId != null) {
          state.type = int.parse(state.createdUnit!.typeAqarId!);
        }
        for (OfficeDetail detail in (state.createdUnit?.details ?? [])) {
          state.detailsMap[detail.enName] = detail.numberDetails;
          switch (detail.enName) {
            case 'floor':
              state.floor = detail.numberDetails;
              break;
            case 'age':
              state.officeAge = detail.numberDetails;
              break;
            case 'officescount':
              state.officesCountSelectorState = ToggleStates.on;
              state.officesCount = detail.numberDetails;
              break;
            case 'meetingroomscount':
              state.meetingRoomsCountSelectorState = ToggleStates.on;
              state.meetingRoomsCount = detail.numberDetails;
              break;
            case 'tablescount':
              state.tablesCountSelectorState = ToggleStates.on;
              state.tablesCount = detail.numberDetails;
              break;
            case 'sharedworkspacescount':
              state.sharedWorkSpacesSelectorState = ToggleStates.on;
              state.sharedWorkSpaces = detail.numberDetails;
              break;
          }
        }
        state.facilities = state.createdUnit?.facilities.map((facility) => facility.id).toList() ?? [];
        if ((state.createdUnit?.description ?? '').isNotEmpty) {
          state.description = state.createdUnit!.description!;
        }
        state.features = state.createdUnit?.features.map((feature) => feature.id).toList() ?? [];
        state.comforts = state.createdUnit?.comforts.map((comfort) => comfort.id).toList() ?? [];
        if (state.createdOffice?.location != null) {
          state.addressPosition =
              LatLng(state.createdOffice!.location!.lat.toDouble(), state.createdOffice!.location!.lng.toDouble());
          state.city = state.createdOffice!.location!.city;
          state.neighborhood = state.createdOffice!.location!.neighborhood;
          state.street = state.createdOffice!.location!.street;
        }
        if (state.createdOffice?.interfaceId != null) {
          state.interfaceId = state.createdOffice!.interfaceId!;
        }
        for (OfficePrice price in (state.createdUnit?.prices ?? [])) {
          UnitPriceOptions? option;
          switch (price.typeResId) {
            case 1:
              option = UnitPriceOptions.hourly;
              break;
            case 2:
              option = UnitPriceOptions.daily;
              break;
            case 3:
              option = UnitPriceOptions.monthly;
              break;
            case 4:
              option = UnitPriceOptions.yearly;
              break;
          }
          state.selectedUnitPriceOptions.add(option!);
          state.selectedUnitPrices[option] = price.price;
        }
        if (state.createdUnit?.typeDownPayment != null && state.createdUnit?.downPayment != null) {
          state.depositAmount = state.createdUnit!.downPayment!;
          state.depositType = state.createdUnit?.typeDownPayment == 'rial'
              ? DepositTypes.price
              : state.createdUnit?.typeDownPayment == 'percent'
                  ? DepositTypes.percentage
                  : null;
        }
        if ((state.createdUnit?.viewerName ?? '').isNotEmpty && (state.createdUnit?.viewerPhone ?? '').isNotEmpty) {
          state.viewerName = state.createdUnit?.viewerName ?? '';
          state.viewerPhone = state.createdUnit?.viewerPhone ?? '';
        }
      }
      emit(state.copyWith(isInitialized: true));
    });
    on<InitialOfficeLocationEvent>((event, emit) {
      emit(state.copyWith(isInitialized: false));
      state.createdOffice = event.office;
      state.searchData = event.searchData;
      state.createdUnit = event.office.units.firstWhere((unit) => unit.isCentral);
      if (state.createdOffice!.location != null) {
        state.addressPosition =
            LatLng(state.createdOffice!.location!.lat.toDouble(), state.createdOffice!.location!.lng.toDouble());
        state.city = state.createdOffice!.location!.city;
        state.neighborhood = state.createdOffice!.location!.neighborhood;
        state.street = state.createdOffice!.location!.street;
      }
      if (state.createdOffice!.interfaceId != null) {
        state.interfaceId = state.createdOffice!.interfaceId!;
      }
      emit(state.copyWith(isInitialized: true));
    });
    on<AddLicensedOfficeEvent>((event, emit) {
      _toggleAddingLicenseOffice(emit);
    });
    on<SetLicenseNumberEvent>((event, emit) {
      state.licenseNumber = event.licenseNumber.length == 7 ? event.licenseNumber : '';
      emit(state.copyWith(isStepCompleted: checkIfOfficeTypeStepCompleted()));
    });
    on<AddMarketingRequestEvent>((event, emit) {
      _toggleAddingMarketingRequest(emit);
    });
    on<SetOfficeNameEvent>((event, emit) {
      state.name = event.name.length >= 4 ? event.name : '';
      emit(state.copyWith(isStepCompleted: checkIfOfficeFirstInfoStepCompleted()));
    });
    on<SelectCategoryEvent>((event, emit) {
      emit(state.copyWith(categoryId: event.id));
      emit(state.copyWith(isStepCompleted: checkIfOfficeFirstInfoStepCompleted()));
    });
    on<ToggleAccepingUserAgreementEvent>((event, emit) {
      emit(state.copyWith(acceptingUserAgreement: !state.acceptingUserAgreement));
      emit(state.copyWith(isStepCompleted: checkIfOfficeFirstInfoStepCompleted()));
    });
    on<SelectAdertiserRelationshipEvent>((event, emit) {
      emit(state.copyWith(
          advertiserRelationshipOption:
              event.option != state.advertiserRelationshipOption ? event.option : state.advertiserRelationshipOption));
      emit(state.copyWith(isStepCompleted: checkIfOfficeSecondStepCompleted()));
    });
    on<SelectMarketerTypeEvent>((event, emit) {
      emit(state.copyWith(
          marketerTypeOption: event.option != state.marketerTypeOption ? event.option : state.marketerTypeOption));
      emit(state.copyWith(isStepCompleted: checkIfOfficeSecondStepCompleted()));
    });
    on<SetSpaceEvent>((event, emit) {
      state.space = event.space.length <= 7 ? event.space : '';
      emit(state.copyWith(isStepCompleted: checkIfOfficeSecondStepCompleted()));
    });
    on<SetEquipmentEvent>((event, emit) {
      state.equipment = event.equipment ?? 'مؤثث';
      emit(state.copyWith(
        isStepCompleted: checkIfOfficeSecondStepCompleted(),
      ));
    });
    on<SetTypeEvent>((event, emit) {
      state.type = state.searchData!.officeTypes.firstWhere((type) => type.arName == event.type).id;
      emit(state.copyWith(isStepCompleted: checkIfOfficeSecondStepCompleted()));
    });
    on<IncreaseFloorEvent>((event, emit) {
      state.detailsMap['floor'] = ++event.floor;
      emit(state.copyWith(floor: state.detailsMap['floor']));
    });
    on<DecreaseFloorEvent>((event, emit) {
      int floor = 0;
      if (event.floor > 0) {
        floor = event.floor > 0 ? --event.floor : 0;
        state.detailsMap['floor'] = floor;
      }
      emit(state.copyWith(floor: floor));
    });
    on<IncreaseOfficeAgeEvent>((event, emit) {
      state.detailsMap['age'] = ++event.age;
      emit(state.copyWith(officeAge: state.detailsMap['age']));
    });
    on<DecreaseOfficeAgeEvent>((event, emit) {
      int age = 1;
      if (event.age > 1) {
        age = event.age > 1 ? --event.age : 1;
        state.detailsMap['age'] = age;
      }
      emit(state.copyWith(officeAge: age));
    });
    on<ToggleOfficesCountSelectorEvent>((event, emit) {
      state.detailsMap.removeWhere((key, value) => key == 'officescount');
      emit(state.copyWith(
        officesCount: 0,
        officesCountSelectorState: getCounterToggleState(state.officesCountSelectorState),
      ));
      emit(state.copyWith(isStepCompleted: checkIfOfficeDetailsStepCompleted()));
    });
    on<IncreaseOfficesCountEvent>((event, emit) {
      state.detailsMap['officescount'] = ++event.count;
      emit(state.copyWith(officesCount: state.detailsMap['officescount']));
      emit(state.copyWith(isStepCompleted: checkIfOfficeDetailsStepCompleted()));
    });
    on<DecreaseOfficesCountEvent>((event, emit) {
      int count = 0;
      if (event.count > 1) {
        count = event.count > 1 ? --event.count : 0;
        state.detailsMap['officescount'] = count;
      } else {
        state.detailsMap.removeWhere((key, value) => key == 'officescount');
      }
      emit(state.copyWith(officesCount: count));
      emit(state.copyWith(isStepCompleted: checkIfOfficeDetailsStepCompleted()));
    });
    on<ToggleMeetingRoomsCountSelectorEvent>((event, emit) {
      state.detailsMap.removeWhere((key, value) => key == 'meetingroomscount');
      emit(state.copyWith(
        meetingRoomsCount: 0,
        meetingRoomsCountSelectorState: getCounterToggleState(state.meetingRoomsCountSelectorState),
      ));
      emit(state.copyWith(isStepCompleted: checkIfOfficeDetailsStepCompleted()));
    });
    on<IncreaseMeetingRoomsCountEvent>((event, emit) {
      state.detailsMap['meetingroomscount'] = ++event.count;
      emit(state.copyWith(meetingRoomsCount: state.detailsMap['meetingroomscount']));
      emit(state.copyWith(isStepCompleted: checkIfOfficeDetailsStepCompleted()));
    });
    on<DecreaseMeetingRoomsCountEvent>((event, emit) {
      int count = 0;
      if (event.count > 1) {
        count = event.count > 1 ? --event.count : 0;
        state.detailsMap['meetingroomscount'] = count;
      } else {
        state.detailsMap.removeWhere((key, value) => key == 'meetingroomscount');
      }
      emit(state.copyWith(meetingRoomsCount: count));
      emit(state.copyWith(isStepCompleted: checkIfOfficeDetailsStepCompleted()));
    });
    on<ToggleTablesCountSelectorEvent>((event, emit) {
      state.detailsMap.removeWhere((key, value) => key == 'tablescount');
      emit(state.copyWith(
        tablesCount: 0,
        tablesCountSelectorState: getCounterToggleState(state.tablesCountSelectorState),
      ));
      emit(state.copyWith(isStepCompleted: checkIfOfficeDetailsStepCompleted()));
    });
    on<IncreaseTablesCountEvent>((event, emit) {
      state.detailsMap['tablescount'] = ++event.count;
      emit(state.copyWith(tablesCount: state.detailsMap['tablescount']));
      emit(state.copyWith(isStepCompleted: checkIfOfficeDetailsStepCompleted()));
    });
    on<DecreaseTablesCountEvent>((event, emit) {
      int count = 0;
      if (event.count > 1) {
        count = event.count > 1 ? --event.count : 0;
        state.detailsMap['tablescount'] = count;
      } else {
        state.detailsMap.removeWhere((key, value) => key == 'tablescount');
      }
      emit(state.copyWith(tablesCount: count));
      emit(state.copyWith(isStepCompleted: checkIfOfficeDetailsStepCompleted()));
    });
    on<ToggleSharedWorkSpacesSelectorEvent>((event, emit) {
      state.detailsMap.removeWhere((key, value) => key == 'sharedworkspacescount');
      emit(state.copyWith(
        sharedWorkSpaces: 0,
        sharedWorkSpacesSelectorState: getCounterToggleState(state.sharedWorkSpacesSelectorState),
      ));
      emit(state.copyWith(isStepCompleted: checkIfOfficeDetailsStepCompleted()));
    });
    on<IncreaseSharedWorkSpacesCountEvent>((event, emit) {
      state.detailsMap['sharedworkspacescount'] = ++event.count;
      emit(state.copyWith(sharedWorkSpaces: state.detailsMap['sharedworkspacescount']));
      emit(state.copyWith(isStepCompleted: checkIfOfficeDetailsStepCompleted()));
    });
    on<DecreaseSharedWorkSpacesCountEvent>((event, emit) {
      int count = 0;
      if (event.count > 1) {
        count = event.count > 1 ? --event.count : 0;
        state.detailsMap['sharedworkspacescount'] = count;
      } else {
        state.detailsMap.removeWhere((key, value) => key == 'sharedworkspacescount');
      }
      emit(state.copyWith(sharedWorkSpaces: count));
      emit(state.copyWith(isStepCompleted: checkIfOfficeDetailsStepCompleted()));
    });
    on<SelectFacilityEvent>((event, emit) {
      facilities = _toggleListItem(List.from(state.facilities), event.id);
      emit(state.copyWith(facilities: facilities));
    });
    on<SetDescriptionEvent>((event, emit) {
      state.description = event.description.length >= 8 ? event.description : '';
      emit(state.copyWith(isStepCompleted: checkIfOfficeDescriptionStepCompleted()));
    });
    on<SelectFeatureEvent>((event, emit) {
      features = _toggleListItem(List.from(state.features), event.id);
      emit(state.copyWith(features: features));
    });
    on<SelectServiceEvent>((event, emit) {
      services = _toggleListItem(List.from(state.services), event.id);
      emit(state.copyWith(services: services));
    });
    on<SelectComfortEvent>((event, emit) {
      comforts = _toggleListItem(List.from(state.comforts), event.id);
      emit(state.copyWith(comforts: comforts));
    });
    on<AddAddtionalServiceEvent>((event, emit) {
      Map<UniqueKey, GlobalKey<FormState>> keys = Map.from(state.additionalServiceKeys);
      Map<UniqueKey, Map<String, dynamic>> data = Map.from(state.additionalServices);
      UniqueKey key = UniqueKey();
      keys[key] = GlobalKey<FormState>();
      data[key] = {'status': false};
      emit(state.copyWith(additionalServiceKeys: keys, additionalServices: data));
    });
    on<RemoveAdditionalServiceEvent>((event, emit) {
      Map<UniqueKey, GlobalKey<FormState>> keys = Map.from(state.additionalServiceKeys);
      Map<UniqueKey, Map<String, dynamic>> data = Map.from(state.additionalServices);
      keys.remove(event.key);
      data.remove(event.key);
      emit(state.copyWith(additionalServiceKeys: keys, additionalServices: data));
    });
    on<SetServiceNameEvent>((event, emit) {
      Map<UniqueKey, Map<String, dynamic>> servicesData = Map.from(state.additionalServices);
      servicesData[event.key]!['name'] = event.name;
      emit(state.copyWith(additionalServices: servicesData));
    });
    on<SetServiceEnglishNameEvent>((event, emit) {
      Map<UniqueKey, Map<String, dynamic>> servicesData = Map.from(state.additionalServices);
      servicesData[event.key]!['enName'] = event.name;
      emit(state.copyWith(additionalServices: servicesData));
    });
    on<SetServicePriceEvent>((event, emit) {
      Map<UniqueKey, Map<String, dynamic>> servicesData = Map.from(state.additionalServices);
      servicesData[event.key]!['price'] = event.price;
      emit(state.copyWith(additionalServices: servicesData));
    });
    on<ToggleServiceStateEvent>((event, emit) {
      Map<UniqueKey, Map<String, dynamic>> servicesData = Map.from(state.additionalServices);
      bool status = servicesData[event.key]!['status'];
      servicesData[event.key]!['status'] = !status;
      emit(state.copyWith(additionalServices: servicesData));
    });
    on<SelectAddressPositionEvent>((event, emit) async {
      emit(state.copyWith(
          addressPosition: LatLng(event.position.latitude, event.position.longitude), currentMapZoom: event.zoom));
    });
    on<GoToSelectedAddressEvent>((event, emit) async {
      log("POSITION 1");
      var result = await _mapRepository.getPlaceDetails(event.placeId);
      result.fold(
        (failure) {},
        (position) {
          log("POSITION 2");
          log(position.toString());
          if (position != null) {
            emit(state.copyWith(addressPosition: position));
          }
        },
      );
    });
    on<GoToCurrentLocationEvent>((event, emit) async {
      currentPosition = await locator<LocationHelper>().getCurrentLocation();
      if (currentPosition != null) {
        emit(state.copyWith(addressPosition: LatLng(currentPosition!.latitude, currentPosition!.longitude)));
      }
    });
    on<SetCityNameEvent>((event, emit) {
      state.city = event.name;
      emit(state.copyWith(
        isStepCompleted: checkIfConfirmAddressStepCompleted(),
      ));
    });
    on<SetNeighborhoodNameEvent>((event, emit) {
      state.neighborhood = event.name;
      emit(state.copyWith(
        isStepCompleted: checkIfConfirmAddressStepCompleted(),
      ));
    });
    on<SetStreetNameEvent>((event, emit) {
      state.street = event.name;
      emit(state.copyWith(
        isStepCompleted: checkIfConfirmAddressStepCompleted(),
      ));
    });
    on<SetInterfaceEvent>((event, emit) {
      state.interfaceId =
          state.searchData!.officeInterfaces.firstWhere((interface) => interface.arName == event.interface).id;
      emit(state.copyWith(isStepCompleted: checkIfConfirmAddressStepCompleted()));
    });
    on<ToggleUnitPriceOptionEvent>((event, emit) {
      selectedUnitPriceOptions = List.from(state.selectedUnitPriceOptions);
      selectedUnitPrices = state.selectedUnitPrices;
      if (selectedUnitPriceOptions.contains(event.option)) {
        selectedUnitPriceOptions.remove(event.option);
        selectedUnitPrices.remove(event.option);
        if (state.selectedUnitPricesCount > 0) {
          state.selectedUnitPricesCount--;
        }
      } else {
        selectedUnitPriceOptions.add(event.option);
        if (state.selectedUnitPricesCount == -1) {
          state.selectedUnitPricesCount = 1;
        } else {
          state.selectedUnitPricesCount++;
        }
      }
      emit(state.copyWith(
        selectedUnitPriceOptions: selectedUnitPriceOptions,
        selectedUnitPrices: selectedUnitPrices,
      ));
      emit(state.copyWith(isStepCompleted: checkIfOfficePricesStepCompleted()));
    });
    on<ChangeUnitPriceEvent>((event, emit) {
      selectedUnitPrices = Map.from(state.selectedUnitPrices);
      if (event.price.isNotEmpty && state.selectedUnitPriceOptions.contains(event.option)) {
        selectedUnitPrices.addAll({event.option: num.parse(event.price)});
      } else {
        selectedUnitPrices.remove(event.option);
      }
      emit(state.copyWith(selectedUnitPrices: selectedUnitPrices));
      emit(state.copyWith(isStepCompleted: checkIfOfficePricesStepCompleted()));
    });
    on<SelectDepositTypeEvent>((event, emit) {
      emit(state.copyWith(depositType: event.type));
    });
    on<ChangeDepositAmountEvent>((event, emit) {
      if (state.selectedUnitPricesCount == -1) {
        state.selectedUnitPricesCount = 0;
      }
      emit(state.copyWith(
        depositAmount: event.amount.isNotEmpty ? num.parse(event.amount) : -1,
        isStepCompleted: checkIfOfficePricesStepCompleted(),
      ));
    });
    on<SetViewerNameEvent>((event, emit) {
      state.viewerName = event.name;
      emit(state.copyWith(
        isStepCompleted: checkIfOfficePricesStepCompleted(),
      ));
    });
    on<SetViewerPhoneEvent>((event, emit) {
      state.viewerPhone = event.phone.length >= 9 && event.phone.startsWith('5') ? event.phone : '';
      emit(state.copyWith(
        isStepCompleted: checkIfOfficePricesStepCompleted(),
      ));
    });
    on<PickOfficeVideoEvent>((event, emit) async {
      String selectedVideo = await locator<FilePickerHelper>().pickVideo();
      emit(state.copyWith(selectedVideo: selectedVideo));
    });
    on<DeleteOfficeVideoEvent>((event, emit) async {
      emit(state.copyWith(selectedVideo: ''));
    });
    on<PickOfficeMainImageEvent>((event, emit) async {
      await _pickImage(state, emit, true);
      emit(state.copyWith(isStepCompleted: checkIfOfficeFilesStepCompleted()));
    });
    on<DeleteOfficeMainImageEvent>((event, emit) async {
      _deleteImage(state, emit, isMainImage: true);
      emit(state.copyWith(isStepCompleted: checkIfOfficeFilesStepCompleted()));
    });
    on<PickOfficeImageEvent>((event, emit) async {
      await _pickImage(state, emit, false);
      emit(state.copyWith(isStepCompleted: checkIfOfficeFilesStepCompleted()));
    });
    on<DeleteOfficeImageEvent>((event, emit) async {
      _deleteImage(state, emit, isMainImage: false, key: event.key);
      emit(state.copyWith(isStepCompleted: checkIfOfficeFilesStepCompleted()));
    });
    on<PickOfficeLicensingFileEvent>((event, emit) async {
      await _pickFile(state, emit, MarketerFileTypes.officeLicense);
      emit(state.copyWith(isStepCompleted: checkIfOfficeFilesStepCompleted()));
    });
    on<PickBuildingLicensingFileEvent>((event, emit) async {
      await _pickFile(state, emit, MarketerFileTypes.buildingLicense);
      emit(state.copyWith(isStepCompleted: checkIfOfficeFilesStepCompleted()));
    });
    on<PickCivilDefenseFileEvent>((event, emit) async {
      await _pickFile(state, emit, MarketerFileTypes.civilDefense);
      emit(state.copyWith(isStepCompleted: checkIfOfficeFilesStepCompleted()));
    });
    on<NavigateToNextStepEvent>((event, emit) async {
      emit(state.copyWith(stepNavigationState: StepNavigationState.initial));
      switch (event.index) {
        case 0:
          navigateAfterSuccessStep(emit, event.index);
          break;
        case 1:
          bool temp = false;
          if (state.createdOffice == null) {
            temp = await createOffice(emit);
            if (temp) {
              navigateAfterSuccessStep(emit, event.index);
            }
          } else {
            bool temp1 = false;
            bool temp2 = false;
            if (state.createdOffice!.title != state.name) {
              temp1 = await updateTitle(emit);
            } else {
              temp1 = true;
            }
            if (state.createdOffice!.categoryId != state.categoryId) {
              temp2 = await updateCategory(emit);
            } else {
              temp2 = true;
            }
            if (temp1 && temp2) {
              navigateAfterSuccessStep(emit, event.index);
            }
          }
          break;
        case 2:
          bool temp1 = false;
          if ((state.createdUnit?.advertiserRelationship ?? '').isEmpty) {
            temp1 = await updateInfo(emit);
            if (temp1) {
              navigateAfterSuccessStep(emit, event.index);
            }
          } else {
            if (state.createdUnit!.advertiserRelationship !=
                    getCounterAdvertiserRelationship(state.advertiserRelationshipOption) ||
                state.createdUnit!.space != num.parse(state.space) ||
                state.createdUnit!.furnisher != state.equipment ||
                state.createdUnit!.typeAqarId! != state.type.toString()) {
              bool temp1 = await updateInfo(emit);
              if (temp1) {
                navigateAfterSuccessStep(emit, event.index);
              }
            } else {
              navigateAfterSuccessStep(emit, event.index);
            }
          }
          break;
        case 3:
          bool temp1 = false;
          bool temp2 = true;
          temp1 = await updateOfficeDetails(emit);
          if (state.createdUnit!.facilities.isEmpty && state.facilities.isNotEmpty) {
            temp2 = await updateFacilities(emit);
          } else {
            if (!listEquals(state.createdUnit!.facilities.map((facility) => facility.id).toList(), state.facilities)) {
              temp2 = await updateFacilities(emit);
            }
          }
          if (temp1 && temp2) {
            navigateAfterSuccessStep(emit, event.index);
          }
          break;
        case 4:
          bool temp1 = false;
          if ((state.createdUnit!.description ?? '').isEmpty || state.createdUnit!.description != state.description) {
            temp1 = await updateDescription(emit);
            if (temp1) {
              navigateAfterSuccessStep(emit, event.index);
            }
          } else {
            navigateAfterSuccessStep(emit, event.index);
          }
          break;
        case 5:
          bool temp1 = true;
          bool temp2 = true;
          bool temp3 = true;
          if (state.createdUnit!.features.isEmpty && state.features.isNotEmpty) {
            temp1 = await updateFeatures(emit);
          } else {
            if (!listEquals(state.createdUnit!.features.map((feature) => feature.id).toList(), state.features)) {
              temp1 = await updateFeatures(emit);
            }
          }
          if (state.additionalServiceKeys.isNotEmpty) {
            for (GlobalKey<FormState> formKey in state.additionalServiceKeys.values) {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
              } else {
                temp3 = false;
              }
            }
          }
          if (state.createdUnit!.comforts.isEmpty && state.comforts.isNotEmpty) {
            temp2 = await updateComforts(emit);
          } else {
            if (!listEquals(state.createdUnit!.comforts.map((comfort) => comfort.id).toList(), state.comforts)) {
              temp2 = await updateComforts(emit);
            }
          }
          if (temp1 && temp2 && temp3) {
            navigateAfterSuccessStep(emit, event.index);
          }
          break;
        case 6:
          bool temp1 = true;
          if (state.createdUnit!.location == null ||
              (state.addressPosition.latitude != state.createdUnit!.location!.lat.toDouble() &&
                  state.addressPosition.longitude != state.createdUnit!.location!.lng.toDouble())) {
            temp1 = await getOfficeAddressDetails(emit);
          }
          if (temp1) {
            navigateAfterSuccessStep(emit, event.index);
          }
          break;
        case 7:
          bool temp1 = false;
          bool temp2 = false;
          if (state.createdUnit!.location == null) {
            temp1 = await updateLocation(emit);
          }
          if (state.createdUnit!.interfaceId == null) {
            temp2 = await updateInterface(emit);
          } else {
            temp1 = true;
            temp2 = true;
            if (state.createdUnit!.location!.city != state.city ||
                state.createdUnit!.location!.neighborhood != state.neighborhood ||
                state.createdUnit!.location!.street != state.street) {
              temp1 = await updateLocation(emit);
            } else if (state.createdUnit!.interfaceId != state.interfaceId) {
              temp2 = await updateInterface(emit);
            }
          }
          if (temp1 && temp2) {
            navigateAfterSuccessStep(emit, event.index);
          }
          break;
        case 8:
          bool temp1 = true;
          bool temp2 = true;
          bool temp3 = true;
          temp1 = await updatePrices(emit);
          if (state.selectedUnitPriceOptions.contains(UnitPriceOptions.yearly)) {
            if (state.depositAmount != state.createdUnit!.downPayment ||
                getCounterDepositType(state.depositType ?? DepositTypes.price) != state.createdUnit!.typeDownPayment) {
              temp2 = await updateDepositInfo(emit);
            }
          }
          if (state.viewerName != state.createdUnit!.viewerName ||
              state.viewerPhone != state.createdUnit!.viewerPhone) {
            temp3 = await updateViewerInfo(emit);
          }
          if (temp1 && temp2 && temp3) {
            navigateAfterSuccessStep(emit, event.index);
          }
          break;
        case 9:
          emit(state.copyWith(stepNavigationState: StepNavigationState.end));
          await uploadOfficeFiles(emit);
          if (state.officeType == OfficeTypes.request) {
            await uploadMarketingFiles(emit);
          }
          break;
      }
      emit(state.copyWith(stepNavigationState: StepNavigationState.initial));
    });
    on<NavigateToPreviousStepEvent>((event, emit) async {
      emit(state.copyWith(
        stepNavigationState: StepNavigationState.previous,
        isStepCompleted: checkIfStepCompleted(event.index),
        progressValue: --state.progressValue,
      ));
      emit(state.copyWith(stepNavigationState: StepNavigationState.initial));
    });
    on<UpdateOfficeNameAndCategoryEvent>(
      (event, emit) async {
        emit(state.copyWith(officeApiCallState: OfficeApiCallState.loading));
        bool temp1 = await updateTitle(emit);
        bool temp2 = await updateCategory(emit);
        if (temp1 && temp2) {}
      },
    );
    on<SelectAndGetAddressPositionEvent>(
      (event, emit) async {
        emit(state.copyWith(
            addressPosition: LatLng(event.position.latitude, event.position.longitude), currentMapZoom: event.zoom));
        var result = await _mapRepository.getAddressDetails(
            lat: state.addressPosition.latitude, long: state.addressPosition.longitude);
        return result.fold(
          (failure) {},
          (right) async {
            emit(
              state.copyWith(
                addressPosition: LatLng(state.addressPosition.latitude, state.addressPosition.longitude),
                city: right.city,
                neighborhood: right.neighborhood,
                street: right.street,
              ),
            );
          },
        );
      },
    );
    on<UpdateOfficeLocationEvent>(
      (event, emit) async {
        emit(state.copyWith(officeApiCallState: OfficeApiCallState.loading));
        bool temp1 = await updateLocation(emit);
        bool temp2 = await updateInterface(emit);
        if (temp1 && temp2) {}
      },
    );
    on<DeleteOfficeEvent>((event, emit) async {
      emit(state.copyWith(officeApiCallState: OfficeApiCallState.loading));
      final result = await _officeRepository.deleteById(event.id);
      result.fold(
        (failure) => emit(state.copyWith(officeApiCallState: OfficeApiCallState.failure)),
        (success) => emit(state.copyWith(officeApiCallState: OfficeApiCallState.success)),
      );
    });
  }

  void navigateAfterSuccessStep(Emitter emit, int index) {
    emit(state.copyWith(
      stepNavigationState: StepNavigationState.next,
      isStepCompleted: checkIfStepCompleted(index + 1),
      progressValue: ++state.progressValue,
    ));
  }

  bool checkIfStepCompleted(int index) {
    switch (index) {
      case 0:
        return checkIfOfficeTypeStepCompleted();
      case 1:
        return checkIfOfficeFirstInfoStepCompleted();
      case 2:
        return checkIfOfficeSecondStepCompleted();
      case 3:
        return checkIfOfficeDetailsStepCompleted();
      case 4:
        return checkIfOfficeDescriptionStepCompleted();
      case 5:
        return true;
      case 6:
        return true;
      case 7:
        return checkIfConfirmAddressStepCompleted();
      case 8:
        return checkIfOfficePricesStepCompleted();
      case 9:
        return checkIfOfficeFilesStepCompleted();
    }
    return false;
  }

  bool checkIfOfficeTypeStepCompleted() {
    return state.officeType != OfficeTypes.none ? true : false;
  }

  bool checkIfOfficeFirstInfoStepCompleted() {
    return state.name.isNotEmpty && state.categoryId >= 0 && state.acceptingUserAgreement ? true : false;
  }

  bool checkIfOfficeSecondStepCompleted() {
    return state.advertiserRelationshipOption != AdertiserRelationshipOptions.none &&
            state.space.isNotEmpty &&
            state.equipment.isNotEmpty &&
            state.type != -1
        ? state.advertiserRelationshipOption == AdertiserRelationshipOptions.marketer &&
                state.marketerTypeOption == MarketerTypes.none
            ? false
            : true
        : false;
  }

  bool checkIfOfficeDetailsStepCompleted() {
    return state.officesCountSelectorState == ToggleStates.on && state.officesCount <= 0 ||
            state.meetingRoomsCountSelectorState == ToggleStates.on && state.meetingRoomsCount <= 0 ||
            state.tablesCountSelectorState == ToggleStates.on && state.tablesCount <= 0 ||
            state.sharedWorkSpacesSelectorState == ToggleStates.on && state.sharedWorkSpaces <= 0
        ? false
        : true;
  }

  bool checkIfOfficeDescriptionStepCompleted() {
    return state.description.isEmpty ? false : true;
  }

  bool checkIfConfirmAddressStepCompleted() {
    return state.city.isEmpty || state.neighborhood.isEmpty | state.street.isEmpty || state.interfaceId < 0
        ? false
        : true;
  }

  bool checkIfOfficePricesStepCompleted() {
    return state.selectedUnitPrices.isEmpty ||
            state.selectedUnitPrices.length < state.selectedUnitPriceOptions.length ||
            // state.selectedUnitPrices.values.min < state.depositAmount ||
            state.selectedUnitPriceOptions.contains(UnitPriceOptions.yearly) && state.depositAmount < 0 ||
            state.viewerName.isEmpty ||
            state.viewerPhone.isEmpty
        ? false
        : true;
  }

  bool checkIfOfficeFilesStepCompleted() {
    return state.selectedMainImage.isEmpty ||
            state.selectedImagesCount < 4 ||
            state.officeType == OfficeTypes.request &&
                (state.selectedBuildingLicesnsingFile.isEmpty ||
                    state.selectedOfficeLicensingFile.isEmpty ||
                    state.selectedCivilDefenseFile.isEmpty)
        ? false
        : true;
  }

  void _toggleAddingLicenseOffice(Emitter<OfficeState> emit) {
    state.licenseOfficeState == VisibilityStates.show
        ? emit(state.copyWith(
            licenseOfficeState: VisibilityStates.hide,
            officeType: OfficeTypes.none,
          ))
        : emit(state.copyWith(
            licenseOfficeState: VisibilityStates.show,
            marketingRequestState: VisibilityStates.hide,
            officeType: OfficeTypes.license,
          ));
    emit(state.copyWith(isStepCompleted: checkIfOfficeTypeStepCompleted()));
  }

  void _toggleAddingMarketingRequest(Emitter<OfficeState> emit) {
    state.marketingRequestState == VisibilityStates.show
        ? emit(state.copyWith(
            marketingRequestState: VisibilityStates.hide,
            officeType: OfficeTypes.none,
          ))
        : emit(state.copyWith(
            marketingRequestState: VisibilityStates.show,
            licenseOfficeState: VisibilityStates.hide,
            officeType: OfficeTypes.request,
          ));
    emit(state.copyWith(isStepCompleted: checkIfOfficeTypeStepCompleted()));
  }

  ToggleStates getCounterToggleState(ToggleStates state) {
    return state == ToggleStates.on ? ToggleStates.off : ToggleStates.on;
  }

  List<T> _toggleListItem<T>(List<T> list, T element) {
    list.contains(element) ? list.remove(element) : list.add(element);
    return list;
  }

  // void _updateAdditionalServices(Emitter emit, {UniqueKey? newKey, UniqueKey? keyToRemove}) {
  //   additionalServiceKeys = Map.from(state.additionalServiceKeys);
  //   if (newKey != null) {
  //     additionalServiceKeys[newKey] = GlobalKey<FormState>();
  //   } else if (keyToRemove != null) {
  //     additionalServiceKeys.remove(keyToRemove);
  //   }
  //   emit(state.copyWith(additionalServiceKeys: additionalServiceKeys));
  // }

  Future<void> _pickImage(OfficeState state, Emitter<OfficeState> emit, bool isMainImage) async {
    emit(state.copyWith(imagesErrorMessage: ''));
    selectedImage = await locator<FilePickerHelper>().pickImage();
    if (selectedImage != null) {
      if (selectedImage!.isNotEmpty) {
        croppedImage = await ImageCropperHelper.cropImage(selectedImage: selectedImage!);
        if (croppedImage != null) {
          if (isMainImage) {
            emit(state.copyWith(
              selectedMainImage: croppedImage,
              isMainImageSelected: true,
              imagesErrorMessage: '',
            ));
          } else {
            imagesMap = Map.from(state.selectedImagesMap);
            imagesMap[UniqueKey()] = croppedImage!;
            state.selectedImagesCount == -1 ? state.selectedImagesCount = 1 : state.selectedImagesCount++;
            emit(state.copyWith(
              selectedImagesMap: imagesMap,
              imagesErrorMessage: '',
            ));
          }
        }
      } else {
        emit(state.copyWith(imagesErrorMessage: 'يجب أن يكون حجم الصورة أصغر من 2 ميغا بايت'));
      }
    }
  }

  void _deleteImage(OfficeState state, Emitter<OfficeState> emit, {Key? key, bool isMainImage = false}) {
    if (isMainImage) {
      emit(state.copyWith(
        selectedMainImage: '',
        isMainImageSelected: false,
        imagesErrorMessage: '',
      ));
    } else {
      imagesMap = Map.from(state.selectedImagesMap);
      imagesMap.remove(key);
      emit(state.copyWith(
        selectedImagesMap: imagesMap,
        selectedImagesCount: state.selectedImagesCount - 1,
        imagesErrorMessage: '',
      ));
    }
  }

  Future<void> _pickFile(OfficeState state, Emitter<OfficeState> emit, MarketerFileTypes type) async {
    selectedFile = '';
    emit(state.copyWith(filesErrorMessage: ''));
    selectedFile = await locator<FilePickerHelper>().pickFile();
    if (selectedFile != null) {
      if (selectedFile!.isNotEmpty) {
        switch (type) {
          case MarketerFileTypes.officeLicense:
            emit(state.copyWith(selectedOfficeLicensingFile: selectedFile, filesErrorMessage: ''));
            break;
          case MarketerFileTypes.buildingLicense:
            emit(state.copyWith(selectedBuildingLicesnsingFile: selectedFile, filesErrorMessage: ''));
            break;
          case MarketerFileTypes.civilDefense:
            emit(state.copyWith(selectedCivilDefenseFile: selectedFile, filesErrorMessage: ''));
            break;
        }
      }
    } else {
      emit(state.copyWith(filesErrorMessage: 'يجب أن يكون حجم الملف أصغر من 3 ميغا بايت'));
    }
  }

  Future<bool> createOffice(Emitter emit) async {
    emit(state.copyWith(officeApiCallState: OfficeApiCallState.loading));
    var result = await _officeRepository.createOffice(
      title: state.name,
      categoryId: state.categoryId,
      isMarketing: state.officeType == OfficeTypes.request ? true : false,
      licenseNumber: state.officeType == OfficeTypes.license ? state.licenseNumber : '',
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(
          officeApiCallState: OfficeApiCallState.failure,
          createdOffice: null,
        ));
        return false;
      },
      (createdOffice) async {
        emit(state.copyWith(createdOffice: createdOffice));
        var result = await _officeRepository.addUnit(
          officeId: createdOffice!.id,
          title: state.name,
          categoryId: state.categoryId,
          isMarketing: state.officeType == OfficeTypes.request ? true : false,
          licenseNumber: '',
          isCentral: true,
        );
        return result.fold(
          (failure) {
            emit(state.copyWith(
              officeApiCallState: OfficeApiCallState.failure,
              createdUnit: null,
            ));
            return false;
          },
          (createdUnit) {
            emit(state.copyWith(
              officeApiCallState: OfficeApiCallState.success,
              createdUnit: createdUnit,
            ));
            return true;
          },
        );
      },
    );
  }

  Future<bool> updateTitle(Emitter emit) async {
    emit(state.copyWith(officeApiCallState: OfficeApiCallState.loading));
    var result = await _officeRepository.updateTitle(
      title: state.name,
      officeId: state.createdOffice!.id,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(officeApiCallState: OfficeApiCallState.failure));
        return false;
      },
      (updatedOffice) async {
        emit(state.copyWith(createdOffice: state.createdOffice!.copyWith(title: updatedOffice!.title)));
        var result = await _officeRepository.updateTitle(
          title: state.name,
          officeId: state.createdUnit!.id,
        );
        return result.fold(
          (failure) {
            emit(state.copyWith(officeApiCallState: OfficeApiCallState.failure));
            return false;
          },
          (updatedUnit) async {
            emit(state.copyWith(
                officeApiCallState: OfficeApiCallState.success,
                createdUnit: state.createdUnit!.copyWith(title: updatedUnit!.title)));
            return true;
          },
        );
      },
    );
  }

  Future<bool> updateCategory(Emitter emit) async {
    emit(state.copyWith(officeApiCallState: OfficeApiCallState.loading));
    var result = await _officeRepository.updateCategory(
      categoryId: state.categoryId,
      officeId: state.createdOffice!.id,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(officeApiCallState: OfficeApiCallState.failure));
        return false;
      },
      (updatedOffice) async {
        emit(state.copyWith(createdOffice: state.createdOffice!.copyWith(categoryId: updatedOffice!.categoryId)));
        var result = await _officeRepository.updateCategory(
          categoryId: state.categoryId,
          officeId: state.createdUnit!.id,
        );
        return result.fold(
          (failure) {
            emit(state.copyWith(officeApiCallState: OfficeApiCallState.failure));
            return false;
          },
          (updatedUnit) async {
            emit(state.copyWith(
                officeApiCallState: OfficeApiCallState.success,
                createdUnit: state.createdUnit!.copyWith(categoryId: updatedUnit!.categoryId)));
            return true;
          },
        );
      },
    );
  }

  AdertiserRelationshipOptions getAdvertiserRelationship(String option) {
    switch (option) {
      case 'مالك':
        return AdertiserRelationshipOptions.owner;
      case 'وكيل':
        return AdertiserRelationshipOptions.agent;
      default:
        return AdertiserRelationshipOptions.marketer;
    }
  }

  String getCounterAdvertiserRelationship(AdertiserRelationshipOptions option) {
    switch (option) {
      case AdertiserRelationshipOptions.owner:
        return 'مالك';
      case AdertiserRelationshipOptions.agent:
        return 'وكيل';
      case AdertiserRelationshipOptions.marketer:
        return 'مسوق';
      default:
        return '';
    }
  }

  MarketerTypes getAdvertiserRelationshipType(String? type) {
    switch (type) {
      case 'حصري':
        return MarketerTypes.exclusive;
      case 'غير حصري':
        return MarketerTypes.notExclusive;
    }
    return MarketerTypes.exclusive;
  }

  String? getCounterAdvertiserRelationshipType(MarketerTypes type) {
    switch (type) {
      case MarketerTypes.exclusive:
        return 'حصري';
      case MarketerTypes.notExclusive:
        return 'غير حصري';
      default:
        return null;
    }
  }

  Future<bool> updateInfo(Emitter emit) async {
    emit(state.copyWith(officeApiCallState: OfficeApiCallState.loading));
    String advertiserRelationship = getCounterAdvertiserRelationship(state.advertiserRelationshipOption);
    String? advertiserRelationshipType = getCounterAdvertiserRelationshipType(state.marketerTypeOption);
    Either<AppException, Office?> result = await _officeRepository.updateOfficeInfo(
      officeId: state.createdUnit!.id,
      advertiserRelationship: advertiserRelationship,
      advertiserRelationshipType: advertiserRelationshipType,
      space: state.space,
      equipment: state.equipment,
      typeId: state.searchData!.officeTypes.firstWhere((type) => type.id == state.type).id,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(officeApiCallState: OfficeApiCallState.failure));
        return false;
      },
      (updatedUnit) async {
        emit(state.copyWith(
          officeApiCallState: OfficeApiCallState.success,
          createdUnit: state.createdUnit!.copyWith(
            advertiserRelationship: updatedUnit!.advertiserRelationship,
            advertiserRelationshipType: updatedUnit.advertiserRelationshipType,
            space: updatedUnit.space,
            height: updatedUnit.height,
            width: updatedUnit.width,
            furnisher: updatedUnit.furnisher,
            typeAqarId: updatedUnit.typeAqarId,
          ),
        ));
        return true;
      },
    );
  }

  Future<bool> updateOfficeDetails(Emitter emit) async {
    Map<String, dynamic> newDetails = {};
    Map<String, Map<int, dynamic>> updatedDetails = {};
    List<int> deletedDetails = [];
    state.detailsMap.forEach((key, value) {
      bool isExisting = false;
      for (OfficeDetail detail in state.createdUnit!.details) {
        if (detail.enName == key) {
          isExisting = true;
          if (detail.numberDetails != value) {
            updatedDetails[key] = {detail.id: state.detailsMap[key]};
          }
          break;
        }
      }
      if (!isExisting) {
        newDetails[key] = value;
      }
    });
    for (OfficeDetail detail in state.createdUnit!.details) {
      if (!state.detailsMap.containsKey(detail.enName)) {
        deletedDetails.add(detail.id);
      }
    }
    log("New Details: $newDetails");
    log("Updated Details: $updatedDetails");
    log("Deleted Details: $deletedDetails");
    if (newDetails.isNotEmpty || updatedDetails.isNotEmpty || deletedDetails.isNotEmpty) {
      emit(state.copyWith(officeApiCallState: OfficeApiCallState.loading));
      var result = await _officeRepository.updateOfficeDetails(
        officeId: state.createdUnit!.id,
        newDetails: newDetails,
        updatedDetails: updatedDetails,
        deletedDetails: deletedDetails,
      );
      return result.fold(
        (failure) {
          emit(state.copyWith(officeApiCallState: OfficeApiCallState.failure));
          return false;
        },
        (updatedUnit) async {
          emit(state.copyWith(
            officeApiCallState: OfficeApiCallState.success,
            createdUnit: state.createdUnit!.copyWith(details: updatedUnit!.details),
          ));
          return true;
        },
      );
    }
    return true;
  }

  Future<bool> updateFacilities(Emitter emit) async {
    emit(state.copyWith(officeApiCallState: OfficeApiCallState.loading));
    var result = await _officeRepository.updateOfficeFacilities(
      officeId: state.createdUnit!.id,
      facilities: state.facilities,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(officeApiCallState: OfficeApiCallState.failure));
        return false;
      },
      (updatedUnit) async {
        emit(state.copyWith(
          officeApiCallState: OfficeApiCallState.success,
          createdUnit: state.createdUnit!.copyWith(facilities: updatedUnit!.facilities),
        ));
        return true;
      },
    );
  }

  Future<bool> updateDescription(Emitter emit) async {
    emit(state.copyWith(officeApiCallState: OfficeApiCallState.loading));
    var result =
        await _officeRepository.updateDescription(officeId: state.createdUnit!.id, description: state.description);
    return result.fold(
      (failure) {
        emit(state.copyWith(officeApiCallState: OfficeApiCallState.failure));
        return false;
      },
      (updatedUnit) async {
        emit(state.copyWith(
          officeApiCallState: OfficeApiCallState.success,
          createdUnit: state.createdUnit!.copyWith(description: updatedUnit.description),
        ));
        return true;
      },
    );
  }

  Future<bool> updateFeatures(Emitter emit) async {
    emit(state.copyWith(officeApiCallState: OfficeApiCallState.loading));
    var result = await _officeRepository.updateOfficeFeatures(
      officeId: state.createdUnit!.id,
      features: state.features,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(officeApiCallState: OfficeApiCallState.failure));
        return false;
      },
      (updatedUnit) async {
        emit(state.copyWith(
          officeApiCallState: OfficeApiCallState.success,
          createdUnit: state.createdUnit!.copyWith(features: updatedUnit!.features),
        ));
        return true;
      },
    );
  }

  Future<bool> updateComforts(Emitter emit) async {
    emit(state.copyWith(officeApiCallState: OfficeApiCallState.loading));
    var result = await _officeRepository.updateOfficeComforts(
      officeId: state.createdUnit!.id,
      comforts: state.comforts,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(officeApiCallState: OfficeApiCallState.failure));
        return false;
      },
      (updatedUnit) async {
        emit(state.copyWith(
          officeApiCallState: OfficeApiCallState.success,
          createdUnit: state.createdUnit!.copyWith(comforts: updatedUnit!.comforts),
        ));
        return true;
      },
    );
  }

  Future<bool> getOfficeAddressDetails(Emitter<OfficeState> emit) async {
    emit(state.copyWith(officeApiCallState: OfficeApiCallState.loading));
    var result = await _mapRepository.getAddressDetails(
      lat: state.addressPosition.latitude,
      long: state.addressPosition.longitude,
    );

    return result.fold(
      (failure) {
        emit(state.copyWith(officeApiCallState: OfficeApiCallState.failure));
        return false;
      },
      (right) async {
        emit(
          state.copyWith(
            officeApiCallState: OfficeApiCallState.success,
            addressPosition: LatLng(state.addressPosition.latitude, state.addressPosition.longitude),
            city: right.city,
            neighborhood: right.neighborhood,
            street: right.street,
          ),
        );
        return true;
      },
    );
  }

  Future<bool> updateLocation(Emitter emit) async {
    emit(state.copyWith(officeApiCallState: OfficeApiCallState.loading));
    var result = await _officeRepository.updateLocation(
      officeId: state.createdOffice!.id,
      lat: state.addressPosition.latitude,
      lng: state.addressPosition.longitude,
      zoom: state.currentMapZoom,
      city: state.city,
      neighborhood: state.neighborhood,
      street: state.street,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(officeApiCallState: OfficeApiCallState.failure));
        return false;
      },
      (updatedOffice) async {
        emit(state.copyWith(
          createdOffice: state.createdOffice!.copyWith(location: updatedOffice.location),
        ));
        var result = await _officeRepository.updateLocation(
          officeId: state.createdUnit!.id,
          lat: state.addressPosition.latitude,
          lng: state.addressPosition.longitude,
          zoom: state.currentMapZoom,
          city: state.city,
          neighborhood: state.neighborhood,
          street: state.street,
        );
        return result.fold(
          (failure) {
            emit(state.copyWith(officeApiCallState: OfficeApiCallState.failure));
            return false;
          },
          (updatedUnit) async {
            emit(state.copyWith(
              officeApiCallState: OfficeApiCallState.success,
              createdUnit: state.createdUnit!.copyWith(location: updatedUnit.location),
            ));
            return true;
          },
        );
      },
    );
  }

  Future<bool> updateInterface(Emitter emit) async {
    emit(state.copyWith(officeApiCallState: OfficeApiCallState.loading));
    var result = await _officeRepository.updateInterface(
      officeId: state.createdOffice!.id,
      interfaceId: state.interfaceId,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(officeApiCallState: OfficeApiCallState.failure));
        return false;
      },
      (updatedOffice) async {
        emit(state.copyWith(
          createdOffice: state.createdOffice!.copyWith(interfaceId: updatedOffice.interfaceId),
        ));
        var result = await _officeRepository.updateInterface(
          officeId: state.createdUnit!.id,
          interfaceId: state.interfaceId,
        );
        return result.fold(
          (failure) {
            emit(state.copyWith(officeApiCallState: OfficeApiCallState.failure));
            return false;
          },
          (updatedUnit) async {
            emit(state.copyWith(
              officeApiCallState: OfficeApiCallState.success,
              createdUnit: state.createdUnit!.copyWith(interfaceId: updatedUnit.interfaceId),
            ));
            return true;
          },
        );
      },
    );
  }

  int getCounterPriceTypeId(UnitPriceOptions option) {
    switch (option) {
      case UnitPriceOptions.hourly:
        return 1;
      case UnitPriceOptions.daily:
        return 2;
      case UnitPriceOptions.monthly:
        return 3;
      case UnitPriceOptions.yearly:
        return 4;
    }
  }

  UnitPriceOptions? getPriceTypeId(int id) {
    switch (id) {
      case 1:
        return UnitPriceOptions.hourly;
      case 2:
        return UnitPriceOptions.daily;
      case 3:
        return UnitPriceOptions.monthly;
      case 4:
        return UnitPriceOptions.yearly;
    }
    return null;
  }

  Future<bool> updatePrices(Emitter emit) async {
    Map<int, dynamic> newPrices = {};
    Map<int, Map<int, dynamic>> updatedPrices = {};
    List<int> deletedPrices = [];
    state.selectedUnitPrices.forEach((key, value) {
      bool isExisting = false;
      int priceTypeId = getCounterPriceTypeId(key);
      for (OfficePrice price in state.createdUnit!.prices) {
        if (price.typeResId == priceTypeId) {
          isExisting = true;
          if (price.price != value) {
            updatedPrices[price.id] = {priceTypeId: state.selectedUnitPrices[key]};
          }
          break;
        }
      }
      if (!isExisting) {
        newPrices[priceTypeId] = value;
      }
    });
    for (OfficePrice price in state.createdUnit!.prices) {
      if (!state.selectedUnitPrices.containsKey(getPriceTypeId(price.typeResId))) {
        deletedPrices.add(price.id);
      }
    }
    log("New Prices: $newPrices");
    log("Updated Details: $updatedPrices");
    log("Deleted Details: $deletedPrices");
    if (newPrices.isNotEmpty || updatedPrices.isNotEmpty || deletedPrices.isNotEmpty) {
      emit(state.copyWith(officeApiCallState: OfficeApiCallState.loading));
      var result = await _officeRepository.updateOfficePrices(
        officeId: state.createdUnit!.id,
        newPrices: newPrices,
        updatedPrices: updatedPrices,
        deletedPrices: deletedPrices,
      );
      return result.fold(
        (failure) {
          emit(state.copyWith(officeApiCallState: OfficeApiCallState.failure));
          return false;
        },
        (updatedUnit) async {
          emit(state.copyWith(
            officeApiCallState: OfficeApiCallState.success,
            createdUnit: state.createdUnit!.copyWith(prices: updatedUnit!.prices),
          ));
          return true;
        },
      );
    }
    return true;
  }

  String getCounterDepositType(DepositTypes type) {
    return type == DepositTypes.price ? 'سعر' : 'نسبة';
  }

  Future<bool> updateDepositInfo(Emitter emit) async {
    emit(state.copyWith(officeApiCallState: OfficeApiCallState.loading));

    late final unit.DepositTypes t;
    switch (state.depositType) {
      case DepositTypes.price:
        t = unit.DepositTypes.price;
      case DepositTypes.percentage:
        t = unit.DepositTypes.percentage;
      case null:
        t = unit.DepositTypes.price;
    }

    var result = await _officeRepository.updateDownPayment(
      officeId: state.createdUnit!.id,
      downPayment: state.depositAmount,
      downPaymentType: t,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(officeApiCallState: OfficeApiCallState.failure));
        return false;
      },
      (updatedUnit) async {
        emit(state.copyWith(
          officeApiCallState: OfficeApiCallState.success,
          createdUnit: state.createdUnit!
              .copyWith(downPayment: updatedUnit.downPayment, typeDownPayment: updatedUnit.typeDownPayment),
        ));
        return true;
      },
    );
  }

  Future<bool> updateViewerInfo(Emitter emit) async {
    emit(state.copyWith(officeApiCallState: OfficeApiCallState.loading));
    var result = await _officeRepository.updateViewer(
      officeId: state.createdUnit!.id,
      viewerName: state.viewerName,
      viewerPhone: state.viewerPhone,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(officeApiCallState: OfficeApiCallState.failure));
        return false;
      },
      (updatedUnit) async {
        emit(state.copyWith(
          officeApiCallState: OfficeApiCallState.success,
          createdUnit:
              state.createdUnit!.copyWith(viewerName: updatedUnit.viewerName, viewerPhone: updatedUnit.viewerPhone),
        ));
        return true;
      },
    );
  }

  Future<void> uploadOfficeFiles(Emitter emit) async {
    var result = await _officeRepository.addOfficeFiles(
      officeId: state.createdUnit!.id,
      video: state.selectedVideo.isNotEmpty ? state.selectedVideo : null,
      mainImage: state.selectedMainImage,
      images: state.selectedImagesMap.values.toList(),
    );
    result.fold(
      (failure) {
        emit(state.copyWith(
          stepNavigationState: StepNavigationState.initial,
          imagesApiCallState: OfficeApiCallState.failure,
        ));
      },
      (updatedOffice) async {
        emit(state.copyWith(
          stepNavigationState: StepNavigationState.initial,
          imagesApiCallState: OfficeApiCallState.success,
        ));
      },
    );
    if (state.officeType != OfficeTypes.request) {
      close();
    }
  }

  Future<void> uploadMarketingFiles(Emitter emit) async {
    await _officeRepository.addMarketingFiles(
      officeId: state.createdUnit!.id,
      officeLicensingFile: state.selectedOfficeLicensingFile,
      buildingLicesnsingFile: state.selectedBuildingLicesnsingFile,
      civilDefenseFile: state.selectedCivilDefenseFile,
    );
    close();
  }
}

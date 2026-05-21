import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';
import 'package:maktab_lessor/core/classes/exception/api_exceptions.dart';
import 'package:maktab_lessor/core/helpers/file_picker_helper.dart';
import 'package:maktab_lessor/core/helpers/image_cropper_helper.dart';
import 'package:maktab_lessor/core/helpers/location_helper.dart';
import 'package:maktab_lessor/core/services/service_locator.dart';
import 'package:maktab_lessor/data/models/interface_aqar/interface_aqar_model.dart';
import 'package:maktab_lessor/data/models/office/office_detail_model.dart';
import 'package:maktab_lessor/data/models/office/office_location_model.dart';
import 'package:maktab_lessor/data/models/office/office_model.dart';
import 'package:maktab_lessor/data/models/office/office_price_model.dart';
import 'package:maktab_lessor/data/models/office/search_data_model.dart';
import 'package:maktab_lessor/data/repositories/map_repository.dart';
import 'package:maktab_lessor/data/repositories/office_repository.dart';
import 'package:flutter/material.dart';
import 'package:maktab_lessor/domain/unit/unit_bloc.dart' as unit;

import '../../data/models/verify_license_number/verify_license_number_model.dart';

part 'office_event.dart';

part 'office_state.dart';

class OfficeBloc extends Bloc<OfficeEvent, OfficeState> {
  List<int> facilities = [];
  List<int> features = [];
  List<int> propertyUtilities = [];
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
            // selectedUnitPrices: {},
            // selectedUnitPriceOptions: [],
            additionalServices: {},
            additionalServiceKeys: {},
            detailsMap: {'floors': 0})) {
    on<InitialOfficeEvent>((event, emit) {
      if (event.searchData != null) {
        state.searchData = event.searchData;
      }
      if (event.office != null) {
        print('1111111111111');
        print(event.office?.propertyAgeId);
        print('1111111111111');
        state.progressValue = 0;
        state.createdOffice = event.office;
        // state.createdUnit = event.office!.units.firstWhereOrNull((unit) => unit.isCentral);
        state.createdUnit = event.office;
        state.marketingRequestState =
            (event.office?.isMarketing ?? false) ? VisibilityStates.show : VisibilityStates.hide;
        state.licenseOfficeState =
            !(event.office?.isMarketing ?? false) ? VisibilityStates.show : VisibilityStates.hide;
        log("-----------------------------------------------");
        log(state.marketingRequestState.toString());
        log(state.licenseOfficeState.toString());
        log(event.office!.licenseNumber.toString());
        log(event.office?.isMarketing.toString() ?? '');
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
        if (state.createdUnit?.location != null) {
          state.location = state.createdUnit!.location;
        }
        if (state.createdUnit?.location != null) {
          state.interfaceAqar = state.createdUnit!.interfaceAqar;
        }
        if (state.createdUnit?.prices != null) {
          state.adsPrices = state.createdUnit!.prices;
        }
        if (state.createdUnit?.space != null) {
          state.streetWidth = state.createdUnit!.width.toString();
        }
        if (state.createdUnit?.propertyAgeId != null) {
          state.officeAgeId = state.createdUnit!.propertyAgeId.toString();
        }
        if (state.createdUnit?.licenseNumber != null) {
          state.licenseNumber = state.createdUnit!.licenseNumber.toString();
        }
        final Map<String, AdertiserRelationshipOptions> advertiserTypeMap = {
          'none': AdertiserRelationshipOptions.none,
          'individual_owner': AdertiserRelationshipOptions.individual_owner,
          'individual_broker': AdertiserRelationshipOptions.individual_broker,
          'owner_agent': AdertiserRelationshipOptions.owner_agent,
          'establishment_broker': AdertiserRelationshipOptions.establishment_broker,
          'establishment_owner': AdertiserRelationshipOptions.establishment_owner,
        };

        if (state.createdUnit?.advertiserType != null) {
          final typeStr = state.createdUnit!.advertiserType!;
          state.advertiserRelationshipOption = advertiserTypeMap[typeStr] ?? AdertiserRelationshipOptions.none;
        }
        if ((state.createdUnit?.furnisher ?? '').isNotEmpty) {
          state.equipment = state.createdUnit!.furnisher!;
        }
        if (state.createdUnit?.propertyUtilities != null && state.createdUnit!.propertyUtilities.isNotEmpty) {
          state.propertyUtilities = state.createdUnit!.propertyUtilities.map((e) => e.id!).toList();
        }
        // if (state.createdUnit?.typeAqarId != null) {
        //   state.type = int.parse(state.createdUnit!.typeAqarId!);
        // }

        if (state.createdUnit?.typeAqars != null && state.createdUnit!.typeAqars.isNotEmpty) {
          state.officeTypeIds = state.createdUnit!.typeAqars.map((e) => e.id).toList();
        }

        state.streetWidth = state.createdOffice!.width.toString();

        for (OfficeDetail detail in (state.createdUnit?.details ?? [])) {
          state.detailsMap[detail.enName] = detail.numberDetails;
          print('5555555555');
          print(detail.enName);
          print(state.detailsMap[detail.enName]);
          print('5555555555');
          switch (detail.enName) {
            case 'floors':
              state.floor = detail.numberDetails;
              break;
            // case 'age':
            //   state.officeAge = detail.numberDetails.toString();
            //   break;
            // case 'officescount':
            case 'Number of rooms':
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
          // state.selectedUnitPriceOptions.add(option!);
          // state.selectedUnitPrices[option] = price.price;
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
      state.licenseNumber = event.licenseNumber.length == 10 ? event.licenseNumber : '';
      emit(state.copyWith(isStepCompleted: checkIfOfficeTypeStepCompleted()));
    });
    on<SetCreateAdEvent>((event, emit) {
      state.createAd = 1;
      emit(state.copyWith(isStepCompleted: checkIfOfficeTypeStepCompleted()));
    });
    on<AddMarketingRequestEvent>((event, emit) {
      _toggleAddingMarketingRequest(emit);
    });
    on<SetOfficeTypesEvent>((event, emit) {
      emit(state.copyWith(officeType: event.type));
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
    on<SelectTransactionTypeEvent>((event, emit) {
      emit(state.copyWith(
          transactionType:
              event.transactionType != state.transactionType ? event.transactionType : state.transactionType));
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
    on<SetWidthEvent>((event, emit) {
      state.streetWidth = event.width.length <= 7 ? event.width : '';
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
    on<SetMultiTypeEvent>((event, emit) {
      state.officeTypeIds = event.typeIds;
      emit(state.copyWith(isStepCompleted: checkIfOfficeSecondStepCompleted()));
    });
    on<IncreaseFloorEvent>((event, emit) {
      state.detailsMap['floors'] = ++event.floor;
      emit(state.copyWith(floor: state.detailsMap['floors']));
    });
    on<DecreaseFloorEvent>((event, emit) {
      int floor = 0;
      if (event.floor > 0) {
        floor = event.floor > 0 ? --event.floor : 0;
        state.detailsMap['floors'] = floor;
      }
      emit(state.copyWith(floor: floor));
    });
    on<SetOfficeAgeEvent>((event, emit) {
      // state.detailsMap['age'] = event.idAge;
      emit(state.copyWith(officeAge: event.idAge.toString()));
    });
    on<IncreaseOfficeAgeEvent>((event, emit) {
      // state.detailsMap['age'] = ++event.age;
      // emit(state.copyWith(officeAge: state.detailsMap['age']));
    });
    on<DecreaseOfficeAgeEvent>((event, emit) {
      // int age = 1;
      // if (event.age > 1) {
      //   age = event.age > 1 ? --event.age : 1;
      //   state.detailsMap['age'] = age;
      // }
      // emit(state.copyWith(officeAge: age));
    });
    on<ToggleOfficesCountSelectorEvent>((event, emit) {
      state.detailsMap.removeWhere((key, value) => key == 'Number of rooms');
      emit(state.copyWith(
        officesCount: 0,
        officesCountSelectorState: getCounterToggleState(state.officesCountSelectorState),
      ));
      emit(state.copyWith(isStepCompleted: checkIfOfficeDetailsStepCompleted()));
    });
    on<IncreaseOfficesCountEvent>((event, emit) {
      state.detailsMap['Number of rooms'] = ++event.count;
      emit(state.copyWith(officesCount: state.detailsMap['Number of rooms']));
      emit(state.copyWith(isStepCompleted: checkIfOfficeDetailsStepCompleted()));
    });
    on<SetOfficesCountEvent>((event, emit) {
      state.detailsMap['Number of rooms'] = event.count;
      emit(state.copyWith(officesCount: state.detailsMap['Number of rooms']));
      emit(state.copyWith(isStepCompleted: checkIfOfficeDetailsStepCompleted()));
    });
    on<DecreaseOfficesCountEvent>((event, emit) {
      int count = 0;
      if (event.count > 1) {
        count = event.count > 1 ? --event.count : 0;
        state.detailsMap['Number of rooms'] = count;
      } else {
        state.detailsMap.removeWhere((key, value) => key == 'Number of rooms');
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
      state.detailsMap['tablescount'] = event.isSet ? event.count : ++event.count;
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
      state.detailsMap['sharedworkspacescount'] = event.isSet ? event.count : ++event.count;
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
    on<SelectPropertyUtilitiesEvent>((event, emit) {
      propertyUtilities = _toggleListItem(List.from(state.propertyUtilities), event.id);
      emit(state.copyWith(propertyUtilities: propertyUtilities));
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
    // on<ToggleUnitPriceOptionEvent>((event, emit) {
    //   selectedUnitPriceOptions = List.from(state.selectedUnitPriceOptions);
    //   selectedUnitPrices = state.selectedUnitPrices;
    //   if (selectedUnitPriceOptions.contains(event.option)) {
    //     selectedUnitPriceOptions.remove(event.option);
    //     selectedUnitPrices.remove(event.option);
    //     if (state.selectedUnitPricesCount > 0) {
    //       state.selectedUnitPricesCount--;
    //     }
    //   } else {
    //     selectedUnitPriceOptions.add(event.option);
    //     if (state.selectedUnitPricesCount == -1) {
    //       state.selectedUnitPricesCount = 1;
    //     } else {
    //       state.selectedUnitPricesCount++;
    //     }
    //   }
    //   emit(state.copyWith(
    //     selectedUnitPriceOptions: selectedUnitPriceOptions,
    //     selectedUnitPrices: selectedUnitPrices,
    //   ));
    //   emit(state.copyWith(isStepCompleted: checkIfOfficePricesStepCompleted()));
    // });
    on<ChangeUnitPriceEvent>((event, emit) {
      // selectedUnitPrices = Map.from(state.selectedUnitPrices);
      // if (event.price.isNotEmpty && state.selectedUnitPriceOptions.contains(event.option)) {
      // selectedUnitPrices.addAll({UnitPriceOptions.yearly: num.parse(event.price)});
      // }
      // else {
      //   selectedUnitPrices.remove(event.option);
      // }
      emit(state.copyWith(officePrices: event.price));
      emit(state.copyWith(isStepCompleted: checkIfOfficePricesStepCompleted()));
    });
    on<SelectDepositTypeEvent>((event, emit) {
      emit(state.copyWith(depositType: event.type));
    });
    on<ChangeDepositAmountEvent>((event, emit) {
      // if (state.selectedUnitPricesCount == -1) {
      //   state.selectedUnitPricesCount = 0;
      // }
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
      // state.viewerPhone = event.phone.length >= 9 && event.phone.startsWith('5') ? event.phone : '';
      state.viewerPhone = event.phone;
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
          // navigateAfterSuccessStep(emit, event.index);
          if (state.marketingRequestState == VisibilityStates.show || state.createdUnit != null) {
            navigateAfterSuccessStep(emit, event.index);
          } else {
            bool temp = false;
            temp = await verifyLicenseNumber(emit);
            if (temp) {
              navigateAfterSuccessStep(emit, event.index);
            }
          }
          break;
        case 1:
          bool temp = false;
          if (state.licenseOfficeState == VisibilityStates.hide) {
            temp = await createOffice(emit);
            if (temp) {
              navigateAfterSuccessStep(emit, event.index);
            }
          } else {
            bool temp1 = false;
            bool temp2 = false;
            if (state.name != '') {
              temp1 = await updateTitle(emit);
            } else {
              temp1 = true;
            }
            if (state.categoryId != -1) {
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
          bool temp2 = false;
          // if ((state.createdUnit?.advertiserRelationship ?? '').isEmpty) {
          temp1 = await updateInfo(emit);
          temp1 = await updateTypeAqar(emit);
          if (temp1) {
            navigateAfterSuccessStep(emit, event.index);
          }
          // }
          // else {
          //   if (state.createdUnit!.advertiserRelationship != getCounterAdvertiserRelationship(state.advertiserRelationshipOption) ||
          //       state.createdUnit!.space != num.parse(state.space) ||
          //       state.createdUnit!.furnisher != state.equipment ||
          //       state.createdUnit!.typeAqarId! != state.type.toString()) {
          //     bool temp1 = await updateInfo(emit);
          //     if (temp1) {
          //       navigateAfterSuccessStep(emit, event.index);
          //     }
          //   } else {
          //     navigateAfterSuccessStep(emit, event.index);
          //   }
          // }
          break;
        case 3:
          bool temp1 = false;
          bool temp2 = true;
          bool temp3 = true;
          temp1 = await updateOfficeDetails(emit);
          if (state.licenseOfficeState == VisibilityStates.hide) {
            temp2 = await updateInfo(emit);
          }
          if ( state.facilities.isNotEmpty) {
            temp3 = await updateFacilities(emit);
          }
          // else {
          //   if (!listEquals(state.createdUnit!.facilities.map((facility) => facility.id).toList(), state.facilities)) {
          //     temp2 = await updateFacilities(emit);
          //   }
          // }
          if (temp1 && temp2 && temp3) {
            navigateAfterSuccessStep(emit, event.index);
          }
          break;
        case 4:
          bool temp1 = false;
          // if ((state.createdUnit!.description ?? '').isEmpty || state.createdUnit!.description != state.description) {
          if (state.description != '') {
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
          bool temp4 = true;
          // if (state.createdUnit!.features.isEmpty && state.features.isNotEmpty) {
          if (state.features.isNotEmpty) {
            temp1 = await updateFeatures(emit);
          }
          if (state.propertyUtilities.isNotEmpty && state.licenseOfficeState == VisibilityStates.hide) {
            temp1 = await updatePropertyUtilities(emit);
          }
          // else {
          //   if (!listEquals(state.createdUnit!.features.map((feature) => feature.id).toList(), state.features)) {
          //     temp1 = await updateFeatures(emit);
          //   }
          // }
          if (state.additionalServiceKeys.isNotEmpty) {
            for (GlobalKey<FormState> formKey in state.additionalServiceKeys.values) {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
              } else {
                temp3 = false;
              }
            }
          }
          // if (state.createdUnit!.comforts.isEmpty && state.comforts.isNotEmpty) {
          if (state.comforts.isNotEmpty) {
            temp2 = await updateComforts(emit);
          }
          // else {
          //   if (!listEquals(state.createdUnit!.comforts.map((comfort) => comfort.id).toList(), state.comforts)) {
          //     temp2 = await updateComforts(emit);
          //   }
          // }
          if (temp1 && temp2 && temp3 && temp4) {
            navigateAfterSuccessStep(emit, event.index);
          }
          break;
        case 6:
          bool temp1 = true;
          // if (state.createdUnit!.location == null ||
          //     (state.addressPosition.latitude != state.createdUnit!.location!.lat.toDouble() &&
          //         state.addressPosition.longitude != state.createdUnit!.location!.lng.toDouble())) {
          temp1 = await getOfficeAddressDetails(emit);
          if (temp1) {
            navigateAfterSuccessStep(emit, event.index);
          }
          break;
        case 7:
          bool temp1 = false;
          bool temp2 = false;
          // if (state.createdUnit!.location == null) {
          temp1 = await updateLocation(emit);
          // }
          // if (state.createdUnit!.interfaceId == null) {
          temp2 = await updateInterface(emit);
          // }
          // else {
          temp1 = true;
          temp2 = true;
          // if (state.createdUnit!.location!.city != state.city ||
          //     state.createdUnit!.location!.neighborhood != state.neighborhood ||
          //     state.createdUnit!.location!.street != state.street) {
          //   temp1 = await updateLocation(emit);
          // } else if (state.createdUnit!.interfaceId != state.interfaceId) {
          //   temp2 = await updateInterface(emit);
          // }
          // }
          if (temp1 && temp2) {
            navigateAfterSuccessStep(emit, event.index);
          }
          break;
        case 8:
          bool temp1 = true;
          bool temp2 = true;
          bool temp3 = true;
          temp1 = await updatePrices(emit);
          // temp1 = await updateInfo(emit);
          // if (state.selectedUnitPriceOptions.contains(UnitPriceOptions.yearly)) {
          //   if (state.depositAmount != state.createdUnit!.downPayment ||
          //       getCounterDepositType(state.depositType ?? DepositTypes.price) != state.createdUnit!.typeDownPayment) {
          temp2 = await updateDepositInfo(emit);
          // }
          // }
          // if (state.viewerName != state.createdUnit!.viewerName ||
          //     state.viewerPhone != state.createdUnit!.viewerPhone) {
          // if (state.licenseOfficeState == VisibilityStates.hide) {
          //   temp3 = await updateViewerInfo(emit);
          // }
          // }
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
        print('111111111111');
        print(emit);
        print('111111111111');
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
    return state.space.isNotEmpty && state.equipment.isNotEmpty ? true : false;
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
    return state.city.isEmpty || state.neighborhood.isEmpty | state.street.isEmpty ? false : true;
  }

  bool checkIfOfficePricesStepCompleted() {
    // bool result = state.officePrices == -1
    //     // ||
    //     //     (state.viewerName.isEmpty && state.licenseOfficeState == VisibilityStates.show) ||
    //     //     (state.viewerPhone.isEmpty && state.licenseOfficeState == VisibilityStates.show)
    //     ? false
    //     : true;
    //
    // log("Final result: $result");
    return true;
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

  Future<bool> verifyLicenseNumber(Emitter emit) async {
    try {
      emit(state.copyWith(officeApiCallState: OfficeApiCallState.loading));
      var result = await _officeRepository.verifyLicenseNumber(
        licenseNumber: state.officeType == OfficeTypes.license ? state.licenseNumber : null,
        createAd: state.officeType == OfficeTypes.license ? state.createAd : null,
        advertiserType: state.officeType == OfficeTypes.license ? state.advertiserRelationshipOption.name : null,
      );
      return result.fold(
        (failure) {
          final String errorMessage =
              failure is ApiException && (failure.errorKey?.isNotEmpty ?? false)
                  ? failure.errorKey!
                  : failure.message;
          emit(state.copyWith(
            officeApiCallState: OfficeApiCallState.failure,
            imagesErrorMessage: failure.message,
            errorKeyMessage: failure is ApiException ? (failure.errorKey ?? '') : '',
            createdOffice: null,
          ));
          emit(state.copyWith(imagesErrorMessage: '', errorKeyMessage: ''));
          return false;
        },
        (verifyLicenseNumber) async {
          emit(state.copyWith(
            officeApiCallState: OfficeApiCallState.success,
            verifyLicenseNumberModel: verifyLicenseNumber,
            officeType: OfficeTypes.license,
            errorKeyMessage: '',
          ));
          return true;
        },
      );
    } catch (e) {
      emit(state.copyWith(
        officeApiCallState: OfficeApiCallState.failure,
        imagesErrorMessage: e.toString(),
        errorKeyMessage: '',
        createdOffice: null,
      ));
      return false;
    }
  }

  Future<bool> createOffice(Emitter emit) async {
    print('111111111');
    print(state.officeType);
    print('111111111');
    emit(state.copyWith(officeApiCallState: OfficeApiCallState.loading));
    var result = await _officeRepository.createOffice(
      title: state.name,
      categoryId: state.categoryId,
      isMarketing: state.officeType == OfficeTypes.request || state.licenseNumber == '' ? true : false,
      licenseNumber: state.officeType == OfficeTypes.license ? state.licenseNumber : null,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(
          officeApiCallState: OfficeApiCallState.failure,
          createdOffice: null,
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
      // (createdOffice) async {
      //   emit(state.copyWith(createdOffice: createdOffice));
      //   var result = await _officeRepository.addUnit(
      //     officeId: createdOffice!.id,
      //     title: state.name,
      //     categoryId: state.categoryId,
      //     isMarketing: state.officeType == OfficeTypes.request ? true : false,
      //     licenseNumber: '',
      //     isCentral: true,
      //   );
      //   return result.fold(
      //     (failure) {
      //       emit(state.copyWith(
      //         officeApiCallState: OfficeApiCallState.failure,
      //         createdUnit: null,
      //       ));
      //       return false;
      //     },
      //     (createdUnit) {
      //       emit(state.copyWith(
      //         officeApiCallState: OfficeApiCallState.success,
      //         createdUnit: createdUnit,
      //       ));
      //       return true;
      //     },
      //   );
      // },
    );
  }

  Future<bool> updateTitle(Emitter emit) async {
    emit(state.copyWith(officeApiCallState: OfficeApiCallState.loading));
    var result = await _officeRepository.updateTitle(
      title: state.name,
      officeId: state.verifyLicenseNumberModel?.id ?? state.createdUnit?.id ?? state.createdOffice?.id,
      // officeId: state.createdOffice!.id,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(officeApiCallState: OfficeApiCallState.failure));
        return false;
      },
      (updatedOffice) async {
        // emit(state.copyWith(createdOffice: state.createdOffice?.copyWith(title: updatedOffice!.title)));
        var result = await _officeRepository.updateTitle(
          title: state.name,
          officeId: state.verifyLicenseNumberModel?.id ?? state.createdUnit?.id ?? state.createdOffice?.id,

          // officeId: state.createdUnit!.id,
        );
        return result.fold(
          (failure) {
            emit(state.copyWith(officeApiCallState: OfficeApiCallState.failure));
            return false;
          },
          (updatedUnit) async {
            emit(state.copyWith(
              officeApiCallState: OfficeApiCallState.success,
              // createdUnit: state.createdUnit!.copyWith(title: updatedUnit!.title)
            ));
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
      // officeId: state.createdOffice!.id,
      officeId: state.verifyLicenseNumberModel?.id ?? state.createdUnit?.id ?? state.createdOffice?.id,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(officeApiCallState: OfficeApiCallState.failure));
        return false;
      },
      (updatedOffice) async {
        // emit(state.copyWith(createdOffice: state.createdOffice!.copyWith(categoryId: updatedOffice!.categoryId)));
        var result = await _officeRepository.updateCategory(
          categoryId: state.categoryId,
          // officeId: state.createdUnit!.id,
          officeId: state.verifyLicenseNumberModel?.id ?? state.createdUnit?.id ?? state.createdOffice?.id,
        );
        return result.fold(
          (failure) {
            emit(state.copyWith(officeApiCallState: OfficeApiCallState.failure));
            return false;
          },
          (updatedUnit) async {
            emit(state.copyWith(
              officeApiCallState: OfficeApiCallState.success,
              // createdUnit: state.createdUnit!.copyWith(categoryId: updatedUnit!.categoryId)
            ));
            return true;
          },
        );
      },
    );
  }

  AdertiserRelationshipOptions getAdvertiserRelationship(String option) {
    switch (option) {
      case 'مالك منشأة':
        return AdertiserRelationshipOptions.establishment_owner;
      case 'وسيط منشأة':
        return AdertiserRelationshipOptions.establishment_broker;
      case 'مالك فرد':
        return AdertiserRelationshipOptions.individual_owner;
      case 'وسيط فرد':
        return AdertiserRelationshipOptions.individual_broker;
      case 'وكبل مالك':
        return AdertiserRelationshipOptions.owner_agent;
      default:
        return AdertiserRelationshipOptions.owner_agent;
    }
  }

  String getCounterAdvertiserRelationship(AdertiserRelationshipOptions option) {
    switch (option) {
      case AdertiserRelationshipOptions.establishment_owner:
        return 'مالك منشأة';
      case AdertiserRelationshipOptions.owner_agent:
        return 'وكيل مالك';
      case AdertiserRelationshipOptions.individual_owner:
        return 'مالك فرد';
      case AdertiserRelationshipOptions.individual_broker:
        return 'وسيط فرد';
      case AdertiserRelationshipOptions.establishment_broker:
        return 'وسيط منشأة';
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
    // String advertiserRelationship = getCounterAdvertiserRelationship(state.advertiserRelationshipOption);
    // String? advertiserRelationshipType = getCounterAdvertiserRelationshipType(state.marketerTypeOption);
    Either<AppException, Office?> result = await _officeRepository.updateOfficeInfo(
      // officeId: state.createdUnit!.id,
      price: state.officePrices != -1 ? state.officePrices : null,
      propertyAgeId: state.officeAge,
      streetWidth: state.streetWidth,
      transactionType: state.transactionType.name,
      officeId: state.verifyLicenseNumberModel?.id ?? state.createdUnit?.id ?? state.createdOffice?.id,

      space: state.space,
      equipment: state.equipment,
      // advertiserRelationship: advertiserRelationship,
      // advertiserRelationshipType: advertiserRelationshipType,
      // typeId: state.searchData!.officeTypes.firstWhere((type) => type.id == state.type).id,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(officeApiCallState: OfficeApiCallState.failure));
        return false;
      },
      (updatedUnit) async {
        emit(state.copyWith(
          officeApiCallState: OfficeApiCallState.success,
          // createdUnit: state.createdUnit!.copyWith(
          //   advertiserRelationship: updatedUnit!.advertiserRelationship,
          //   advertiserRelationshipType: updatedUnit.advertiserRelationshipType,
          //   space: updatedUnit.space,
          //   height: updatedUnit.height,
          //   width: updatedUnit.width,
          //   furnisher: updatedUnit.furnisher,
          //   typeAqarId: updatedUnit.typeAqarId,
          // ),
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
      if (state.verifyLicenseNumberModel != null) {
        for (AdsDetail detail in state.verifyLicenseNumberModel!.adsDetails) {
          if (detail.enName == key) {
            isExisting = true;
            if (detail.numberDetails != value || state.verifyLicenseNumberModel != null) {
              updatedDetails[key] = {detail.id!: state.detailsMap[key]};
            }
            break;
          }
        }
      }
      if (state.createdUnit != null) {
        for (OfficeDetail detail in state.createdUnit!.details) {
          if (detail.enName == key) {
            isExisting = true;
            if (detail.numberDetails != value || state.verifyLicenseNumberModel != null) {
              updatedDetails[key] = {detail.id: state.detailsMap[key]};
            }
            break;
          }
        }
      }
      if (!isExisting) {
        newDetails[key] = value;
      }
    });
    if (state.verifyLicenseNumberModel != null) {
      for (AdsDetail detail in state.verifyLicenseNumberModel!.adsDetails) {
        if (!state.detailsMap.containsKey(detail.enName)) {
          deletedDetails.add(detail.id!);
        }
      }
    }
    log("New Details: $newDetails");
    log("Updated Details: $updatedDetails");
    log("Deleted Details: $deletedDetails");
    if (newDetails.isNotEmpty || updatedDetails.isNotEmpty || deletedDetails.isNotEmpty) {
      emit(state.copyWith(officeApiCallState: OfficeApiCallState.loading));
      var result = await _officeRepository.updateOfficeDetails(
        // officeId: state.createdUnit!.id,
        officeId: state.verifyLicenseNumberModel?.id ?? state.createdUnit?.id ?? state.createdOffice?.id,
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
            // createdUnit: state.createdUnit!.copyWith(details: updatedUnit!.details),
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
      // officeId: state.createdUnit!.id,
      officeId: state.verifyLicenseNumberModel?.id ?? state.createdUnit?.id ?? state.createdOffice?.id,

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
          // createdUnit: state.createdUnit!.copyWith(facilities: updatedUnit!.facilities),
        ));
        return true;
      },
    );
  }

  Future<bool> updateDescription(Emitter emit) async {
    emit(state.copyWith(officeApiCallState: OfficeApiCallState.loading));
    var result = await _officeRepository.updateDescription(
      // officeId: state.createdUnit!.id,
      officeId: state.verifyLicenseNumberModel?.id ?? state.createdUnit?.id ?? state.createdOffice?.id,

      description: state.description,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(officeApiCallState: OfficeApiCallState.failure));
        return false;
      },
      (updatedUnit) async {
        emit(state.copyWith(
          officeApiCallState: OfficeApiCallState.success,
          // createdUnit: state.createdUnit!.copyWith(description: updatedUnit.description),
        ));
        return true;
      },
    );
  }

  Future<bool> updateFeatures(Emitter emit) async {
    emit(state.copyWith(officeApiCallState: OfficeApiCallState.loading));
    var result = await _officeRepository.updateOfficeFeatures(
      officeId: state.verifyLicenseNumberModel?.id ?? state.createdUnit?.id ?? state.createdOffice?.id,
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
          // createdUnit: state.createdUnit!.copyWith(features: updatedUnit!.features),
        ));
        return true;
      },
    );
  }

  Future<bool> updatePropertyUtilities(Emitter emit) async {
    emit(state.copyWith(officeApiCallState: OfficeApiCallState.loading));
    var result = await _officeRepository.updateOfficePropertyUtilities(
      // officeId: state.createdUnit!.id,
      officeId: state.verifyLicenseNumberModel?.id ?? state.createdUnit?.id ?? state.createdOffice?.id,

      propertyUtilities: state.propertyUtilities,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(officeApiCallState: OfficeApiCallState.failure));
        return false;
      },
      (updatedUnit) async {
        emit(state.copyWith(
          officeApiCallState: OfficeApiCallState.success,
          // createdUnit: state.createdUnit!.copyWith(features: updatedUnit!.features),
        ));
        return true;
      },
    );
  }

  Future<bool> updateTypeAqar(Emitter emit) async {
    emit(state.copyWith(officeApiCallState: OfficeApiCallState.loading));
    var result = await _officeRepository.updateOfficeTypeAqar(
      // officeId: state.createdUnit!.id,
      officeId: state.verifyLicenseNumberModel?.id ?? state.createdUnit?.id ?? state.createdOffice?.id,

      typeAqar: state.officeTypeIds,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(officeApiCallState: OfficeApiCallState.failure));
        return false;
      },
      (updatedUnit) async {
        emit(state.copyWith(
          officeApiCallState: OfficeApiCallState.success,
          // createdUnit: state.createdUnit!.copyWith(features: updatedUnit!.features),
        ));
        return true;
      },
    );
  }

  Future<bool> updateComforts(Emitter emit) async {
    emit(state.copyWith(officeApiCallState: OfficeApiCallState.loading));
    var result = await _officeRepository.updateOfficeComforts(
      // officeId: state.createdUnit!.id,
      officeId: state.verifyLicenseNumberModel?.id ?? state.createdUnit?.id ?? state.createdOffice?.id,

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
          // createdUnit: state.createdUnit!.copyWith(comforts: updatedUnit!.comforts),
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
      // officeId: state.createdOffice!.id,
      officeId: state.verifyLicenseNumberModel?.id ?? state.createdUnit?.id ?? state.createdOffice?.id,
      region: state.verifyLicenseNumberModel?.location?.region,
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
            // createdOffice: state.createdOffice!.copyWith(location: updatedOffice.location),
            ));
        var result = await _officeRepository.updateLocation(
          // officeId: state.createdUnit!.id,
          officeId: state.verifyLicenseNumberModel?.id ?? state.createdUnit?.id ?? state.createdOffice?.id,
          region: state.verifyLicenseNumberModel?.location?.region,
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
              // createdUnit: state.createdUnit!.copyWith(location: updatedUnit.location),
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
      // officeId: state.createdOffice!.id,
      officeId: state.verifyLicenseNumberModel?.id ?? state.createdUnit?.id ?? state.createdOffice?.id,

      interfaceId: state.interfaceId,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(officeApiCallState: OfficeApiCallState.failure));
        return false;
      },
      (updatedOffice) async {
        emit(state.copyWith(
            // createdOffice: state.createdOffice!.copyWith(interfaceId: updatedOffice.interfaceId),
            ));
        var result = await _officeRepository.updateInterface(
          // officeId: state.createdUnit!.id,
          officeId: state.verifyLicenseNumberModel?.id ?? state.createdUnit?.id ?? state.createdOffice?.id,

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
              // createdUnit: state.createdUnit!.copyWith(interfaceId: updatedUnit.interfaceId),
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
      case UnitPriceOptions.cash:
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
    // Map<int, dynamic> newPrices = {};
    // Map<int, Map<int, dynamic>> updatedPrices = {};
    num price = -1;
    // List<int> deletedPrices = [];
    log('////////////////////////////////////////////');
    if (state.officePrices != -1) {
      log(state.officePrices.toString());
      price = state.officePrices;
    }
    // state.selectedUnitPrices.forEach((key, value) {
    // bool isExisting = false;
    // int priceTypeId = getCounterPriceTypeId(key);
    // for (OfficePrice price in state.createdUnit!.prices) {
    //   if (price.typeResId == priceTypeId) {
    //     isExisting = true;
    //     if (price.price != value) {
    //       updatedPrices[price.id] = {priceTypeId: state.selectedUnitPrices[key]};
    //     }
    //     break;
    //   }
    // }
    // if (!isExisting) {
    //   newPrices[priceTypeId] = value;
    // }
    // });
    // for (OfficePrice price in state.createdUnit!.prices) {
    //   if (!state.selectedUnitPrices.containsKey(getPriceTypeId(price.typeResId))) {
    //     deletedPrices.add(price.id);
    //   }
    // }
    // log("New Prices: $newPrices");
    // log("Updated Details: $updatedPrices");
    log("Price: $price");
    // log("Deleted Details: $deletedPrices");
    if (
        // updatedPrices.isNotEmpty ||
        //     deletedPrices.isNotEmpty ||
        price != -1
        // getCounterDepositType(state.depositType) != getDownPaymentType(state.createdUnit!.typeDownPayment) ||
        // state.viewerName != state.createdUnit!.viewerName ||
        // '+966${state.viewerPhone}' != state.createdUnit!.viewerPhone
        ) {
      emit(state.copyWith(officeApiCallState: OfficeApiCallState.loading));
      var result = await _officeRepository.updateOfficePrices(
        officeId: state.verifyLicenseNumberModel?.id ?? state.createdUnit?.id ?? state.createdOffice?.id,

        // newPrices: newPrices,
        // updatedPrices: updatedPrices,
        price: price,
      );
      return result.fold(
        (failure) {
          emit(state.copyWith(officeApiCallState: OfficeApiCallState.failure));
          return false;
        },
        (updatedUnit) async {
          emit(state.copyWith(
            officeApiCallState: OfficeApiCallState.success,
            // createdUnit: state.createdUnit!.copyWith(prices: updatedUnit!.prices),
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
      // officeId: state.createdUnit!.id,
      officeId: state.verifyLicenseNumberModel?.id ?? state.createdUnit?.id ?? state.createdOffice?.id,

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
          // createdUnit: state.createdUnit!
          //     .copyWith(downPayment: updatedUnit.downPayment, typeDownPayment: updatedUnit.typeDownPayment),
        ));
        return true;
      },
    );
  }

  Future<bool> updateViewerInfo(Emitter emit) async {
    emit(state.copyWith(officeApiCallState: OfficeApiCallState.loading));
    var result = await _officeRepository.updateViewer(
      // officeId: state.createdUnit!.id,
      officeId: state.verifyLicenseNumberModel?.id ?? state.createdUnit?.id ?? state.createdOffice?.id,

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
          // createdUnit: state.createdUnit!.copyWith(
          //   viewerName: updatedUnit.viewerName,
          //   viewerPhone: updatedUnit.viewerPhone,
          // ),
        ));
        return true;
      },
    );
  }

  Future<void> uploadOfficeFiles(Emitter emit) async {
    var result = await _officeRepository.addOfficeFiles(
      // officeId: state.createdUnit!.id,
      officeId: state.verifyLicenseNumberModel?.id ?? state.createdUnit?.id ?? state.createdOffice?.id,

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
      // officeId: state.createdUnit!.id,
      officeId: state.verifyLicenseNumberModel?.id ?? state.createdUnit?.id ?? state.createdOffice?.id,
      officeLicensingFile: state.selectedOfficeLicensingFile,
      buildingLicesnsingFile: state.selectedBuildingLicesnsingFile,
      civilDefenseFile: state.selectedCivilDefenseFile,
    );
    close();
  }
}

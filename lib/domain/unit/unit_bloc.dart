// ignore_for_file: implementation_imports, prefer_const_literals_to_create_immutables
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:maktab/core/helpers/file_picker_helper.dart';
import 'package:maktab/core/helpers/image_cropper_helper.dart';
import 'package:maktab/core/services/service_locator.dart';
import 'package:maktab/data/models/office/office_detail_model.dart';
import 'package:maktab/data/models/office/office_file.dart';
import 'package:maktab/data/models/office/office_model.dart';
import 'package:maktab/data/models/office/office_price_model.dart';
import 'package:maktab/data/models/office/search_data_model.dart';
import 'package:flutter/material.dart';
import 'package:maktab/data/repositories/office_repository.dart';
import 'package:flutter/src/foundation/collections.dart';

part 'unit_event.dart';
part 'unit_state.dart';

class UnitBloc extends Bloc<UnitEvent, UnitState> {
  List<int> facilities = [];
  List<int> features = [];
  List<int> services = [];
  List<int> comforts = [];
  List<UnitPriceOptions> selectedUnitPriceOptions = [];
  Map<UnitPriceOptions, num> selectedUnitPrices = {};
  String? selectedImage;
  String? croppedImage;
  Map<UniqueKey, String> imagesMap = {};
  String? selectedFile;
  List<int> deletedFileIds = [];
  final OfficeRepository _officeRepository;
  UnitBloc({required OfficeRepository officeRepository})
      : _officeRepository = officeRepository,
        super(UnitState(
          selectedImagesMap: {},
          selectedUnitPrices: {},
          selectedUnitPriceOptions: [],
          additionalServices: {},
          additionalServiceKeys: {},
          detailsMap: {'floor': 0, 'age': 1},
        )) {
    on<InitialUnitEvent>((event, emit) {
      if (event.searchData != null) {
        state.searchData = event.searchData;
      }
      if (event.office != null) {
        state.office = event.office!;
      }
      if (event.unit != null) {
        state.progressValue = 0;
        state.isStepCompleted = true;
        state.createdUnit = event.unit;
        if (event.office != null) {
          state.office = event.office;
        }
        state.name = state.createdUnit?.title??'';
        state.categoryId = state.createdUnit!.categoryId;
        state.advertiserRelationshipOption = getAdvertiserRelationship(
            state.createdUnit!.advertiserRelationship??'');
        state.marketerTypeOption = getAdvertiserRelationshipType(
            state.createdUnit!.advertiserRelationshipType);
        if (state.createdUnit?.space != null) {
          state.space = state.createdUnit!.space.toString();
        }
        if ((state.createdUnit?.furnisher??'').isNotEmpty) {
          state.equipment = state.createdUnit!.furnisher!;
        }
        if (state.createdUnit?.typeAqar != null) {
          state.type = state.createdUnit!.typeAqar!.id;
        }
        for (OfficeDetail detail in state.createdUnit!.details) {
          state.detailsMap[detail.enName] = detail.numberDetails;
          switch (detail.arName) {
            case 'الدور':
              state.floor = detail.numberDetails;
              break;
            case 'عمر المكتب':
              state.officeAge = detail.numberDetails;
              break;
            case 'عدد المكاتب':
              state.officesCountSelectorState = ToggleStates.on;
              state.officesCount = detail.numberDetails;
              break;
            case 'غرف الاجتماعات':
              state.meetingRoomsCountSelectorState = ToggleStates.on;
              state.meetingRoomsCount = detail.numberDetails;
              break;
            case 'عدد الطاولات':
              state.tablesCountSelectorState = ToggleStates.on;
              state.tablesCount = detail.numberDetails;
              break;
            case 'مساحات عمل مشتركة':
              state.tablesCountSelectorState = ToggleStates.on;
              state.tablesCount = detail.numberDetails;
              break;
          }
        }
        state.facilities = state.createdUnit!.facilities
            .map((facility) => facility.id)
            .toList();
        if (state.createdUnit!.description!.isNotEmpty) {
          state.description = state.createdUnit!.description ?? '';
        }
        state.features =
            state.createdUnit!.features.map((feature) => feature.id).toList();
        state.comforts =
            state.createdUnit!.comforts.map((comfort) => comfort.id).toList();

        if (state.createdUnit!.interfaceAqar != null) {
          state.interfaceId = state.createdUnit!.interfaceAqar!.id;
        }
        for (OfficePrice price in state.createdUnit!.prices) {
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
        if (state.createdUnit!.typeDownPayment != null &&
            state.createdUnit!.downPayment != null) {
          state.depositAmount = state.createdUnit!.downPayment!;
          state.depositType = state.createdUnit!.typeDownPayment == 'نسبة'
              ? DepositTypes.percentage
              : DepositTypes.price;
        }
        if ((state.createdUnit!.viewerName??'').isNotEmpty &&
            (state.createdUnit!.viewerPhone??'').isNotEmpty) {
          state.viewerName = state.createdUnit!.viewerName!;
          state.viewerPhone = state.createdUnit!.viewerPhone!;
        }
        if ((state.createdUnit!.mainImage??'').isNotEmpty) {
          state.mainImage = state.createdUnit!.mainImage!;
        }
        if (state.createdUnit!.files
                .firstWhereOrNull((file) => file.typeFile == 'video') !=
            null) {
          OfficeFile video = state.createdUnit!.files
              .firstWhereOrNull((file) => file.typeFile == 'video')!;
          state.videoId = video.id;
          state.videoPath = video.path;
        }
        if (state.createdUnit!.files
                .firstWhereOrNull((file) => file.typeFile == 'image') !=
            null) {
          state.images = state.createdUnit!.files
              .where((file) => file.typeFile == 'image')
              .toList();
          state.selectedImagesCount = state.images.length;
          for (OfficeFile file in state.images) {
            state.selectedImagesMap[UniqueKey()] = file.path;
          }
        }
      }
      emit(state.copyWith(isInitialized: true));
    });
    on<SetUnitNameEvent>((event, emit) {
      state.name = event.name.length >= 4 ? event.name : '';
      emit(state.copyWith(isStepCompleted: checkIfUnitInfoStepCompleted()));
    });
    on<SelectCategoryEvent>((event, emit) {
      emit(state.copyWith(categoryId: event.id));
      emit(state.copyWith(isStepCompleted: checkIfUnitInfoStepCompleted()));
    });
    on<SelectFacilityEvent>((event, emit) {
      facilities = _toggleListItem(List.from(state.facilities), event.id);
      emit(state.copyWith(facilities: facilities));
    });
    on<SelectAdertiserRelationshipEvent>((event, emit) {
      emit(state.copyWith(
          advertiserRelationshipOption:
              event.option != state.advertiserRelationshipOption
                  ? event.option
                  : state.advertiserRelationshipOption));
    });
    on<SelectMarketerTypeEvent>((event, emit) {
      emit(state.copyWith(
          marketerTypeOption: event.option != state.marketerTypeOption
              ? event.option
              : state.marketerTypeOption));
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
        officesCountSelectorState:
            getCounterToggleState(state.officesCountSelectorState),
      ));
      emit(state.copyWith(isStepCompleted: checkIfUnitDetailsStepCompleted()));
    });
    on<IncreaseOfficesCountEvent>((event, emit) {
      state.detailsMap['officescount'] = ++event.count;
      emit(state.copyWith(officesCount: state.detailsMap['officescount']));
      emit(state.copyWith(isStepCompleted: checkIfUnitDetailsStepCompleted()));
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
      emit(state.copyWith(isStepCompleted: checkIfUnitDetailsStepCompleted()));
    });
    on<ToggleMeetingRoomsCountSelectorEvent>((event, emit) {
      state.detailsMap.removeWhere((key, value) => key == 'meetingroomscount');
      emit(state.copyWith(
        meetingRoomsCount: 0,
        meetingRoomsCountSelectorState:
            getCounterToggleState(state.meetingRoomsCountSelectorState),
      ));
      emit(state.copyWith(isStepCompleted: checkIfUnitDetailsStepCompleted()));
    });
    on<IncreaseMeetingRoomsCountEvent>((event, emit) {
      state.detailsMap['meetingroomscount'] = ++event.count;
      emit(state.copyWith(
          meetingRoomsCount: state.detailsMap['meetingroomscount']));
      emit(state.copyWith(isStepCompleted: checkIfUnitDetailsStepCompleted()));
    });
    on<DecreaseMeetingRoomsCountEvent>((event, emit) {
      int count = 0;
      if (event.count > 1) {
        count = event.count > 1 ? --event.count : 0;
        state.detailsMap['meetingroomscount'] = count;
      } else {
        state.detailsMap
            .removeWhere((key, value) => key == 'meetingroomscount');
      }
      emit(state.copyWith(meetingRoomsCount: count));
      emit(state.copyWith(isStepCompleted: checkIfUnitDetailsStepCompleted()));
    });
    on<ToggleTablesCountSelectorEvent>((event, emit) {
      state.detailsMap.removeWhere((key, value) => key == 'tablescount');
      emit(state.copyWith(
        tablesCount: 0,
        tablesCountSelectorState:
            getCounterToggleState(state.tablesCountSelectorState),
      ));
      emit(state.copyWith(isStepCompleted: checkIfUnitDetailsStepCompleted()));
    });
    on<IncreaseTablesCountEvent>((event, emit) {
      state.detailsMap['tablescount'] = ++event.count;
      emit(state.copyWith(tablesCount: state.detailsMap['tablescount']));
      emit(state.copyWith(isStepCompleted: checkIfUnitDetailsStepCompleted()));
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
      emit(state.copyWith(isStepCompleted: checkIfUnitDetailsStepCompleted()));
    });
    on<ToggleSharedWorkSpacesSelectorEvent>((event, emit) {
      state.detailsMap
          .removeWhere((key, value) => key == 'sharedworkspacescount');
      emit(state.copyWith(
        sharedWorkSpaces: 0,
        sharedWorkSpacesSelectorState:
            getCounterToggleState(state.sharedWorkSpacesSelectorState),
      ));
      emit(state.copyWith(isStepCompleted: checkIfUnitDetailsStepCompleted()));
    });
    on<IncreaseSharedWorkSpacesCountEvent>((event, emit) {
      state.detailsMap['sharedworkspacescount'] = ++event.count;
      emit(state.copyWith(
          sharedWorkSpaces: state.detailsMap['sharedworkspacescount']));
      emit(state.copyWith(isStepCompleted: checkIfUnitDetailsStepCompleted()));
    });
    on<DecreaseSharedWorkSpacesCountEvent>((event, emit) {
      int count = 0;
      if (event.count > 1) {
        count = event.count > 1 ? --event.count : 0;
        state.detailsMap['sharedworkspacescount'] = count;
      } else {
        state.detailsMap
            .removeWhere((key, value) => key == 'sharedworkspacescount');
      }
      emit(state.copyWith(sharedWorkSpaces: count));
      emit(state.copyWith(isStepCompleted: checkIfUnitDetailsStepCompleted()));
    });
    on<SetSpaceEvent>((event, emit) {
      state.space = event.space.length <= 7 ? event.space : '';
      emit(state.copyWith(isStepCompleted: checkIfUnitDetailsStepCompleted()));
    });
    on<SetDescriptionEvent>((event, emit) {
      state.description =
          event.description.length >= 8 ? event.description : '';
      emit(state.copyWith(
          isStepCompleted: checkIfUnitDescriptionStepCompleted()));
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
      Map<UniqueKey, GlobalKey> keys = Map.from(state.additionalServiceKeys);
      keys[UniqueKey()] = GlobalKey<FormState>();
      emit(state.copyWith(additionalServiceKeys: keys));
    });
    on<RemoveAdditionalServiceEvent>((event, emit) {
      Map<UniqueKey, GlobalKey> keys = Map.from(state.additionalServiceKeys);
      keys.remove(event.key);
      emit(state.copyWith(additionalServiceKeys: keys));
    });
    on<SetEquipmentEvent>((event, emit) {
      state.equipment = event.equipment;
      emit(state.copyWith(
        isStepCompleted: checkIfUnitDetailsStepCompleted(),
      ));
    });
    on<SetTypeEvent>((event, emit) {
      state.type = state.searchData!.officeTypes
          .firstWhere((type) => type.arName == event.type)
          .id;
      emit(state.copyWith(isStepCompleted: checkIfUnitDetailsStepCompleted()));
    });
    on<SetInterfaceEvent>((event, emit) {
      state.interfaceId = state.searchData!.officeInterfaces
          .firstWhere((interface) => interface.arName == event.interface)
          .id;
      emit(state.copyWith(isStepCompleted: checkIfUnitDetailsStepCompleted()));
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
      emit(state.copyWith(isStepCompleted: checkIfUnitPricesStepCompleted()));
    });
    on<ChangeUnitPriceEvent>((event, emit) {
      selectedUnitPrices = Map.from(state.selectedUnitPrices);
      if (event.price.isNotEmpty &&
          state.selectedUnitPriceOptions.contains(event.option)) {
        selectedUnitPrices.addAll({event.option: num.parse(event.price)});
      } else {
        selectedUnitPrices.remove(event.option);
      }
      emit(state.copyWith(selectedUnitPrices: selectedUnitPrices));
      emit(state.copyWith(isStepCompleted: checkIfUnitPricesStepCompleted()));
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
        isStepCompleted: checkIfUnitPricesStepCompleted(),
      ));
    });
    on<SetViewerNameEvent>((event, emit) {
      state.viewerName = event.name;
      emit(state.copyWith(
        isStepCompleted: checkIfUnitPricesStepCompleted(),
      ));
    });
    on<SetViewerPhoneEvent>((event, emit) {
      state.viewerPhone = event.phone.length >= 9 && event.phone.startsWith('5')
          ? event.phone
          : '';
      emit(state.copyWith(
        isStepCompleted: checkIfUnitPricesStepCompleted(),
      ));
    });
    on<PickOfficeVideoEvent>((event, emit) async {
      String selectedVideo = await locator<FilePickerHelper>().pickVideo();
      emit(state.copyWith(selectedVideo: selectedVideo, videoPath: ''));
    });
    on<DeleteOfficeVideoEvent>((event, emit) async {
      emit(state.copyWith(videoPath: '', selectedVideo: ''));
    });
    on<PickOfficeMainImageEvent>((event, emit) async {
      await _pickImage(emit, true);
      emit(state.copyWith(isStepCompleted: checkIfUnitImagesStepCompleted()));
    });
    on<DeleteOfficeMainImageEvent>((event, emit) async {
      _deleteImage(emit, isMainImage: true);
      emit(state.copyWith(isStepCompleted: checkIfUnitImagesStepCompleted()));
    });
    on<PickOfficeImageEvent>((event, emit) async {
      await _pickImage(emit, false);
      emit(state.copyWith(isStepCompleted: checkIfUnitImagesStepCompleted()));
    });
    on<DeleteOfficeImageEvent>((event, emit) async {
      _deleteImage(emit, isMainImage: false, key: event.key);
      emit(state.copyWith(isStepCompleted: checkIfUnitImagesStepCompleted()));
    });
    on<NavigateToNextStepEvent>((event, emit) async {
      emit(state.copyWith(stepNavigationState: StepNavigationState.initial));
      switch (event.index) {
        case 0:
          bool temp1 = false;
          if (state.createdUnit == null) {
            temp1 = await createUnit(emit);
            if (temp1) {
              navigateAfterSuccessStep(emit, event.index);
            }
          } else {
            bool temp2 = false;
            bool temp3 = false;
            if (state.createdUnit!.title != state.name) {
              temp2 = await updateTitle(emit, state.createdUnit!.id);
            } else {
              temp2 = true;
            }
            if (state.createdUnit!.categoryId != state.categoryId) {
              temp3 = await updateCategory(emit, state.createdUnit!.id);
            } else {
              temp3 = true;
            }
            if (temp2 && temp3) {
              navigateAfterSuccessStep(emit, event.index);
            }
          }
          break;
        case 1:
          bool temp1 = false;
          bool temp2 = false;
          bool temp3 = true;
          bool temp4 = false;
          temp1 = await updateDetails(emit);
          if (state.createdUnit!.typeAqarId == null) {
            temp2 = await updateInfo(emit);
          }
          if (state.createdUnit!.facilities.isEmpty &&
              state.facilities.isNotEmpty) {
            temp3 = await updateFacilities(emit);
          }
          if (state.createdUnit!.interfaceId == null) {
            temp4 = await updateInterface(emit);
          } else {
            temp2 = true;
            temp4 = true;
            if (!listEquals(
                state.createdUnit!.facilities
                    .map((facility) => facility.id)
                    .toList(),
                state.facilities)) {
              temp3 = await updateFacilities(emit);
            }
            if (state.createdUnit!.space != num.parse(state.space) ||
                state.createdUnit!.furnisher != state.equipment ||
                state.createdUnit!.typeAqarId! != state.type) {
              temp2 = await updateInfo(emit);
            } else if (state.createdUnit!.interfaceId != state.interfaceId) {
              temp4 = await updateInterface(emit);
            }
          }
          if (temp1 && temp2 && temp3 && temp4) {
            navigateAfterSuccessStep(emit, event.index);
          }
          break;
        case 2:
          bool temp1 = true;
          bool temp2 = true;
          if (state.createdUnit!.features.isEmpty &&
              state.features.isNotEmpty) {
            temp1 = await updateFeatures(emit);
          } else {
            if (!listEquals(
                state.createdUnit!.features
                    .map((feature) => feature.id)
                    .toList(),
                state.features)) {
              temp1 = await updateFeatures(emit);
            }
          }
          if (state.createdUnit!.comforts.isEmpty &&
              state.comforts.isNotEmpty) {
            temp2 = await updateComforts(emit);
          } else {
            if (!listEquals(
                state.createdUnit!.comforts
                    .map((comfort) => comfort.id)
                    .toList(),
                state.comforts)) {
              temp2 = await updateComforts(emit);
            }
          }
          if (temp1 && temp2) {
            navigateAfterSuccessStep(emit, event.index);
          }
          break;
        case 3:
          bool temp1 = false;
          bool temp2 = false;
          if (state.createdUnit!.location == null) {
            temp1 = await updateLocation(emit);
          }
          if (state.createdUnit!.description!.isEmpty ||
              state.createdUnit!.description != state.description) {
            temp2 = await updateDescription(emit);
          } else {
            temp1 = true;
            temp2 = true;
          }
          if (temp1 && temp2) {
            navigateAfterSuccessStep(emit, event.index);
          }
          break;
        case 4:
          bool temp1 = true;
          bool temp2 = true;
          bool temp3 = true;
          temp1 = await updatePrices(emit);
          if (state.selectedUnitPriceOptions
              .contains(UnitPriceOptions.yearly)) {
            if (state.depositAmount != state.createdUnit!.downPayment ||
                getCounterDepositType(state.depositType) !=
                    state.createdUnit!.typeDownPayment) {
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
        case 5:
          emit(state.copyWith(stepNavigationState: StepNavigationState.end));
          await uploadUnitFiles(emit);
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
    on<UpdateUnitInfoEvent>((event, emit) async {
      bool temp1 = false;
      bool temp2 = false;
      bool temp3 = false;
      if (state.createdUnit!.title != state.name) {
        temp1 = await updateTitle(emit, state.createdUnit!.id);
        if (state.createdUnit!.isCentral) {
          temp2 = await updateTitle(emit, state.office!.id);
        }
      }
      if (state.createdUnit!.space != num.parse(state.space) ||
          state.createdUnit!.furnisher != state.equipment ||
          state.createdUnit!.typeAqarId! != state.type ||
          state.advertiserRelationshipOption !=
              getAdvertiserRelationship(
                  state.createdUnit!.advertiserRelationship!) ||
          state.marketerTypeOption !=
              getAdvertiserRelationshipType(
                  state.createdUnit!.advertiserRelationshipType)) {
        temp3 = await updateInfo(emit);
      }
      if (!temp1 && !temp2 && !temp3) {
        emit(state.copyWith(unitApiCallState: UnitApiCallState.noCall));
      }
    });
    on<UpdateUnitStatusEvent>((event, emit) async {
      emit(state.copyWith(unitApiCallState: UnitApiCallState.loading));
      final result =
          await _officeRepository.updateStatus(officeId: event.unitId);
      result.fold(
        (failure) {
          emit(state.copyWith(unitApiCallState: UnitApiCallState.failure));
        },
        (_) async {
          emit(state.copyWith(unitApiCallState: UnitApiCallState.success));
        },
      );
    });
    on<UpdateUnitCategoryEvent>((event, emit) async {
      if (state.createdUnit!.categoryId != state.categoryId) {
        await updateCategory(emit, state.createdUnit!.id);
        if (state.createdUnit!.isCentral) {
          await updateCategory(emit, state.office!.id);
        }
      } else {
        emit(state.copyWith(unitApiCallState: UnitApiCallState.noCall));
      }
    });
    on<UpdateUnitDetailsEvent>((event, emit) async {
      if (state.officesCountSelectorState == ToggleStates.on &&
              state.officesCount != 0 ||
          state.meetingRoomsCountSelectorState == ToggleStates.on &&
              state.meetingRoomsCount != 0 ||
          state.createdUnit?.details.length != state.detailsMap.length) {
        await updateDetails(emit);
      }
    });
    on<UpdateUnitDescriptionEvent>((event, emit) async {
      if (state.createdUnit!.description!.isEmpty ||
          state.createdUnit!.description != state.description) {
        await updateDescription(emit);
      } else {
        emit(state.copyWith(unitApiCallState: UnitApiCallState.noCall));
      }
    });
    on<UpdateUnitFacilitiesEvent>((event, emit) async {
      if (!listEquals(
          state.createdUnit!.facilities.map((facility) => facility.id).toList(),
          state.facilities)) {
        await updateFacilities(emit);
      } else {
        emit(state.copyWith(unitApiCallState: UnitApiCallState.noCall));
      }
    });
    on<UpdateUnitFeaturesEvent>((event, emit) async {
      if (!listEquals(
          state.createdUnit!.features.map((feature) => feature.id).toList(),
          state.features)) {
        await updateFeatures(emit);
      } else {
        emit(state.copyWith(unitApiCallState: UnitApiCallState.noCall));
      }
    });
    on<UpdateUnitComfortsEvent>((event, emit) async {
      if (!listEquals(
          state.createdUnit!.comforts.map((comfort) => comfort.id).toList(),
          state.comforts)) {
        await updateComforts(emit);
      } else {
        emit(state.copyWith(unitApiCallState: UnitApiCallState.noCall));
      }
    });
    on<UpdateUnitPricesEvent>((event, emit) async {
      if (state.selectedUnitPrices.isNotEmpty ||
          state.selectedUnitPrices.length ==
              state.selectedUnitPriceOptions.length) {
        await updatePrices(emit);
      } else {
        emit(state.copyWith(unitApiCallState: UnitApiCallState.noCall));
      }
    });
    on<UpdateUnitDepositEvent>((event, emit) async {
      if (state.selectedUnitPrices.values.min > state.depositAmount &&
          state.selectedUnitPriceOptions.contains(UnitPriceOptions.yearly) &&
          state.depositAmount > 0) {
        await updateDepositInfo(emit);
      } else {
        emit(state.copyWith(unitApiCallState: UnitApiCallState.noCall));
      }
    });
    on<DeleteUnitEvent>((event, emit) async {
      emit(state.copyWith(unitApiCallState: UnitApiCallState.loading));
      final result = await _officeRepository.deleteById(event.id);
      result.fold(
        (failure) =>
            emit(state.copyWith(unitApiCallState: UnitApiCallState.failure)),
        (success) =>
            emit(state.copyWith(unitApiCallState: UnitApiCallState.success)),
      );
    });
    on<UpdateUnitFilesEvent>((event, emit) async {
      bool temp1 = true;
      bool temp2 = true;
      if (state.selectedImagesMap.length < 4) {
        return;
      }
      deletedFileIds = [];
      if (state.selectedVideo.isNotEmpty && state.videoId != null) {
        deletedFileIds.add(state.videoId!);
      }
      bool isFilesChanged = false;
      List<String> newPaths = state.selectedImagesMap.values.toList();
      for (OfficeFile originFile in state.createdUnit!.files) {
        if (!newPaths.contains(originFile.path)) {
          if (!deletedFileIds.contains(originFile.id)) {
            deletedFileIds.add(originFile.id!);
          }
          isFilesChanged = true;
          break;
        }
      }
      if (state.selectedMainImage.isNotEmpty ||
          state.selectedVideo.isNotEmpty ||
          isFilesChanged) {
        temp1 = await deleteFiles(emit);
        if (temp1) {
          temp2 = await updateUnitFiles(emit, isChanged: isFilesChanged);
          if (temp2) {
            emit(state.copyWith(unitApiCallState: UnitApiCallState.success));
          } else {
            emit(state.copyWith(unitApiCallState: UnitApiCallState.failure));
          }
        } else {
          emit(state.copyWith(unitApiCallState: UnitApiCallState.failure));
        }
      }
    });
  }

  List<T> _toggleListItem<T>(List<T> list, T element) {
    list.contains(element) ? list.remove(element) : list.add(element);
    return list;
  }

  ToggleStates getCounterToggleState(ToggleStates state) {
    return state == ToggleStates.on ? ToggleStates.off : ToggleStates.on;
  }

  Future<void> _pickImage(Emitter<UnitState> emit, bool isMainImage) async {
    emit(state.copyWith(imagesErrorMessage: ''));
    selectedImage = await locator<FilePickerHelper>().pickImage();
    if (selectedImage != null) {
      if (selectedImage!.isNotEmpty) {
        croppedImage =
            await ImageCropperHelper.cropImage(selectedImage: selectedImage!);
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
            state.selectedImagesCount == -1
                ? state.selectedImagesCount = 1
                : state.selectedImagesCount++;
            emit(state.copyWith(
              selectedImagesMap: imagesMap,
              imagesErrorMessage: '',
            ));
          }
        }
      } else {
        emit(state.copyWith(
            imagesErrorMessage: 'يجب أن يكون حجم الصورة أصغر من 2 ميغا بايت'));
      }
    }
  }

  void _deleteImage(Emitter<UnitState> emit,
      {Key? key, bool isMainImage = false}) {
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

  bool checkIfStepCompleted(int index) {
    switch (index) {
      case 0:
        return checkIfUnitInfoStepCompleted();
      case 1:
        return checkIfUnitDetailsStepCompleted();
      case 2:
        return true;
      case 3:
        return checkIfUnitDescriptionStepCompleted();
      case 4:
        return checkIfUnitPricesStepCompleted();
      case 5:
        return checkIfUnitImagesStepCompleted();
    }
    return false;
  }

  void navigateAfterSuccessStep(Emitter emit, int index) {
    emit(state.copyWith(
      stepNavigationState: StepNavigationState.next,
      isStepCompleted: checkIfStepCompleted(index + 1),
      progressValue: ++state.progressValue,
    ));
  }

  bool checkIfUnitInfoStepCompleted() {
    return state.name.isNotEmpty && state.categoryId >= 0 ? true : false;
  }

  bool checkIfUnitDetailsStepCompleted() {
    return state.officesCountSelectorState == ToggleStates.on &&
                state.officesCount <= 0 ||
            state.meetingRoomsCountSelectorState == ToggleStates.on &&
                state.meetingRoomsCount <= 0 ||
            state.tablesCountSelectorState == ToggleStates.on &&
                state.tablesCount <= 0 ||
            state.sharedWorkSpacesSelectorState == ToggleStates.on &&
                state.sharedWorkSpaces <= 0
        ? false
        : true;
  }

  bool checkIfUnitDescriptionStepCompleted() {
    return state.description.isEmpty ? false : true;
  }

  bool checkIfUnitPricesStepCompleted() {
    return state.selectedUnitPrices.isEmpty ||
            state.selectedUnitPrices.length <
                state.selectedUnitPriceOptions.length ||
            state.selectedUnitPrices.values.min < state.depositAmount ||
            state.selectedUnitPriceOptions.contains(UnitPriceOptions.yearly) &&
                state.depositAmount < 0 ||
            state.viewerName.isEmpty ||
            state.viewerPhone.isEmpty
        ? false
        : true;
  }

  bool checkIfUnitImagesStepCompleted() {
    return state.selectedMainImage.isEmpty || state.selectedImagesCount < 4
        ? false
        : true;
  }

  Future<bool> createUnit(Emitter emit) async {
    emit(state.copyWith(unitApiCallState: UnitApiCallState.loading));
    var result = await _officeRepository.addUnit(
      officeId: state.office!.id,
      title: state.name,
      categoryId: state.categoryId,
      licenseNumber: '',
      isMarketing: state.office!.isMarketing??false,
      isCentral: false,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(
          unitApiCallState: UnitApiCallState.failure,
          createdUnit: null,
        ));
        return false;
      },
      (createdUnit) async {
        emit(state.copyWith(
          unitApiCallState: UnitApiCallState.success,
          createdUnit: createdUnit,
        ));
        return true;
      },
    );
  }

  Future<bool> updateTitle(Emitter emit, int id) async {
    emit(state.copyWith(unitApiCallState: UnitApiCallState.loading));
    var result = await _officeRepository.updateTitle(
      title: state.name,
      officeId: id,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(unitApiCallState: UnitApiCallState.failure));
        return false;
      },
      (updatedUnit) async {
        emit(state.copyWith(
          unitApiCallState: UnitApiCallState.success,
          createdUnit: state.createdUnit!.copyWith(title: updatedUnit!.title),
        ));
        return true;
      },
    );
  }

  Future<bool> updateCategory(Emitter emit, int id) async {
    emit(state.copyWith(unitApiCallState: UnitApiCallState.loading));
    var result = await _officeRepository.updateCategory(
      categoryId: state.categoryId,
      officeId: id,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(unitApiCallState: UnitApiCallState.failure));
        return false;
      },
      (updatedUnit) async {
        emit(state.copyWith(
          unitApiCallState: UnitApiCallState.success,
          createdUnit: state.createdUnit!.copyWith(
            categoryId: updatedUnit!.categoryId,
          ),
        ));
        return true;
      },
    );
  }

  Future<bool> updateFacilities(Emitter emit) async {
    emit(state.copyWith(unitApiCallState: UnitApiCallState.loading));
    var result = await _officeRepository.updateOfficeFacilities(
      officeId: state.createdUnit!.id,
      facilities: state.facilities,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(unitApiCallState: UnitApiCallState.failure));
        return false;
      },
      (updatedUnit) async {
        emit(state.copyWith(
          unitApiCallState: UnitApiCallState.success,
          createdUnit:
              state.createdUnit!.copyWith(facilities: updatedUnit!.facilities),
        ));
        return true;
      },
    );
  }

  Future<bool> updateDetails(Emitter emit) async {
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
    // log("New Details: $newDetails");
    // log("Updated Details: $updatedDetails");
    // log("Deleted Details: $deletedDetails");
    if (newDetails.isNotEmpty ||
        updatedDetails.isNotEmpty ||
        deletedDetails.isNotEmpty) {
      emit(state.copyWith(unitApiCallState: UnitApiCallState.loading));
      var result = await _officeRepository.updateOfficeDetails(
        officeId: state.createdUnit!.id,
        newDetails: newDetails,
        updatedDetails: updatedDetails,
        deletedDetails: deletedDetails,
      );
      return result.fold(
        (failure) {
          emit(state.copyWith(unitApiCallState: UnitApiCallState.failure));
          return false;
        },
        (updatedUnit) async {
          emit(state.copyWith(
            unitApiCallState: UnitApiCallState.success,
            createdUnit:
                state.createdUnit!.copyWith(details: updatedUnit!.details),
          ));
          return true;
        },
      );
    }
    emit(state.copyWith(unitApiCallState: UnitApiCallState.noCall));
    return true;
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
    emit(state.copyWith(unitApiCallState: UnitApiCallState.loading));
    var result = await _officeRepository.updateOfficeInfo(
      officeId: state.createdUnit!.id,
      advertiserRelationship: state.advertiserRelationshipOption ==
              AdertiserRelationshipOptions.none
          ? state.createdUnit!.advertiserRelationship
          : getCounterAdvertiserRelationship(
              state.advertiserRelationshipOption),
      advertiserRelationshipType: state.marketerTypeOption == MarketerTypes.none
          ? state.createdUnit!.advertiserRelationshipType
          : state.advertiserRelationshipOption ==
                      AdertiserRelationshipOptions.agent ||
                  state.advertiserRelationshipOption ==
                      AdertiserRelationshipOptions.owner
              ? ''
              : getCounterAdvertiserRelationshipType(state.marketerTypeOption),
      space: state.space,
      equipment: state.equipment,
      typeId: state.searchData!.officeTypes
          .firstWhere((type) => type.id == state.type)
          .id,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(unitApiCallState: UnitApiCallState.failure));
        return false;
      },
      (updatedUnit) async {
        emit(state.copyWith(
          unitApiCallState: UnitApiCallState.success,
          createdUnit: state.createdUnit!.copyWith(
            space: updatedUnit!.space,
            typeAqarId: updatedUnit.typeAqarId,
          ),
        ));
        return true;
      },
    );
  }

  Future<bool> updateInterface(Emitter emit) async {
    emit(state.copyWith(unitApiCallState: UnitApiCallState.loading));
    var result = await _officeRepository.updateInterface(
      officeId: state.createdUnit!.id,
      interfaceId: state.interfaceId,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(unitApiCallState: UnitApiCallState.failure));
        return false;
      },
      (updatedUnit) async {
        emit(state.copyWith(
          unitApiCallState: UnitApiCallState.success,
          createdUnit:
              state.createdUnit!.copyWith(interfaceId: updatedUnit.interfaceId),
        ));
        return true;
      },
    );
  }

  Future<bool> updateFeatures(Emitter emit) async {
    emit(state.copyWith(unitApiCallState: UnitApiCallState.loading));
    var result = await _officeRepository.updateOfficeFeatures(
      officeId: state.createdUnit!.id,
      features: state.features,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(unitApiCallState: UnitApiCallState.failure));
        return false;
      },
      (updatedUnit) async {
        emit(state.copyWith(
          unitApiCallState: UnitApiCallState.success,
          createdUnit:
              state.createdUnit!.copyWith(features: updatedUnit!.features),
        ));
        return true;
      },
    );
  }

  Future<bool> updateComforts(Emitter emit) async {
    emit(state.copyWith(unitApiCallState: UnitApiCallState.loading));
    var result = await _officeRepository.updateOfficeComforts(
      officeId: state.createdUnit!.id,
      comforts: state.comforts,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(unitApiCallState: UnitApiCallState.failure));
        return false;
      },
      (updatedUnit) async {
        emit(state.copyWith(
          unitApiCallState: UnitApiCallState.success,
          createdUnit:
              state.createdUnit!.copyWith(comforts: updatedUnit!.comforts),
        ));
        return true;
      },
    );
  }

  Future<bool> updateDescription(Emitter emit) async {
    emit(state.copyWith(unitApiCallState: UnitApiCallState.loading));
    var result = await _officeRepository.updateDescription(
        officeId: state.createdUnit!.id, description: state.description);
    return result.fold(
      (failure) {
        emit(state.copyWith(unitApiCallState: UnitApiCallState.failure));
        return false;
      },
      (updatedUnit) async {
        emit(state.copyWith(
          unitApiCallState: UnitApiCallState.success,
          createdUnit:
              state.createdUnit!.copyWith(description: updatedUnit.description),
        ));
        return true;
      },
    );
  }

  Future<bool> updateLocation(Emitter emit) async {
    emit(state.copyWith(unitApiCallState: UnitApiCallState.loading));
    var result = await _officeRepository.updateLocation(
      officeId: state.createdUnit!.id,
      lat: state.office!.location!.lat,
      lng: state.office!.location!.lng,
      zoom: state.office!.location!.zoom.toDouble(),
      city: state.office!.location!.city,
      neighborhood: state.office!.location!.neighborhood,
      street: state.office!.location!.street,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(unitApiCallState: UnitApiCallState.failure));
        return false;
      },
      (updatedUnit) async {
        emit(state.copyWith(
          unitApiCallState: UnitApiCallState.success,
          createdUnit:
              state.createdUnit!.copyWith(location: updatedUnit.location),
        ));
        return true;
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
            updatedPrices[price.id] = {
              priceTypeId: state.selectedUnitPrices[key]
            };
          }
          break;
        }
      }
      if (!isExisting) {
        newPrices[priceTypeId] = value;
      }
    });
    for (OfficePrice price in state.createdUnit!.prices) {
      if (!state.selectedUnitPrices
          .containsKey(getPriceTypeId(price.typeResId))) {
        deletedPrices.add(price.id);
      }
    }
    // log("New Prices: $newPrices");
    // log("Updated Details: $updatedPrices");
    // log("Deleted Details: $deletedPrices");
    if (newPrices.isNotEmpty ||
        updatedPrices.isNotEmpty ||
        deletedPrices.isNotEmpty) {
      emit(state.copyWith(unitApiCallState: UnitApiCallState.loading));
      var result = await _officeRepository.updateOfficePrices(
        officeId: state.createdUnit!.id,
        newPrices: newPrices,
        updatedPrices: updatedPrices,
        deletedPrices: deletedPrices,
      );
      return result.fold(
        (failure) {
          emit(state.copyWith(unitApiCallState: UnitApiCallState.failure));
          return false;
        },
        (updatedUnit) async {
          emit(state.copyWith(
            unitApiCallState: UnitApiCallState.success,
            createdUnit:
                state.createdUnit!.copyWith(prices: updatedUnit!.prices),
          ));
          return true;
        },
      );
    }
    emit(state.copyWith(unitApiCallState: UnitApiCallState.noCall));
    return true;
  }

  String getCounterDepositType(DepositTypes type) {
    return type == DepositTypes.price ? 'سعر' : 'نسبة';
  }

  Future<bool> updateDepositInfo(Emitter emit) async {
    emit(state.copyWith(unitApiCallState: UnitApiCallState.loading));
    var result = await _officeRepository.updateDownPayment(
      officeId: state.createdUnit!.id,
      downPayment: state.depositAmount,
      downPaymentType: getCounterDepositType(state.depositType),
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(unitApiCallState: UnitApiCallState.failure));
        return false;
      },
      (updatedUnit) async {
        emit(state.copyWith(
          unitApiCallState: UnitApiCallState.success,
          createdUnit: state.createdUnit!.copyWith(
              downPayment: updatedUnit.downPayment,
              typeDownPayment: updatedUnit.typeDownPayment),
        ));
        return true;
      },
    );
  }

  Future<bool> updateViewerInfo(Emitter emit) async {
    emit(state.copyWith(unitApiCallState: UnitApiCallState.loading));
    var result = await _officeRepository.updateViewer(
      officeId: state.createdUnit!.id,
      viewerName: state.viewerName,
      viewerPhone: state.viewerPhone,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(unitApiCallState: UnitApiCallState.failure));
        return false;
      },
      (updatedUnit) async {
        emit(state.copyWith(
          unitApiCallState: UnitApiCallState.success,
          createdUnit: state.createdUnit!.copyWith(
              viewerName: updatedUnit.viewerName,
              viewerPhone: updatedUnit.viewerPhone),
        ));
        return true;
      },
    );
  }

  Future<void> uploadUnitFiles(Emitter emit) async {
    var result = await _officeRepository.addOfficeFiles(
      officeId: state.createdUnit!.id,
      video: state.selectedVideo.isNotEmpty ? state.selectedVideo : null,
      mainImage:
          state.selectedMainImage.isNotEmpty ? state.selectedMainImage : null,
      images: state.selectedImagesMap.values.toList(),
    );
    result.fold(
      (failure) {
        emit(state.copyWith(
          stepNavigationState: StepNavigationState.initial,
          imagesApiCallState: UnitApiCallState.failure,
        ));
      },
      (updatedOffice) async {
        emit(state.copyWith(
          stepNavigationState: StepNavigationState.initial,
          imagesApiCallState: UnitApiCallState.success,
        ));
      },
    );
    close();
  }

  Future<bool> updateMainImage(Emitter emit) async {
    emit(state.copyWith(unitApiCallState: UnitApiCallState.loading));
    final result = await _officeRepository.updateFiles(
      officeId: state.createdUnit!.id,
      mainImage: state.selectedMainImage,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(unitApiCallState: UnitApiCallState.failure));
        return false;
      },
      (success) {
        return true;
      },
    );
  }

  Future<bool> deleteFiles(Emitter emit) async {
    if (deletedFileIds.isNotEmpty) {
      emit(state.copyWith(unitApiCallState: UnitApiCallState.loading));
      final result = await _officeRepository.deleteFiles(
        officeId: state.createdUnit!.id,
        filesIds: deletedFileIds,
      );
      return result.fold(
        (failure) {
          emit(state.copyWith(unitApiCallState: UnitApiCallState.failure));
          return false;
        },
        (success) {
          return true;
        },
      );
    }
    return true;
  }

  Future<bool> updateUnitFiles(Emitter emit, {required bool isChanged}) async {
    emit(state.copyWith(unitApiCallState: UnitApiCallState.loading));
    // log('${state.selectedImagesMap.toString()}?.............');
    var result = await _officeRepository.addOfficeFiles(
      officeId: state.createdUnit!.id,
      video: state.selectedVideo.isNotEmpty ? state.selectedVideo : null,
      mainImage:
          state.selectedMainImage.isNotEmpty ? state.selectedMainImage : null,
      images: isChanged ? state.selectedImagesMap.values.toList() : null,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(unitApiCallState: UnitApiCallState.failure));
        return false;
      },
      (sucess) async {
        return true;
      },
    );
  }
}

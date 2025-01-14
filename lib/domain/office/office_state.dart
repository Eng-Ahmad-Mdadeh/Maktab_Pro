
part of 'office_bloc.dart';

class OfficeState extends Equatable {
  VisibilityStates licenseOfficeState;
  VisibilityStates marketingRequestState;
  OfficeTypes officeType;
  String licenseNumber = '';
  String name = '';
  int categoryId;
  bool acceptingUserAgreement;
  AdertiserRelationshipOptions advertiserRelationshipOption;
  MarketerTypes marketerTypeOption;
  String space;
  String equipment;
  int type;
  int floor;
  int officeAge;
  ToggleStates officesCountSelectorState;
  int officesCount;
  ToggleStates meetingRoomsCountSelectorState;
  int meetingRoomsCount;
  ToggleStates tablesCountSelectorState;
  int tablesCount;
  ToggleStates sharedWorkSpacesSelectorState;
  int sharedWorkSpaces;
  Map<String, dynamic> detailsMap;
  List<int> facilities;
  String description;
  List<int> features;
  List<int> services;
  List<int> comforts;
  Map<UniqueKey, GlobalKey<FormState>> additionalServiceKeys;
  Map<UniqueKey, Map<String, dynamic>> additionalServices;
  LatLng addressPosition;
  double currentMapZoom;
  String city;
  String neighborhood;
  String street;
  int interfaceId;
  List<UnitPriceOptions> selectedUnitPriceOptions;
  Map<UnitPriceOptions, num> selectedUnitPrices;
  int selectedUnitPricesCount;
  DepositTypes? depositType;
  num depositAmount;
  String viewerName;
  String viewerPhone;
  String selectedVideo;
  String selectedMainImage;
  bool isMainImageSelected;
  Map<UniqueKey, String> selectedImagesMap;
  int selectedImagesCount;
  String imagesErrorMessage;
  String selectedOfficeLicensingFile;
  String selectedBuildingLicesnsingFile;
  String selectedCivilDefenseFile;
  String filesErrorMessage;
  bool isStepCompleted;
  StepNavigationState stepNavigationState;
  SearchData? searchData;
  Office? createdOffice;
  Office? createdUnit;
  OfficeApiCallState officeApiCallState;
  int progressValue;
  OfficeApiCallState imagesApiCallState;
  bool isInitialized = false;
  bool editNameAndCategory;
  bool editLocation;

  OfficeState({
    this.licenseOfficeState = VisibilityStates.show,
    this.marketingRequestState = VisibilityStates.hide,
    this.officeType = OfficeTypes.license,
    this.licenseNumber = '',
    this.name = '',
    this.categoryId = -1,
    this.acceptingUserAgreement = false,
    this.advertiserRelationshipOption = AdertiserRelationshipOptions.none,
    this.marketerTypeOption = MarketerTypes.none,
    this.space = '',
    this.equipment = '',
    this.type = -1,
    this.floor = 0,
    this.officeAge = 1,
    this.officesCountSelectorState = ToggleStates.off,
    this.officesCount = 0,
    this.meetingRoomsCountSelectorState = ToggleStates.off,
    this.meetingRoomsCount = 0,
    this.tablesCountSelectorState = ToggleStates.off,
    this.tablesCount = 0,
    this.sharedWorkSpacesSelectorState = ToggleStates.off,
    this.sharedWorkSpaces = 0,
    required this.detailsMap,
    this.facilities = const [],
    this.description = '',
    this.features = const [],
    this.services = const [],
    this.comforts = const [],
    required this.additionalServiceKeys,
    required this.additionalServices,
    this.addressPosition = const LatLng(24.786743064871313, 46.71276479959488),
    this.currentMapZoom = 10,
    this.city = '',
    this.neighborhood = '',
    this.street = '',
    this.interfaceId = -1,
    required this.selectedUnitPriceOptions,
    required this.selectedUnitPrices,
    this.selectedUnitPricesCount = -1,
    this.depositType = DepositTypes.price,
    this.depositAmount = -2,
    this.viewerName = '',
    this.viewerPhone = '',
    this.selectedVideo = '',
    this.selectedMainImage = '',
    this.isMainImageSelected = true,
    required this.selectedImagesMap,
    this.selectedImagesCount = -1,
    this.imagesErrorMessage = '',
    this.selectedOfficeLicensingFile = '',
    this.selectedBuildingLicesnsingFile = '',
    this.selectedCivilDefenseFile = '',
    this.filesErrorMessage = '',
    this.isStepCompleted = true,
    this.stepNavigationState = StepNavigationState.initial,
    this.searchData,
    this.createdOffice,
    this.createdUnit,
    this.officeApiCallState = OfficeApiCallState.initial,
    this.progressValue = 0,
    this.imagesApiCallState = OfficeApiCallState.initial,
    this.isInitialized = false,
    this.editNameAndCategory = false,
    this.editLocation = false,
  });

  @override
  List<Object?> get props => [
        licenseOfficeState,
        marketingRequestState,
        officeType,
        licenseNumber,
        name,
        categoryId,
        acceptingUserAgreement,
        advertiserRelationshipOption,
        marketerTypeOption,
        space,
        equipment,
        type,
        floor,
        officeAge,
        officesCountSelectorState,
        officesCount,
        meetingRoomsCountSelectorState,
        meetingRoomsCount,
        tablesCountSelectorState,
        tablesCount,
        sharedWorkSpacesSelectorState,
        sharedWorkSpaces,
        detailsMap,
        facilities,
        description,
        features,
        services,
        comforts,
        additionalServiceKeys,
        additionalServices.values,
        addressPosition,
        currentMapZoom,
        city,
        neighborhood,
        street,
        interfaceId,
        selectedUnitPriceOptions,
        selectedUnitPrices,
        selectedUnitPricesCount,
        depositType,
        depositAmount,
        viewerName,
        viewerPhone,
        selectedVideo,
        selectedMainImage,
        isMainImageSelected,
        selectedImagesMap,
        selectedImagesCount,
        imagesErrorMessage,
        selectedOfficeLicensingFile,
        selectedBuildingLicesnsingFile,
        selectedBuildingLicesnsingFile,
        selectedCivilDefenseFile,
        filesErrorMessage,
        isStepCompleted,
        stepNavigationState,
        createdOffice,
        createdUnit,
        officeApiCallState,
        progressValue,
        imagesApiCallState,
        isInitialized,
        editNameAndCategory,
        editLocation,
      ];

  OfficeState copyWith({
    VisibilityStates? licenseOfficeState,
    VisibilityStates? marketingRequestState,
    OfficeTypes? officeType,
    String? licenseNumber,
    String? name,
    int? categoryId,
    bool? acceptingUserAgreement,
    AdertiserRelationshipOptions? advertiserRelationshipOption,
    MarketerTypes? marketerTypeOption,
    String? space,
    String? equipment,
    int? type,
    int? floor,
    int? officeAge,
    ToggleStates? officesCountSelectorState,
    int? officesCount,
    ToggleStates? meetingRoomsCountSelectorState,
    int? meetingRoomsCount,
    ToggleStates? tablesCountSelectorState,
    int? tablesCount,
    ToggleStates? sharedWorkSpacesSelectorState,
    int? sharedWorkSpaces,
    Map<String, dynamic>? detailsMap,
    int? selectedDetailsCount,
    List<int>? facilities,
    String? description,
    List<int>? features,
    List<int>? services,
    List<int>? comforts,
    Map<UniqueKey, GlobalKey<FormState>>? additionalServiceKeys,
    Map<UniqueKey, Map<String, dynamic>>? additionalServices,
    LatLng? addressPosition,
    double? currentMapZoom,
    String? city,
    String? neighborhood,
    String? street,
    int? interfaceId,
    List<UnitPriceOptions>? selectedUnitPriceOptions,
    Map<UnitPriceOptions, num>? selectedUnitPrices,
    int? selectedUnitPricesCount,
    DepositTypes? depositType,
    num? depositAmount,
    String? viewerName,
    String? viewerPhone,
    String? selectedVideo,
    String? selectedMainImage,
    bool? isMainImageSelected,
    Map<UniqueKey, String>? selectedImagesMap,
    int? selectedImagesCount,
    String? imagesErrorMessage,
    String? selectedOfficeLicensingFile,
    String? selectedBuildingLicesnsingFile,
    String? selectedCivilDefenseFile,
    String? filesErrorMessage,
    bool? isStepCompleted,
    StepNavigationState? stepNavigationState,
    SearchData? searchData,
    Office? createdOffice,
    Office? createdUnit,
    OfficeApiCallState? officeApiCallState,
    int? progressValue,
    OfficeApiCallState? imagesApiCallState,
    bool? isInitialized,
    bool? editNameAndCategory,
    bool? editLocation,
  }) {
    return OfficeState(
      licenseOfficeState: licenseOfficeState ?? this.licenseOfficeState,
      marketingRequestState:
          marketingRequestState ?? this.marketingRequestState,
      officeType: officeType ?? this.officeType,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      acceptingUserAgreement:
          acceptingUserAgreement ?? this.acceptingUserAgreement,
      advertiserRelationshipOption:
          advertiserRelationshipOption ?? this.advertiserRelationshipOption,
      marketerTypeOption: marketerTypeOption ?? this.marketerTypeOption,
      space: space ?? this.space,
      equipment: equipment ?? this.equipment,
      type: type ?? this.type,
      floor: floor ?? this.floor,
      officeAge: officeAge ?? this.officeAge,
      officesCountSelectorState:
          officesCountSelectorState ?? this.officesCountSelectorState,
      officesCount: officesCount ?? this.officesCount,
      meetingRoomsCountSelectorState:
          meetingRoomsCountSelectorState ?? this.meetingRoomsCountSelectorState,
      meetingRoomsCount: meetingRoomsCount ?? this.meetingRoomsCount,
      tablesCountSelectorState:
          tablesCountSelectorState ?? this.tablesCountSelectorState,
      tablesCount: tablesCount ?? this.tablesCount,
      sharedWorkSpacesSelectorState:
          sharedWorkSpacesSelectorState ?? this.sharedWorkSpacesSelectorState,
      sharedWorkSpaces: sharedWorkSpaces ?? this.sharedWorkSpaces,
      detailsMap: detailsMap ?? this.detailsMap,
      facilities: facilities ?? this.facilities,
      description: description ?? this.description,
      features: features ?? this.features,
      services: services ?? this.services,
      comforts: comforts ?? this.comforts,
      additionalServiceKeys:
          additionalServiceKeys ?? this.additionalServiceKeys,
      additionalServices: additionalServices ?? this.additionalServices,
      addressPosition: addressPosition ?? this.addressPosition,
      currentMapZoom: currentMapZoom ?? this.currentMapZoom,
      city: city ?? this.city,
      neighborhood: neighborhood ?? this.neighborhood,
      street: street ?? this.street,
      interfaceId: interfaceId ?? this.interfaceId,
      selectedUnitPriceOptions:
          selectedUnitPriceOptions ?? this.selectedUnitPriceOptions,
      selectedUnitPrices: selectedUnitPrices ?? this.selectedUnitPrices,
      selectedUnitPricesCount:
          selectedUnitPricesCount ?? this.selectedUnitPricesCount,
      depositType: depositType ?? this.depositType,
      depositAmount: depositAmount ?? this.depositAmount,
      viewerName: viewerName ?? this.viewerName,
      viewerPhone: viewerPhone ?? this.viewerPhone,
      selectedVideo: selectedVideo ?? this.selectedVideo,
      selectedMainImage: selectedMainImage ?? this.selectedMainImage,
      isMainImageSelected: isMainImageSelected ?? this.isMainImageSelected,
      selectedImagesMap: selectedImagesMap ?? this.selectedImagesMap,
      selectedImagesCount: selectedImagesCount ?? this.selectedImagesCount,
      imagesErrorMessage: imagesErrorMessage ?? this.imagesErrorMessage,
      selectedOfficeLicensingFile:
          selectedOfficeLicensingFile ?? this.selectedOfficeLicensingFile,
      selectedBuildingLicesnsingFile:
          selectedBuildingLicesnsingFile ?? this.selectedBuildingLicesnsingFile,
      selectedCivilDefenseFile:
          selectedCivilDefenseFile ?? this.selectedCivilDefenseFile,
      filesErrorMessage: filesErrorMessage ?? this.filesErrorMessage,
      isStepCompleted: isStepCompleted ?? this.isStepCompleted,
      stepNavigationState: stepNavigationState ?? this.stepNavigationState,
      searchData: searchData ?? this.searchData,
      createdOffice: createdOffice ?? this.createdOffice,
      createdUnit: createdUnit ?? this.createdUnit,
      officeApiCallState: officeApiCallState ?? this.officeApiCallState,
      progressValue: progressValue ?? this.progressValue,
      imagesApiCallState: imagesApiCallState ?? this.imagesApiCallState,
      isInitialized: isInitialized ?? this.isInitialized,
      editNameAndCategory: editNameAndCategory ?? this.editNameAndCategory,
      editLocation: editLocation ?? this.editLocation,
    );
  }
}

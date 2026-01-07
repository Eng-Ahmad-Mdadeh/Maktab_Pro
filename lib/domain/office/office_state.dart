part of 'office_bloc.dart';

class OfficeState extends Equatable {
  VisibilityStates licenseOfficeState;
  VisibilityStates marketingRequestState;
  OfficeTypes officeType;
  String licenseNumber = '';
  int createAd = 0;
  String name = '';
  int id = -1;
  int categoryId;
  bool acceptingUserAgreement;
  AdertiserRelationshipOptions advertiserRelationshipOption;
  TransactionType transactionType;
  MarketerTypes marketerTypeOption;
  String space;
  String streetWidth;
  String equipment;
  int type;
  List<int> officeTypeIds;

  int floor;
  String? officeAge;
  OfficeLocation? location;
  String? officeAgeId;
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
  List<int> propertyUtilities;
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
  InterfaceAqar? interfaceAqar;
  // List<UnitPriceOptions> selectedUnitPriceOptions;
  // Map<UnitPriceOptions, num> selectedUnitPrices;
  // int selectedUnitPricesCount;
  num officePrices  ;
   List<OfficePrice> adsPrices;

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
  VerifyLicenseNumberModel? verifyLicenseNumberModel;

  OfficeState({
    this.licenseOfficeState = VisibilityStates.show,
    this.marketingRequestState = VisibilityStates.hide,
    this.officeType = OfficeTypes.license,
    this.licenseNumber = '',
    this.createAd = 0,
    this.name = '',
    this.categoryId = -1,
    this.id = -1,
    this.acceptingUserAgreement = false,
    this.advertiserRelationshipOption = AdertiserRelationshipOptions.none,
    this.transactionType = TransactionType.sell,
    this.marketerTypeOption = MarketerTypes.none,
    this.space = '',
    this.streetWidth = '',
    this.equipment = '',
    this.type = -1,
    this.officeTypeIds = const[],
    this.floor = 0,
    this.officeAge ,
    this.interfaceAqar ,
    this.location ,
    this.officeAgeId ,
    this.officesCountSelectorState = ToggleStates.on,
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
    this.propertyUtilities = const [],
    this.services = const [],
    this.comforts = const [],
    this.adsPrices = const [],
    required this.additionalServiceKeys,
    required this.additionalServices,
    this.addressPosition = const LatLng(24.786743064871313, 46.71276479959488),
    this.currentMapZoom = 10,
    this.city = '',
    this.neighborhood = '',
    this.street = '',
    this.interfaceId = -1,
    // required this.selectedUnitPriceOptions,
    // required this.selectedUnitPrices,
    // this.selectedUnitPricesCount = -1,
    this.officePrices = -1,
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
    this.verifyLicenseNumberModel,
  });

  @override
  List<Object?> get props => [
        licenseOfficeState,
        marketingRequestState,
        officeType,
        licenseNumber,
        createAd,
        name,
        categoryId,
    id,
        acceptingUserAgreement,
        advertiserRelationshipOption,
    transactionType,
        marketerTypeOption,
        space,
    streetWidth,
        equipment,
        type,
    officeTypeIds,
        floor,
    location,
        officeAge,
    officeAgeId,
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
    propertyUtilities,
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
        // selectedUnitPriceOptions,
        // selectedUnitPrices,
        // selectedUnitPricesCount,
    officePrices,
        depositType,
        depositAmount,
        viewerName,
        viewerPhone,
        selectedVideo,
        selectedMainImage,
        isMainImageSelected,
        selectedImagesMap,
        selectedImagesCount,
    adsPrices,
        imagesErrorMessage,
        selectedOfficeLicensingFile,
        selectedBuildingLicesnsingFile,
        selectedBuildingLicesnsingFile,
        selectedCivilDefenseFile,
    interfaceAqar,
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
        verifyLicenseNumberModel,
      ];

  OfficeState copyWith({
    VisibilityStates? licenseOfficeState,
    VisibilityStates? marketingRequestState,
    OfficeTypes? officeType,
    String? licenseNumber,
    int? createAd,
    String? name,
    int? categoryId,
    int? id,
    bool? acceptingUserAgreement,
    AdertiserRelationshipOptions? advertiserRelationshipOption,
    TransactionType? transactionType,
    MarketerTypes? marketerTypeOption,
    String? space,
    String? streetWidth,
    String? equipment,
    int? type,
    List<int> ? officeTypeIds,
    int? floor,
    String? officeAge,
    String? officeAgeId,
    ToggleStates? officesCountSelectorState,
    int? officesCount,
    ToggleStates? meetingRoomsCountSelectorState,
    int? meetingRoomsCount,
    ToggleStates? tablesCountSelectorState,
    int? tablesCount,
    ToggleStates? sharedWorkSpacesSelectorState,
    int? sharedWorkSpaces,
    InterfaceAqar? interfaceAqar,
    OfficeLocation? location,
    Map<String, dynamic>? detailsMap,
    int? selectedDetailsCount,
    List<int>? facilities,
    String? description,
    List<int>? features,
    List<int>? propertyUtilities,
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
    // UnitPriceOptions? selectedUnitPriceOption,
    // Map<UnitPriceOptions, num>? selectedUnitPrices,
    // int? selectedUnitPricesCount,
    num? officePrices,
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
    List<OfficePrice>? adsPrices,
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
    VerifyLicenseNumberModel? verifyLicenseNumberModel,
  }) {
    return OfficeState(
      licenseOfficeState: licenseOfficeState ?? this.licenseOfficeState,
      marketingRequestState: marketingRequestState ?? this.marketingRequestState,
      officeType: officeType ?? this.officeType,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      createAd: createAd ?? this.createAd,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      id: id ?? this.id,
      interfaceAqar: interfaceAqar ?? this.interfaceAqar,
      acceptingUserAgreement: acceptingUserAgreement ?? this.acceptingUserAgreement,
      advertiserRelationshipOption: advertiserRelationshipOption ?? this.advertiserRelationshipOption,
      transactionType: transactionType ?? this.transactionType,
      marketerTypeOption: marketerTypeOption ?? this.marketerTypeOption,
      space: space ?? this.space,
      streetWidth: streetWidth ?? this.streetWidth,
      equipment: equipment ?? this.equipment,
      type: type ?? this.type,
      officeTypeIds: officeTypeIds ?? this.officeTypeIds,
      floor: floor ?? this.floor,
      officeAge: officeAge ?? this.officeAge,
      officeAgeId: officeAgeId ?? this.officeAgeId,
      officesCountSelectorState: officesCountSelectorState ?? this.officesCountSelectorState,
      officesCount: officesCount ?? this.officesCount,
      meetingRoomsCountSelectorState: meetingRoomsCountSelectorState ?? this.meetingRoomsCountSelectorState,
      meetingRoomsCount: meetingRoomsCount ?? this.meetingRoomsCount,
      tablesCountSelectorState: tablesCountSelectorState ?? this.tablesCountSelectorState,
      tablesCount: tablesCount ?? this.tablesCount,
      sharedWorkSpacesSelectorState: sharedWorkSpacesSelectorState ?? this.sharedWorkSpacesSelectorState,
      sharedWorkSpaces: sharedWorkSpaces ?? this.sharedWorkSpaces,
      detailsMap: detailsMap ?? this.detailsMap,
      adsPrices: adsPrices ?? this.adsPrices,
      facilities: facilities ?? this.facilities,
      description: description ?? this.description,
      features: features ?? this.features,
      propertyUtilities: propertyUtilities ?? this.propertyUtilities,
      services: services ?? this.services,
      comforts: comforts ?? this.comforts,
      additionalServiceKeys: additionalServiceKeys ?? this.additionalServiceKeys,
      additionalServices: additionalServices ?? this.additionalServices,
      addressPosition: addressPosition ?? this.addressPosition,
      currentMapZoom: currentMapZoom ?? this.currentMapZoom,
      city: city ?? this.city,
      neighborhood: neighborhood ?? this.neighborhood,
      street: street ?? this.street,
      interfaceId: interfaceId ?? this.interfaceId,
      // selectedUnitPriceOptions: selectedUnitPriceOptions ?? this.selectedUnitPriceOptions,
      // selectedUnitPrices: selectedUnitPrices ?? this.selectedUnitPrices,
      // selectedUnitPricesCount: selectedUnitPricesCount ?? this.selectedUnitPricesCount,
      officePrices: officePrices ?? this.officePrices,
      location: location ?? this.location,
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
      selectedOfficeLicensingFile: selectedOfficeLicensingFile ?? this.selectedOfficeLicensingFile,
      selectedBuildingLicesnsingFile: selectedBuildingLicesnsingFile ?? this.selectedBuildingLicesnsingFile,
      selectedCivilDefenseFile: selectedCivilDefenseFile ?? this.selectedCivilDefenseFile,
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
      verifyLicenseNumberModel: verifyLicenseNumberModel ?? this.verifyLicenseNumberModel,
    );
  }
}

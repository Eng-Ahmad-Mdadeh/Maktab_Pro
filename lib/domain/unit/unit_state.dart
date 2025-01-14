
part of 'unit_bloc.dart';

class UnitState extends Equatable {
  String name = '';
  int categoryId;
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
  Map<UniqueKey, GlobalKey> additionalServiceKeys;
  Map<UniqueKey, Map<String, dynamic>> additionalServices;
  int interfaceId;
  List<UnitPriceOptions> selectedUnitPriceOptions;
  Map<UnitPriceOptions, num> selectedUnitPrices;
  int selectedUnitPricesCount;
  DepositTypes depositType;
  num depositAmount;
  String viewerName;
  String viewerPhone;
  int? videoId;
  String videoPath;
  String selectedVideo;
  String mainImage;
  String selectedMainImage;
  bool isMainImageSelected;
  List<OfficeFile> images;
  Map<UniqueKey, String> selectedImagesMap;
  int selectedImagesCount;
  String imagesErrorMessage;
  bool isStepCompleted;
  StepNavigationState stepNavigationState;
  SearchData? searchData;
  Office? createdUnit;
  UnitApiCallState unitApiCallState;
  int progressValue;
  UnitApiCallState imagesApiCallState;
  bool isInitialized = false;
  Office? office;

  UnitState({
    this.name = '',
    this.categoryId = -1,
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
    this.interfaceId = -1,
    required this.selectedUnitPriceOptions,
    required this.selectedUnitPrices,
    this.selectedUnitPricesCount = -1,
    this.depositType = DepositTypes.price,
    this.depositAmount = -2,
    this.viewerName = '',
    this.viewerPhone = '',
    this.videoId,
    this.videoPath = '',
    this.selectedVideo = '',
    this.mainImage = '',
    this.selectedMainImage = '',
    this.isMainImageSelected = true,
    this.images = const [],
    required this.selectedImagesMap,
    this.selectedImagesCount = -1,
    this.imagesErrorMessage = '',
    this.isStepCompleted = false,
    this.stepNavigationState = StepNavigationState.initial,
    this.searchData,
    this.createdUnit,
    this.unitApiCallState = UnitApiCallState.initial,
    this.progressValue = 0,
    this.imagesApiCallState = UnitApiCallState.initial,
    this.isInitialized = false,
    this.office,
  });

  @override
  List<Object?> get props => [
        name,
        categoryId,
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
        additionalServices,
        interfaceId,
        selectedUnitPriceOptions,
        selectedUnitPrices,
        selectedUnitPricesCount,
        depositType,
        depositAmount,
        viewerName,
        viewerPhone,
        videoId,
        videoPath,
        selectedVideo,
        mainImage,
        selectedMainImage,
        isMainImageSelected,
        images,
        selectedImagesMap,
        selectedImagesCount,
        imagesErrorMessage,
        isStepCompleted,
        stepNavigationState,
        createdUnit,
        progressValue,
        imagesApiCallState,
        unitApiCallState,
        isInitialized,
        office,
      ];

  UnitState copyWith({
    String? name,
    int? categoryId,
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
    Map<UniqueKey, GlobalKey>? additionalServiceKeys,
    Map<UniqueKey, Map<String, dynamic>>? additionalServices,
    int? interfaceId,
    List<UnitPriceOptions>? selectedUnitPriceOptions,
    Map<UnitPriceOptions, num>? selectedUnitPrices,
    int? selectedUnitPricesCount,
    DepositTypes? depositType,
    num? depositAmount,
    String? viewerName,
    String? viewerPhone,
    int? videoId,
    String? videoPath,
    String? selectedVideo,
    String? mainImage,
    String? selectedMainImage,
    bool? isMainImageSelected,
    List<OfficeFile>? images,
    Map<UniqueKey, String>? selectedImagesMap,
    int? selectedImagesCount,
    String? imagesErrorMessage,
    bool? isStepCompleted,
    StepNavigationState? stepNavigationState,
    SearchData? searchData,
    Office? createdUnit,
    UnitApiCallState? unitApiCallState,
    int? progressValue,
    UnitApiCallState? imagesApiCallState,
    bool? isInitialized,
    Office? office,
  }) {
    return UnitState(
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
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
      videoId: videoId ?? this.videoId,
      videoPath: videoPath ?? this.videoPath,
      selectedVideo: selectedVideo ?? this.selectedVideo,
      mainImage: mainImage ?? this.mainImage,
      selectedMainImage: selectedMainImage ?? this.selectedMainImage,
      isMainImageSelected: isMainImageSelected ?? this.isMainImageSelected,
      images: images ?? this.images,
      selectedImagesMap: selectedImagesMap ?? this.selectedImagesMap,
      selectedImagesCount: selectedImagesCount ?? this.selectedImagesCount,
      imagesErrorMessage: imagesErrorMessage ?? this.imagesErrorMessage,
      isStepCompleted: isStepCompleted ?? this.isStepCompleted,
      stepNavigationState: stepNavigationState ?? this.stepNavigationState,
      searchData: searchData ?? this.searchData,
      createdUnit: createdUnit ?? this.createdUnit,
      unitApiCallState: unitApiCallState ?? this.unitApiCallState,
      progressValue: progressValue ?? this.progressValue,
      imagesApiCallState: imagesApiCallState ?? this.imagesApiCallState,
      isInitialized: isInitialized ?? this.isInitialized,
      office: office ?? this.office,
    );
  }
}

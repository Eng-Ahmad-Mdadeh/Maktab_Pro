// ignore_for_file: must_be_immutable

part of 'offices_cubit.dart';

enum OfficesApiCallState { initial, loading, update, success, failure }

class OfficesState extends Equatable {
  List<Office> myOffices;
  List<Office> incompleteOffices;
  List<Office> incompleteUnits;
  List<Office> prices;
  List<Office> offers;
  List<Office> coupons;
  List<Office> marketingRequests;
  List<Office> complaints;
  List<Office> calendars;
  Office? selectedOffice;
  SearchData? searchData;
  OfficesApiCallState myOfficesApiCallState;
  OfficesApiCallState incompleteOfficesApiCallState;
  OfficesApiCallState incompleteUnitsApiCallState;
  OfficesApiCallState officeApiCallState;
  OfficesApiCallState searchDataApiCallState;
  OfficesApiCallState pricesApiCallState;
  OfficesApiCallState unitApiCallState;
  OfficesApiCallState offersApiCallState;
  OfficesApiCallState marketingRequestsApiCallState;
  OfficesApiCallState complaintsApiCallState;
  OfficesApiCallState calendarsApiCallState;

  OfficesState({
    this.myOffices = const [],
    this.incompleteOffices = const [],
    this.incompleteUnits = const [],
    this.prices = const [],
    this.offers = const [],
    this.coupons = const [],
    this.marketingRequests = const [],
    this.complaints = const [],
    this.calendars = const [],
    this.selectedOffice,
    this.searchData,
    this.myOfficesApiCallState = OfficesApiCallState.initial,
    this.incompleteOfficesApiCallState = OfficesApiCallState.initial,
    this.incompleteUnitsApiCallState = OfficesApiCallState.initial,
    this.officeApiCallState = OfficesApiCallState.initial,
    this.searchDataApiCallState = OfficesApiCallState.initial,
    this.pricesApiCallState = OfficesApiCallState.initial,
    this.unitApiCallState = OfficesApiCallState.initial,
    this.offersApiCallState = OfficesApiCallState.initial,
    this.marketingRequestsApiCallState = OfficesApiCallState.initial,
    this.complaintsApiCallState = OfficesApiCallState.initial,
    this.calendarsApiCallState = OfficesApiCallState.initial,
  });

  @override
  List<Object?> get props => [
        myOffices,
        incompleteOffices,
        incompleteUnits,
        prices,
        offers,
        coupons,
        marketingRequests,
        complaints,
        calendars,
        selectedOffice,
        searchData,
        myOfficesApiCallState,
        incompleteOfficesApiCallState,
        incompleteUnitsApiCallState,
        officeApiCallState,
        searchDataApiCallState,
        pricesApiCallState,
        unitApiCallState,
        offersApiCallState,
        marketingRequestsApiCallState,
        complaintsApiCallState,
        calendarsApiCallState,
      ];

  OfficesState copyWith({
    List<Office>? myOffices,
    List<Office>? incompleteOffices,
    List<Office>? incompleteUnits,
    List<Office>? prices,
    List<Office>? offers,
    List<Office>? coupons,
    List<Office>? marketingRequests,
    List<Office>? complaints,
    List<Office>? calendars,
    Office? selectedOffice,
    SearchData? searchData,
    OfficesApiCallState? myOfficesApiCallState,
    OfficesApiCallState? incompleteOfficesApiCallState,
    OfficesApiCallState? incompleteUnitsApiCallState,
    OfficesApiCallState? officeApiCallState,
    OfficesApiCallState? searchDataApiCallState,
    OfficesApiCallState? pricesApiCallState,
    OfficesApiCallState? unitApiCallState,
    OfficesApiCallState? offersApiCallState,
    OfficesApiCallState? marketingRequestsApiCallState,
    OfficesApiCallState? complaintsApiCallState,
    OfficesApiCallState? calendarsApiCallState,
  }) {
    return OfficesState(
      myOffices: myOffices ?? this.myOffices,
      incompleteOffices: incompleteOffices ?? this.incompleteOffices,
      incompleteUnits: incompleteUnits ?? this.incompleteUnits,
      prices: prices ?? this.prices,
      offers: offers ?? this.offers,
      coupons: coupons ?? this.coupons,
      marketingRequests: marketingRequests ?? this.marketingRequests,
      complaints: complaints ?? this.complaints,
      calendars: calendars ?? this.calendars,
      selectedOffice: selectedOffice ?? this.selectedOffice,
      searchData: searchData ?? this.searchData,
      myOfficesApiCallState:
          myOfficesApiCallState ?? this.myOfficesApiCallState,
      incompleteOfficesApiCallState:
          incompleteOfficesApiCallState ?? this.incompleteOfficesApiCallState,
      incompleteUnitsApiCallState:
          incompleteUnitsApiCallState ?? this.incompleteUnitsApiCallState,
      officeApiCallState: officeApiCallState ?? this.officeApiCallState,
      searchDataApiCallState:
          searchDataApiCallState ?? this.searchDataApiCallState,
      pricesApiCallState: pricesApiCallState ?? this.pricesApiCallState,
      unitApiCallState: unitApiCallState ?? this.unitApiCallState,
      offersApiCallState: offersApiCallState ?? this.offersApiCallState,
      marketingRequestsApiCallState:
          marketingRequestsApiCallState ?? this.marketingRequestsApiCallState,
      complaintsApiCallState:
          complaintsApiCallState ?? this.complaintsApiCallState,
      calendarsApiCallState:
          calendarsApiCallState ?? this.calendarsApiCallState,
    );
  }
}

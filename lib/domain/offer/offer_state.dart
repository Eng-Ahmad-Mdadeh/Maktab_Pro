// ignore_for_file: must_be_immutable

part of 'offer_bloc.dart';

class OfferState extends Equatable {
  final OfferApiCallState offerApiCallState;
  Office? unit;
  String name;
  DiscountTypes discountType;
  final num discountAmount;
  DateTime? startDate;
  DateTime? endDate;
  Map<int, num> prices;
  List<int> priceTypes;
  int pricesCount;
  bool isValidOfferDateRange;
  Offer? selectedOffer;
  bool isInitialized;

  OfferState({
    this.offerApiCallState = OfferApiCallState.initial,
    this.unit,
    this.name = '',
    this.discountType = DiscountTypes.price,
    this.discountAmount = -2,
    this.startDate,
    this.endDate,
    required this.prices,
    this.priceTypes = const [],
    this.pricesCount = -1,
    this.isValidOfferDateRange = true,
    this.selectedOffer,
    this.isInitialized = false,
  });

  @override
  List<Object?> get props => [
        offerApiCallState,
        unit,
        name,
        discountAmount,
        discountType,
        startDate,
        endDate,
        prices,
        priceTypes,
        pricesCount,
        isValidOfferDateRange,
        selectedOffer,
        isInitialized,
      ];

  OfferState copyWith({
    OfferApiCallState? offerApiCallState,
    Office? unit,
    String? name,
    DiscountTypes? discountType,
    num? discountAmount,
    DateTime? startDate,
    DateTime? endDate,
    Map<int, num>? prices,
    List<int>? priceTypes,
    int? pricesCount,
    bool? isValidOfferDateRange,
    Offer? selectedOffer,
    bool? isInitialized,
  }) {
    return OfferState(
      offerApiCallState: offerApiCallState ?? this.offerApiCallState,
      unit: unit ?? this.unit,
      name: name ?? this.name,
      discountType: discountType ?? this.discountType,
      discountAmount: discountAmount ?? this.discountAmount,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      prices: prices ?? this.prices,
      priceTypes: priceTypes ?? this.priceTypes,
      pricesCount: pricesCount ?? this.pricesCount,
      isValidOfferDateRange:
          isValidOfferDateRange ?? this.isValidOfferDateRange,
      selectedOffer: selectedOffer ?? this.selectedOffer,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }
}

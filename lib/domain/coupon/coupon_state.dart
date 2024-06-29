part of 'coupon_bloc.dart';

class CouponState extends Equatable {
  final OfferApiCallState couponApiCallState;
  final Office? unit;
  final String name;
  final int numberUsed;
  final String code;
  final String message;

  final  DiscountTypes discountType;
  final num discountAmount;
  final DateTime? startDate;
  final DateTime? endDate;
  final Map<int, num> prices;
  final List<int> priceTypes;
  final int pricesCount;
  final bool isValidOfferDateRange;
  final Coupon? selectedOffer;
  final bool isInitialized;

  const CouponState(
      {this.couponApiCallState = OfferApiCallState.initial,
      this.unit,
      this.name = '',
      this.message = '',
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
      this.numberUsed = 0,
      this.code = ''});

  @override
  List<Object?> get props => [
        couponApiCallState,
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
        code,
        numberUsed,
        message
      ];

  CouponState copyWith({
    OfferApiCallState? couponApiCallState,
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
    Coupon? selectedOffer,
    bool? isInitialized,
    int? numberUsed,
    String? code,
    String? message,
  }) {
    return CouponState(
        couponApiCallState: couponApiCallState ?? this.couponApiCallState,
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
        code: code ?? this.code,
        message: message ?? this.message,
        numberUsed: numberUsed ?? this.numberUsed);
  }
}

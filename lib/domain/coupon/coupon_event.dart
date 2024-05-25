part of 'coupon_bloc.dart';

enum DiscountTypes { price, percentage }

sealed class CouponEvent extends Equatable {
  const CouponEvent();

  @override
  List<Object> get props => [];
}

part of 'coupon_bloc.dart';

enum OfferApiCallState { initial, noCall, loading, update, success, failure }

enum DiscountTypes { price, percentage }

sealed class CouponEvent extends Equatable {
  const CouponEvent();

  @override
  List<Object> get props => [];
}

class UpdateCouponStatusEvent extends CouponEvent {
  final int id;

  const UpdateCouponStatusEvent(this.id);
}

class DeleteCouponEvent extends CouponEvent {
  final int id;

  const DeleteCouponEvent(this.id);
}

class SelectUnitEvent extends CouponEvent {
  final Office unit;

  const SelectUnitEvent(this.unit);
}

final class SelectDiscountTypeEvent extends CouponEvent {
final DiscountTypes type;

const SelectDiscountTypeEvent(this.type);
}

final class ChangeDiscountAmountEvent extends CouponEvent {
final String amount;

const ChangeDiscountAmountEvent(this.amount);
}

class SelectUnitPriceEvent extends CouponEvent {
final int id;

const SelectUnitPriceEvent(this.id);
}

class SelectAllUnitPricesEvent extends CouponEvent {}

class SelectOfferDateRangeEvent extends CouponEvent {
final DateTimeRange range;

const SelectOfferDateRangeEvent(this.range);
}

class SetCouponNameEvent extends CouponEvent {
final String name;

const SetCouponNameEvent(this.name);
}
class SetCouponCodeEvent extends CouponEvent {
final String code;

const SetCouponCodeEvent(this.code);
}
class SetCouponUseTimesEvent extends CouponEvent {
final int times;

const SetCouponUseTimesEvent(this.times);
}
class ClearPriceCountEvent extends CouponEvent {}

class CreateCouponEvent extends CouponEvent {
  bool isUpdate;
  int? couponId;
  CreateCouponEvent({this.isUpdate = false,this.couponId});
}

class InitialCouponEvent extends CouponEvent {
final Coupon? coupon;
final Office? unit;

const InitialCouponEvent(this.coupon, this.unit);
}

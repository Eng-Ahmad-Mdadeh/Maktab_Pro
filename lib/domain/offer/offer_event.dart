part of 'offer_bloc.dart';

enum OfferApiCallState { initial, noCall, loading, update, success, failure }

enum DiscountTypes { price, percentage }

sealed class OfferEvent extends Equatable {
  const OfferEvent();

  @override
  List<Object> get props => [];
}

class UpdateOfferStatusEvent extends OfferEvent {
  final int id;

  const UpdateOfferStatusEvent(this.id);
}

class DeleteOfferEvent extends OfferEvent {
  final int id;

  const DeleteOfferEvent(this.id);
}

class SelectUnitEvent extends OfferEvent {
  final Office unit;

  const SelectUnitEvent(this.unit);
}

final class SelectDiscountTypeEvent extends OfferEvent {
  final DiscountTypes type;

  const SelectDiscountTypeEvent(this.type);
}

final class ChangeDiscountAmountEvent extends OfferEvent {
  final String amount;

  const ChangeDiscountAmountEvent(this.amount);
}

class SelectUnitPriceEvent extends OfferEvent {
  final int id;

  const SelectUnitPriceEvent(this.id);
}

class SelectAllUnitPricesEvent extends OfferEvent {}

class SelectOfferDateRangeEvent extends OfferEvent {
  final DateTimeRange range;

  const SelectOfferDateRangeEvent(this.range);
}

class SetOfferNameEvent extends OfferEvent {
  final String name;

  const SetOfferNameEvent(this.name);
}

class ClearPriceCountEvent extends OfferEvent {}

class CreateOfferEvent extends OfferEvent {
  final bool isUpdate;
  final int? offerId;

  const CreateOfferEvent({this.isUpdate = false, this.offerId});
}

class InitialOfferEvent extends OfferEvent {
  final Offer? offer;
  final Office? unit;

  const InitialOfferEvent(this.offer, this.unit);
}

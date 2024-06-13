part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();
}

final class GetOrderEvent extends OrderEvent{
  final int? id;
  const GetOrderEvent(this.id);

  @override
  List<Object?> get props => [];
}

final class SetOrderCancelEvent extends OrderEvent{
  final int id;

  const SetOrderCancelEvent(this.id);

  @override
  List<Object?> get props => [];

}
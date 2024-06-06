part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  const OrderState();
}

final class OrderInitial extends OrderState {
  @override
  List<Object> get props => [];
}

final class OrderLoading extends OrderState {
  @override
  List<Object> get props => [];
}

final class OrderSuccess extends OrderState{
  final OrderModel order;
  const OrderSuccess(this.order);

  @override
  List<Object?> get props => [order];
}

final class OrderFailure extends OrderState {
  final String message;
  const OrderFailure(this.message);

  @override
  List<Object> get props => [];
}

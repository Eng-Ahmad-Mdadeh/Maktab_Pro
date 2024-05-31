part of 'orders_bloc.dart';

sealed class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

final class OrdersInitial extends OrdersState {}
final class OrdersLoading extends OrdersState {}
final class OrdersSuccess extends OrdersState {
  final List<OrderModel> orders;

  const OrdersSuccess(this.orders);

  @override
  List<Object> get props => orders;
}
final class OrdersFailure extends OrdersState {
  final String message;
  const OrdersFailure(this.message);

  @override
  List<Object> get props => [message];
}

part of 'orders_bloc.dart';

sealed class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

final class OrdersInitial extends OrdersState {}
final class OrdersLoading extends OrdersState {}
final class MoreOrdersLoading extends OrdersState {
  final List<OrderModel> prevOrders;
  final int currentPage;
  const MoreOrdersLoading(this.prevOrders, this.currentPage);

  @override
  List<Object> get props => [...prevOrders, currentPage];
}
final class OrdersSuccess extends OrdersState {
  final List<OrderModel> orders;
  final int currentPage;

  const OrdersSuccess(this.orders, this.currentPage);

  @override
  List<Object> get props => [...orders, currentPage];
}

final class OrdersFilter extends OrdersState {
  final List<OrderModel> orders;

  const OrdersFilter(this.orders);

  @override
  List<Object> get props => orders;
}

final class OrdersFailure extends OrdersState {
  final String message;
  const OrdersFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class OrdersWithoutPaginationSuccess extends OrdersState {
  final List<OrderModel> orders;

  const OrdersWithoutPaginationSuccess(this.orders);

  @override
  List<Object> get props => orders;
}
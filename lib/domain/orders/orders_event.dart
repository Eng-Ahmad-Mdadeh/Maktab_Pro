part of 'orders_bloc.dart';

sealed class OrdersEvent extends Equatable {
  const OrdersEvent();
}

final class GetOrdersEvent extends OrdersEvent {
  final int currentPage;

  const GetOrdersEvent(this.currentPage);

  @override
  List<Object?> get props => [];
}

final class GetMoreOrdersEvent extends OrdersEvent {
  final int currentPage, lastPage;

  const GetMoreOrdersEvent(this.currentPage, this.lastPage);

  @override
  List<Object?> get props => [];
}

final class FilterOrders extends OrdersEvent{
  final String value;
  const FilterOrders(this.value);

  @override
  List<Object?> get props => [];
}

final class StatusFilterOrders extends OrdersEvent{
  final String value;
  const StatusFilterOrders(this.value);

  @override
  List<Object?> get props => [];
}

final class GetOrdersWithoutPaginationEvent extends OrdersEvent {
  @override
  List<Object?> get props => [];
}
part of 'orders_bloc.dart';

sealed class OrdersEvent extends Equatable {
  const OrdersEvent();
}

final class GetOrdersEvent extends OrdersEvent {
  @override
  List<Object?> get props => [];
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/order/order_model.dart';
import '../../data/repositories/order_repository.dart';

part 'orders_event.dart';

part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrderRepository _repository;

  OrdersBloc(this._repository) : super(OrdersInitial()) {
    on<GetOrdersEvent>((event, emit) async {
      emit(OrdersLoading());
      try {
        final result = await _repository.getAllOrders();
        result.fold(
          (l) => emit(OrdersFailure(l.message)),
          (r) => emit(OrdersSuccess(r)),
        );
      } catch (e, s) {
        print(s);
        emit(OrdersFailure(e.toString()));
      }
    });
  }
}

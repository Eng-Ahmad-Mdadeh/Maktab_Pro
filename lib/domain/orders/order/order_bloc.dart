import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/order/order_model.dart';
import '../../../data/repositories/order_repository.dart';

part 'order_event.dart';

part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository _repository;

  OrderBloc(this._repository) : super(OrderInitial()) {
    on<GetOrderEvent>((event, emit) async {
      emit(OrderLoading());
      try {
        final result = await _repository.getOrderById(event.id);

        result.fold(
          (l) => emit(OrderFailure(l.message)),
          (r) => emit(
            OrderSuccess(r),
          ),
        );
      } catch (e) {
        emit(OrderFailure(e.toString()));
      }
    });

    on<SetOrderCancelEvent>((event, emit) async {
      emit(OrderLoading());
      try {
        final result = await _repository.setCancel(event.id);

        result.fold(
              (l) => emit(OrderFailure(l.message)),
              (r) => emit(
            OrderSuccess(r),
          ),
        );
      } catch (e) {
        emit(OrderFailure(e.toString()));
      }
    });
  }
}

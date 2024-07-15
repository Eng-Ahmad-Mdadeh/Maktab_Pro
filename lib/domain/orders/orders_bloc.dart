import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/order/order_model.dart';
import '../../data/repositories/order_repository.dart';

part 'orders_event.dart';

part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrderRepository _repository;
  List<OrderModel> _orders = [];
  List<OrderModel> _filteredList = [];
  int currentPage = 1;

  OrdersBloc(this._repository) : super(OrdersInitial()) {
    on<GetOrdersEvent>((event, emit) async {
      emit(OrdersLoading());
      try {
        final result = await _repository.getAllOrders(event.currentPage);
        currentPage = event.currentPage;

        result.fold(
          (l) => emit(OrdersFailure(l.message)),
          (r) {
            _orders = r;
            emit(OrdersSuccess(r, event.currentPage));
          },
        );
      } catch (e) {
        rethrow;
        // emit(OrdersFailure(e.toString()));
      }
    });

    on<GetMoreOrdersEvent>((event, emit) async {
      if (event.currentPage < event.lastPage) {
        emit(MoreOrdersLoading(_orders, event.currentPage));
        try {
          int cPage = event.currentPage;
          cPage++;
          currentPage = cPage;
          final result = await _repository.getAllOrders(cPage);

          result.fold(
            (l) => emit(OrdersFailure(l.message)),
            (r) {
              log("--------------------------------");
              log(_orders.length.toString());
              _orders.addAll(r);
              log(_orders.length.toString());
              log("*--------------------------------*");
              emit(OrdersSuccess(_orders, cPage));
            },
          );
        } catch (e) {
          emit(OrdersFailure(e.toString()));
        }
      }
    });

    on<FilterOrders>((event, emit) {
      if (event.value.isEmpty) {
        emit(OrdersSuccess(_orders, currentPage));
      } else {
        _filteredList = _orders.where((e) {
          final tenantFilter = e.tenant?.username?.contains(event.value) ?? false;
          final idFilter = e.id.toString() == event.value;
          log("______________________________________");
          log("event.value: ${event.value}");
          log("e.id: ${e.id}");
          log("tenantFilter: $tenantFilter");
          log("idFilter: $idFilter");
          return tenantFilter || idFilter;
        }).toList();

        log(_filteredList.length.toString());

        emit(OrdersFilter(_filteredList));
      }
    });

    on<StatusFilterOrders>((event, emit) {
      if (event.value.isEmpty) {
        emit(OrdersSuccess(_orders, currentPage));
      } else {
        emit(OrdersFilter(_orders.where((e) => e.reservation == event.value).toList()));
      }
    });

    on<GetOrdersWithoutPaginationEvent>((event, emit) async {
      emit(OrdersLoading());
      try {
        final result = await _repository.getOrdersWithoutPage();
        result.fold(
              (l) => emit(OrdersFailure(l.message)),
              (r) {
            emit(OrdersSuccess(_orders, currentPage, r));
          },
        );
      } catch (e, s) {
        log(e.toString());
        log(s.toString());
        emit(OrdersFailure(e.toString()));
      }
    });
  }
}

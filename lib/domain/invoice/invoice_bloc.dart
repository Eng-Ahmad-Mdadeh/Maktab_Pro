import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/invoice/invoice_model.dart';
import '../../data/repositories/invoice_repository.dart';

part 'invoice_event.dart';

part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  final InvoiceRepository _repository;
  List<Invoice> _invoices = [];
  int _currentPage = 1;
  int _lastPage = 1;

  InvoiceBloc(this._repository) : super(InitialInvoiceState()) {
    on<GetInvoicesEvent>((event, emit) async {
      emit(LoadingInvoiceState());
      try {
        final result = await _repository.getInvoices(_currentPage);
        result.fold(
          (l) => emit(FailureInvoiceState(l.message)),
          (r) {
            _invoices = List<Invoice>.from(r.invoicePagination!.data);
            _currentPage = r.invoicePagination?.currentPage?.toInt() ?? 1;
            _lastPage = r.invoicePagination?.lastPage?.toInt() ?? 1;
            emit(SuccessInvoiceState(_invoices));
          },
        );
      } catch (e) {
        emit(FailureInvoiceState(e.toString()));
      }
    });

    on<GetMoreInvoicesEvent>((event, emit) async {
      if (_currentPage < _lastPage) {
        try {
          final result = await _repository.getInvoices(_currentPage);
          result.fold(
            (l) => emit(FailureInvoiceState(l.message)),
            (r) {
              final i = List<Invoice>.from(r.invoicePagination!.data);
              _invoices.addAll(i);
              emit(SuccessInvoiceState(_invoices));
            },
          );
        } catch (e) {
          emit(FailureInvoiceState(e.toString()));
        }
      }
    });
  }
}

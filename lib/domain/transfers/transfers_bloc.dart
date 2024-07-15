import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/data/models/transfers/transfer_pagination_model.dart';
import '../../data/repositories/transfer_money_repository.dart';
import 'transfers_event.dart';
import 'transfers_state.dart';

class TransferBloc extends Bloc<TransfersEvent, TransfersState> {
  final TransferMoneyRepository _transferMoneyRepository;

  TransferBloc({
    required TransferMoneyRepository transferMoneyRepository,
  })  : _transferMoneyRepository = transferMoneyRepository,
        super(const TransfersState()) {
    on<GetTransfersEvent>((event, emit) async {
      emit(
        state.copyWith(
          fetchingDataState: event.page == 1 ? FetchingDataStates.loading : FetchingDataStates.paginate,
        ),
      );
      try {
        var result = await _transferMoneyRepository.getAllTransfers(page: event.page);
        result.fold(
          (failure) {
            log(failure.message);
            emit(state.copyWith(
              fetchingDataState: FetchingDataStates.failure,
            ));
          },
          (transferPagination) {
            List<TransferModel> transfers = state.transfers.toList();
            if (event.page == 1) {
              log("RESET PAGINATION");
              transfers = [];
            }
            transfers.addAll(transferPagination.transfers);
            emit(state.copyWith(
              fetchingDataState: FetchingDataStates.success,
              page: state.page + 1,
              total: transferPagination.total,
              transfers: transfers,
            ));
          },
        );
      } catch (e) {
        log(e.toString());
        log(e.toString());
        // rethrow;
        emit(state.copyWith(
          fetchingDataState: FetchingDataStates.failure,
        ));
      }
    });
  }
}

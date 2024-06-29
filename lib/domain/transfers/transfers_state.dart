import 'package:equatable/equatable.dart';
import 'package:maktab_lessor/data/models/transfers/transfer_pagination_model.dart';

enum FetchingDataStates { initial, loading, success, failure, paginate }

class TransfersState extends Equatable {
  final List<TransferModel> transfers;
  final FetchingDataStates fetchingDataState;
  final int total;
  final int page;

  const TransfersState({
    this.transfers = const [],
    this.fetchingDataState = FetchingDataStates.initial,
    this.total = 1,
    this.page = 1,
  });

  @override
  List<Object?> get props => [transfers, fetchingDataState, total, page];

  TransfersState copyWith({
    List<TransferModel>? transfers,
    FetchingDataStates? fetchingDataState,
    int? total,
    int? page,
  }) {
    return TransfersState(
      transfers: transfers ?? this.transfers,
      fetchingDataState: fetchingDataState ?? this.fetchingDataState,
      total: total ?? this.total,
      page: page ?? this.page,
    );
  }
}

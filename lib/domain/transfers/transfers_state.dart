import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maktab/data/models/transfers/transfer_pagination_model.dart';

enum FetchingDataStates { initial, loading, success, failure, paginate }

class TransfersState extends Equatable {
  List<TransferModel> transfers;
  FetchingDataStates fetchingDataState;
  int total;
  int page;

  TransfersState(
      {this.transfers = const [],
      this.fetchingDataState = FetchingDataStates.initial,
      this.total = 1,
      this.page = 1});

  @override
  List<Object?> get props => [transfers, fetchingDataState, total, page];

  TransfersState copyWith(
      {List<TransferModel>? transfers,
      FetchingDataStates? fetchingDataState,
      int? total,
      int? page}) {
    return TransfersState(
        transfers: transfers ?? this.transfers,
        fetchingDataState: fetchingDataState ?? this.fetchingDataState,
        total: total ?? this.total,
        page: page ?? this.page);
  }
}

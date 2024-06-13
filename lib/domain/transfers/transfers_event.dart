import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

sealed class TransfersEvent extends Equatable {
  const TransfersEvent();

  @override
  List<Object> get props => [];
}

final class GetTransfersEvent extends TransfersEvent {
  final int page;

  const GetTransfersEvent({required this.page});
}

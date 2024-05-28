import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


sealed class TransfersEvent extends Equatable {
  const TransfersEvent();

  @override
  List<Object> get props => [];
}


final class GetTransfersEvent extends TransfersEvent {
int page;

GetTransfersEvent({required this.page});
}

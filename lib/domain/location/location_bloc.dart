// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maktab_lessor/core/helpers/location_helper.dart';
import 'package:maktab_lessor/core/services/service_locator.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitialState()) {
    on<GetCurrentLoction>((event, emit) async {
      emit(LocationLoadingState());
      Position? currentPosition =
          await locator<LocationHelper>().getCurrentLocation();
      if (currentPosition != null) {
        emit(LocationSuccessState(currentPosition));
      } else {
        emit(LocationLoadingState());
      }
    });
  }
}

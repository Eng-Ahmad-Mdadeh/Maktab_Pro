import 'package:flutter_bloc/flutter_bloc.dart';

import '../entity/dates_selection_entity.dart';

class DatesSelectCubit extends Cubit<DatesSelectionEntity> {
  DatesSelectCubit() : super(const DatesSelectionEntity());

  void setTime(int? start, int? end) {
    emit(state.copyWith(startTime: start, endTime: end));
  }

  void setDates(DateTime? start, DateTime? end) {
    emit(state.copyWith(startDate: start, endDate: end));
  }
}
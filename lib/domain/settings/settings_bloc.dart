import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maktab/data/repositories/settings_repository.dart';

import '../../data/models/office/search_data_model.dart';
import '../../data/models/settings/general_setting_model.dart';
import '../../data/repositories/office_repository.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class GeneralSettingBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _repository;

  GeneralSettingBloc(this._repository) : super(SettingsInitial()) {
    on<GetGeneralSettings>((event, emit) async {
      emit(SettingsLoading());
      try {
        final result = await _repository.getGeneralSettings();

        result.fold(
          (l) => emit(SettingsFailure(l.message)),
          (r) => emit(SettingsSuccess(r)),
        );
      } catch (e) {
        emit(SettingsFailure(e.toString()));
      }
    });

    add(GetGeneralSettings());
  }
}

class SearchDataBloc extends Bloc<SearchDataEvent, SearchDataState> {
  final OfficeRepository _repository;

  SearchDataBloc(this._repository) : super(SearchDataInitial()) {
    on<GetSearchDataEvent>((event, emit) async {
      emit(SearchDataLoading());

      try {
        final result = await _repository.getSearchData();
        result.fold(
          (l) => emit(SearchDataFailure(l.message)),
          (r) => emit(SearchDataSuccess(r)),
        );
      } catch (e) {
        emit(SearchDataFailure(e.toString()));
      }
    });
  }
}

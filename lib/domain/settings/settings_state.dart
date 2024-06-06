part of 'settings_bloc.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();
}

final class SettingsInitial extends SettingsState {
  @override
  List<Object> get props => [];
}

final class SettingsSuccess extends SettingsState {
  final GeneralSettingsModel generalSettings;
  const SettingsSuccess(this.generalSettings);

  @override
  List<Object> get props => [];
}

final class SettingsLoading extends SettingsState {
  @override
  List<Object> get props => [];
}

final class SettingsFailure extends SettingsState {
  final String message;
  const SettingsFailure(this.message);
  @override
  List<Object> get props => [];
}


// search data

sealed class SearchDataState extends Equatable {
  const SearchDataState();
}

final class SearchDataInitial extends SearchDataState {
  @override
  List<Object> get props => [];
}

final class SearchDataSuccess extends SearchDataState {
  final SearchData searchData;
  const SearchDataSuccess(this.searchData);

  @override
  List<Object> get props => [];
}

final class SearchDataLoading extends SearchDataState {
  @override
  List<Object> get props => [];
}

final class SearchDataFailure extends SearchDataState {
  final String message;
  const SearchDataFailure(this.message);
  @override
  List<Object> get props => [];
}
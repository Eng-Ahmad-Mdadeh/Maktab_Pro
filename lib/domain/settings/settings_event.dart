part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();
}

final class GetGeneralSettings extends SettingsEvent{
  @override
  List<Object?> get props => [];
}

sealed class SearchDataEvent extends Equatable{
  const SearchDataEvent();
}

final class GetSearchDataEvent extends SearchDataEvent{
  @override
  List<Object?> get props => [];
}
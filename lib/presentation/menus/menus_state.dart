part of 'menus_bloc.dart';

sealed class MenusState extends Equatable {
  const MenusState();
}

final class MenusInitial extends MenusState {
  @override
  List<Object> get props => [];
}

final class MenusLoading extends MenusState {
  @override
  List<Object> get props => [];
}

final class MenusLoaded extends MenusState {
  final FooterModel footer;

  const MenusLoaded(this.footer);

  @override
  List<Object> get props => [];
}

final class MenusFailed extends MenusState {
  final String message;

  const MenusFailed(this.message);

  @override
  List<Object> get props => [];
}
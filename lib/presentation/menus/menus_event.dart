part of 'menus_bloc.dart';

sealed class MenusEvent extends Equatable {
  const MenusEvent();
}

final class GetFooterEvent extends MenusEvent{
  @override
  List<Object?> get props => [];
}
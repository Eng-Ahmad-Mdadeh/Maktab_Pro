// ignore_for_file: depend_on_referenced_packages, prefer_const_literals_to_create_immutables

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState(NavbarItem.home, 0, []));

  void getNavBarItem(int index) {
    switch (index) {
      case 0:
        emit(NavigationState(NavbarItem.home, 0, state.currentIndexs));
        break;
      case 1:
        emit(NavigationState(NavbarItem.calendar, 1, state.currentIndexs));
        break;
      case 2:
        emit(NavigationState(NavbarItem.orders, 2, state.currentIndexs));
        break;
      case 3:
        emit(NavigationState(NavbarItem.offices, 3, state.currentIndexs));
        break;
      case 4:
        emit(NavigationState(NavbarItem.more, 4, state.currentIndexs));
        break;
    }
  }
}

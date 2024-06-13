// ignore_for_file: must_be_immutable

part of 'navigation_cubit.dart';

enum NavbarItem { home, calendar, orders, offices, more }

class NavigationState extends Equatable {
  final NavbarItem navbarItem;
  final int index;
  List<int> currentIndexs;

  NavigationState(this.navbarItem, this.index, this.currentIndexs);

  @override
  List<Object> get props => [navbarItem, index, currentIndexs];
}

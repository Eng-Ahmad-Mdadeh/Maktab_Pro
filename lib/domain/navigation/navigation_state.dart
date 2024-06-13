import 'package:equatable/equatable.dart';

enum NavigationStates { home, addOffice, orders, offices, more }

class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

final class HomeNavigationState extends NavigationState{}
final class OrdersNavigationState extends NavigationState{}
final class AddOfficeNavigationState extends NavigationState{}
final class OfficesNavigationState extends NavigationState{}
final class MoreNavigationState extends NavigationState{}

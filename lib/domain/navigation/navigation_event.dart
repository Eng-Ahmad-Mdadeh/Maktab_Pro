import 'package:equatable/equatable.dart';

sealed class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class HomeNavigationEvent extends NavigationEvent{}
class CalendarNavigationEvent extends NavigationEvent{}
class OrdersNavigationEvent extends NavigationEvent{}
class OfficesNavigationEvent extends NavigationEvent{}
class MoreNavigationEvent extends NavigationEvent{}

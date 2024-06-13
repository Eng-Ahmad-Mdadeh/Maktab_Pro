import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigation_event.dart';
import 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(HomeNavigationState()){
    on<HomeNavigationEvent>((event, emit){
      emit(HomeNavigationState());
    });

    on<AddOfficeNavigationEvent>((event, emit){
      emit(AddOfficeNavigationState());
    });

    on<OrdersNavigationEvent>((event, emit){
      emit(OrdersNavigationState());
    });

    on<OfficesNavigationEvent>((event, emit){
      emit(OfficesNavigationState());
    });

    on<MoreNavigationEvent>((event, emit){
      emit(MoreNavigationState());
    });
  }
}

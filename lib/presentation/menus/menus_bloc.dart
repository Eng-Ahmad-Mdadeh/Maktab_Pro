import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/domain/menus/footer_model.dart';

import '../../data/repositories/menus_repository.dart';

part 'menus_event.dart';

part 'menus_state.dart';

class MenusBloc extends Bloc<MenusEvent, MenusState> {
  final MenusRepository _repository;

  MenusBloc(this._repository) : super(MenusInitial()) {
    on<GetFooterEvent>((event, emit) async {
      emit(MenusLoading());
      try {
        final result = await _repository.getFooter();
        result.fold((l) => emit(MenusFailed(l.message)), (r) => emit(MenusLoaded(r)));
      } catch (e, s) {
        log(e.toString());
        log(s.toString());
        emit(MenusFailed(e.toString()));
      }
    });
  }
}

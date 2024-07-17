import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maktab_lessor/data/models/map/map_search_suggestion.dart';
import 'package:maktab_lessor/data/repositories/map_repository.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final MapRepository _mapRepository;

  MapCubit({required MapRepository mapRepository})
      : _mapRepository = mapRepository,
        super(MapInitialState());

  Future<List<MapSearchSuggestion>> getSearchSuggestions(input) async {
    var result = await _mapRepository.getPlaceSearchSuggesions(input);
    log("getSearchSuggestions 1");
    return result.fold(
      (failure) {
        log("getSearchSuggestions 2");
        log(failure.message);
        return [];
      },
      (suggestions) {
        log("getSearchSuggestions 3");
        log(suggestions.toString());
        return suggestions;
      },
    );
  }
}

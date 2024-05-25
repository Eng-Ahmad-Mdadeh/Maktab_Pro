import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maktab/data/models/map/map_search_suggestion.dart';
import 'package:maktab/data/repositories/map_repository.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final MapRepository _mapRepository;

  MapCubit({required MapRepository mapRepository})
      : _mapRepository = mapRepository,
        super(MapInitialState());

  Future<List<MapSearchSuggestion>> getSearchSuggestions(input) async {
    var result = await _mapRepository.getPlaceSearchSuggesions(input);
    return result.fold(
      (failure) => [],
      (suggestions) => suggestions,
    );
  }
}

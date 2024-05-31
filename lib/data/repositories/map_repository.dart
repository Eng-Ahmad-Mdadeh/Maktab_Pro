import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maktab/core/classes/exception/app_exception.dart';
import 'package:maktab/core/constants/app_constants.dart';
import 'package:maktab/data/data_sources/remote/map_remote_data_source.dart';
import 'package:maktab/data/models/map/map_place.dart';
import 'package:maktab/data/models/map/map_search_suggestion.dart';

class MapRepository {
  final MapRemoteDataSource _mapRemoteDataSource;

  MapRepository({
    required MapRemoteDataSource mapRemoteDataSource,
  }) : _mapRemoteDataSource = mapRemoteDataSource;

  Future<Either<AppException, MapPlace>> getAddressDetails({lat, long}) async {
    final result = await _mapRemoteDataSource.getAddressDetails({
      'latlng': '$lat,$long',
      'key': AppConstants.GOOGLE_MAP_API_KEY,
      'language': 'ar',
    });
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right['results'] != null) {
          MapPlace place = MapPlace.fromJsonList(right['results']);
          return Right(place);
        } else {
          return Left(AppException('Error'));
        }
      },
    );
  }

  Future<Either<AppException, List<MapSearchSuggestion>>>
      getPlaceSearchSuggesions(String input) async {
    final result = await _mapRemoteDataSource.getPlaceSearchSuggesions({
      'input': input,
      'key': AppConstants.GOOGLE_MAP_API_KEY,
      'language': 'ar',
      //'types': 'address',
    });
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right['status'] == 'OK') {
          return Right(right['predictions']
              .map<MapSearchSuggestion>(
                  (suggestion) => MapSearchSuggestion.fromJson(suggestion))
              .toList());
        } else {
          return const Right([]);
        }
      },
    );
  }

  Future<Either<AppException, LatLng?>> getPlaceDetails(String placeId) async {
    final result = await _mapRemoteDataSource.getPlaceDetails({
      'place_id': placeId,
      'key': AppConstants.GOOGLE_MAP_API_KEY,
    });
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right['status'] == 'OK') {
          var location = right['result']['geometry']['location'];
          // log(location.toString());
          return Right(LatLng(location['lat'], location['lng']));
        } else {
          return const Right(null);
        }
      },
    );
  }
}

import 'package:dartz/dartz.dart';
import 'package:maktab/core/classes/exception/app_exception.dart';
import 'package:maktab/core/network/api_endpoints.dart';
import 'package:maktab/core/network/network_helper.dart';
import 'package:maktab/core/services/service_locator.dart';
import 'package:maktab/data/data_sources/remote/base_remote_data_source.dart';
import 'package:maktab/data/models/response/response_model.dart' as r;

class MapRemoteDataSource extends BaseRemoteDataSource<r.Response> {
  MapRemoteDataSource() : super('');

  Future<Either<AppException, Map<String, dynamic>>> getAddressDetails(
      data) async {
    try {
      final Either response = await locator<NetworkHelper>().get(
          ApiEndpoints.googleMapsApi + ApiEndpoints.geocoding,
          queryParams: data);
      return response.fold(
        (error) => Left(error),
        (right) {
          return Right(right);
        },
      );
    } on AppException catch (e) {
      return Left(e);
    }
  }

  Future<Either<AppException, Map<String, dynamic>>> getPlaceSearchSuggesions(
      data) async {
    try {
      final Either response = await locator<NetworkHelper>().get(
          ApiEndpoints.googleMapsApi + ApiEndpoints.placeAutocomplete,
          queryParams: data);
      return response.fold(
        (error) => Left(error),
        (right) {
          return Right(right);
        },
      );
    } on AppException catch (e) {
      return Left(e);
    }
  }

  Future<Either<AppException, Map<String, dynamic>>> getPlaceDetails(
      data) async {
    try {
      final Either response = await locator<NetworkHelper>().get(
          ApiEndpoints.googleMapsApi + ApiEndpoints.placeDetails,
          queryParams: data);
      return response.fold(
        (error) => Left(error),
        (right) {
          return Right(right);
        },
      );
    } on AppException catch (e) {
      return Left(e);
    }
  }
}

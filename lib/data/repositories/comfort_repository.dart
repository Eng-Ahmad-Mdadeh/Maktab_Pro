import 'package:dartz/dartz.dart';
import 'package:maktab/core/classes/exception/app_exception.dart';
import 'package:maktab/core/classes/exception/data_exceptions.dart';
import 'package:maktab/data/data_sources/remote/comfort_remote_data_source.dart';
import 'package:maktab/data/models/comfort/comfort_model.dart';
import 'package:maktab/data/models/office/office_model.dart';
import 'package:maktab/data/models/response/response_model.dart' as r;

class ComfortRepository {
  final ComfortRemoteDataSource _remoteDataSource;

  ComfortRepository(this._remoteDataSource);

  Future<Either<AppException, Office>> addToOffice({
    required int adsId,
    required List<Comfort> comforts,
  }) async {
    return _executeRequest(
        action: () => _remoteDataSource.addToOffice(
            adsId, _createComfortsDataMap(comforts)));
  }

  Future<Either<AppException, Office>> updateToOffice({
    required int adsId,
    required List<Comfort> comforts,
  }) async {
    return _executeRequest(
        action: () => _remoteDataSource.updateToOffice(
            adsId, _createComfortsDataMap(comforts)));
  }

  Future<Either<AppException, Office>> deleteFromOffice(
    int officeId,
    int comfortId,
  ) async {
    final comfortData = {"comfort_id": comfortId};
    return _executeRequest(
        action: () =>
            _remoteDataSource.deleteFromOffice(officeId, comfortData));
  }

  Future<Either<AppException, Office>> _executeRequest({
    required Future<Either<AppException, r.Response>> Function() action,
  }) async {
    try {
      final result = await action();
      return result.fold(
        (error) => Left(error),
        (right) => _handleResult(right.data),
      );
    } catch (e) {
      return Left(ConversionException(e.toString()));
    }
  }

  Either<AppException, Office> _handleResult(Map<String, dynamic> right) {
    try {
      final Office comforts = Office.fromJson(right);
      return Right(comforts);
    } catch (e) {
      return Left(ConversionException(e.toString()));
    }
  }

  Map<String, dynamic> _createComfortsDataMap(List<Comfort> comforts) {
    final comfortsData = <String, dynamic>{};
    for (int i = 0; i < comforts.length; i++) {
      comfortsData.addAll({
        'comforts[$i][id]': comforts[i].id,
        'comforts[$i][comfort_id]': comforts[i].id,
      });
    }
    return comfortsData;
  }
}

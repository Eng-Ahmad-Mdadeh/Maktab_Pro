import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';
import 'package:maktab_lessor/core/classes/exception/data_exceptions.dart';
import 'package:maktab_lessor/data/data_sources/remote/facility_remote_data_source.dart';
import 'package:maktab_lessor/data/models/facility/facility_model.dart';
import 'package:maktab_lessor/data/models/office/office_model.dart';
import 'package:maktab_lessor/data/models/response/response_model.dart' as r;

class FacilityRepository {
  final FacilityRemoteDataSource _remoteDataSource;

  FacilityRepository(this._remoteDataSource);

  Future<Either<AppException, Office>> addToOffice({
    required int adsId,
    required List<Facility> facilities,
  }) async {
    return _executeRequest(
        action: () => _remoteDataSource.addToOffice(
            adsId, _createFacilitiesDataMap(facilities)));
  }

  Future<Either<AppException, Office>> updateToIOffice({
    required int adsId,
    required List<Facility> facilities,
  }) async {
    return _executeRequest(
        action: () => _remoteDataSource.updateToOffice(
            adsId, _createFacilitiesDataMap(facilities)));
  }

  Future<Either<AppException, Office>> deleteFromOffice(
    int officeId,
    int facilityId,
  ) async {
    final facilityData = {"facility_id": facilityId};
    return _executeRequest(
        action: () =>
            _remoteDataSource.deleteFromOffice(officeId, facilityData));
  }

  Future<Either<AppException, Office>> _executeRequest({
    required Future<Either<AppException, r.Response>> Function() action,
  }) async {
    try {
      final result = await action();
      return result.fold(
        (error) => Left(error),
        (right) => _handleResult(right),
      );
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      return Left(ConversionException(e.toString()));
    }
  }

  Either<AppException, Office> _handleResult(right) {
    try {
      final Office services = Office.fromJson(right.data);
      return Right(services);
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      return Left(ConversionException(e.toString()));
    }
  }

  Map<String, dynamic> _createFacilitiesDataMap(List<Facility> facilities) {
    final facilitiesData = <String, dynamic>{};
    for (int i = 0; i < facilities.length; i++) {
      facilitiesData.addAll({
        'facilities[$i][id]': facilities[i].id,
        'facilities[$i][facility_id]': facilities[i].id,
      });
    }
    return facilitiesData;
  }
}

import 'package:dartz/dartz.dart';
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';
import 'package:maktab_lessor/core/classes/exception/data_exceptions.dart';
import 'package:maktab_lessor/data/data_sources/remote/service_remote_data_source.dart';
import 'package:maktab_lessor/data/models/office/office_model.dart';
import 'package:maktab_lessor/data/models/office/office_service_model.dart';
import 'package:maktab_lessor/data/models/response/response_model.dart' as r;

class ServiceRepository {
  final ServiceRemoteDataSource _remoteDataSource;

  ServiceRepository(this._remoteDataSource);

  Future<Either<AppException, Office>> addToOffice({
    required int adsId,
    required List<OfficeService> services,
  }) async {
    return _executeRequest(
      action: () => _remoteDataSource.addToOffice(
          adsId, _createServicesDataMap(services)),
    );
  }

  Future<Either<AppException, Office>> updateToOffice({
    required int adsId,
    required List<OfficeService> services,
  }) async {
    return _executeRequest(
      action: () => _remoteDataSource.updateToOffice(
          adsId, _createServicesDataMap(services)),
    );
  }

  Future<Either<AppException, Office>> deleteFromOffice(
      int officeId, int serviceId) async {
    final serviceData = {"service_id": serviceId};
    return _executeRequest(
      action: () => _remoteDataSource.deleteFromOffice(officeId, serviceData),
    );
  }

  Map<String, dynamic> _createServicesDataMap(List<OfficeService> services) {
    final servicesData = <String, dynamic>{};
    for (int i = 0; i < services.length; i++) {
      servicesData.addAll({
        'services[$i][id]': services[i].id,
        'services[$i][ar_name]': services[i].arName,
        'services[$i][en_name]': services[i].enName,
        'services[$i][status]': services[i].status,
        'services[$i][price]': services[i].price,
      });
    }
    return servicesData;
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
    } catch (e) {
      return Left(ConversionException(e.toString()));
    }
  }

  Either<AppException, Office> _handleResult(right) {
    try {
      final Office services = Office.fromJson(right.data);
      return Right(services);
    } catch (e) {
      return Left(ConversionException(e.toString()));
    }
  }
}

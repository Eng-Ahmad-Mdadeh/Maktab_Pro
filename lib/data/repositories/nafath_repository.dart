import 'package:dartz/dartz.dart';
import 'package:maktab_lessor/data/data_sources/remote/nafath_remote_data_source.dart';
import 'package:maktab_lessor/data/models/nafath/request_status_model.dart';
import 'package:maktab_lessor/data/models/nafath/send_request_model.dart';


import '../../core/classes/exception/app_exception.dart';

class NafathRepository  {
  final NafathRemoteDataSource _remoteDataSource;

  NafathRepository(this._remoteDataSource);

  Future<Either<AppException, SendRequestModel?>> sendRequest(String data) async {
    final result = await _remoteDataSource.sendRequest(data);
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          if (right.data != null) {
            final Map<String, dynamic> newData = Map.from(right.data as Map)..addAll({"message": right.message});
            return Right(SendRequestModel.fromJson(newData));
          } else {
            return Right(SendRequestModel.fromJson({"message": right.message}));
          }
        } catch (e) {
          return Left(AppException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, RequestStatusModel?>> requestStatus() async {
    final result = await _remoteDataSource.requestStatus();
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          if (right.data != null) {
            final Map<String, dynamic> newData = Map.from(right.data as Map)..addAll({"message": right.message});
            return Right(RequestStatusModel.fromJson(newData));
          } else {
            return Right(RequestStatusModel.fromJson({"message": right.message}));
          }
        } catch (e) {
          return Left(AppException(e.toString()));
        }
      },
    );
  }
}

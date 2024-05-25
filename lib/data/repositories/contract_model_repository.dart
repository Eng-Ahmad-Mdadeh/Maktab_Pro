import 'package:dartz/dartz.dart';
import 'package:maktab/core/classes/exception/app_exception.dart';
import 'package:maktab/core/classes/exception/data_exceptions.dart';
import 'package:maktab/data/data_sources/remote/contract_model_remote_data_source.dart';
import 'package:maktab/data/models/contract/contract_model_model.dart';

class ContractModelRepository {
  final ContractModelRemoteDataSource _remoteDataSource;

  ContractModelRepository(this._remoteDataSource);

  Future<Either<AppException, List<ContractModel>>> getContractModels() async {
    final result = await _remoteDataSource.getContractModels();
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final List<ContractModel> contracts = List<ContractModel>.from(
            right.data.map((dynamic data) => ContractModel.fromJson(data)),
          );
          return Right(contracts);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, List<ContractModel>>>
      getReadyContractModels() async {
    final result = await _remoteDataSource.getReadyContractModels();
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final List<ContractModel> contracts = List<ContractModel>.from(
            right.data.map((dynamic data) => ContractModel.fromJson(data)),
          );
          return Right(contracts);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, ContractModel>> getContractModelById(id) async {
    final result = await _remoteDataSource.getContractModelById(id);
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final ContractModel contract = ContractModel.fromJson(right.data);
          return Right(contract);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, ContractModel>> createContractModel({
    required String name,
    required String description,
    required String content,
    required String status,
  }) async {
    try {
      final contractModelData = _createContractModelDataMap(
          name: name,
          description: description,
          content: content,
          status: status);
      final result =
          await _remoteDataSource.createContractModel(contractModelData);
      return result.fold(
        (error) => Left(error),
        (right) {
          try {
            final ContractModel contract = ContractModel.fromJson(right.data);
            return Right(contract);
          } catch (e) {
            return Left(ConversionException(e.toString()));
          }
        },
      );
    } catch (e) {
      return Left(ConversionException(e.toString()));
    }
  }

  Future<Either<AppException, ContractModel>> updateContractModel({
    required int id,
    required String name,
    required String description,
    required String content,
    required String status,
  }) async {
    try {
      final contractModelData = _createContractModelDataMap(
          name: name,
          description: description,
          content: content,
          status: status);
      final result =
          await _remoteDataSource.updateContractModel(id, contractModelData);
      return result.fold(
        (error) => Left(error),
        (right) {
          try {
            final ContractModel contract = ContractModel.fromJson(right.data);
            return Right(contract);
          } catch (e) {
            return Left(ConversionException(e.toString()));
          }
        },
      );
    } catch (e) {
      return Left(ConversionException(e.toString()));
    }
  }

  Future<Either<AppException, void>> deleteContractModel(id) async {
    final result = await _remoteDataSource.deleteContractModel(id);
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          return const Right(null);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, ContractModel>> setContractModelStatus(id) async {
    final result = await _remoteDataSource.setContractModelStatus(id);
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final ContractModel contract = ContractModel.fromJson(right.data);
          return Right(contract);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Map<String, dynamic> _createContractModelDataMap({
    required String name,
    required String description,
    required String content,
    required String status,
  }) {
    return {
      'name': name,
      'description': description,
      'content_contract_model': content,
      'status': status,
    };
  }
}

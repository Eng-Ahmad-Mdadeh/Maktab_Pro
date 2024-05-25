import 'package:dartz/dartz.dart';
import 'package:maktab/core/classes/exception/app_exception.dart';
import 'package:maktab/core/classes/exception/data_exceptions.dart';
import 'package:maktab/data/data_sources/remote/contract_remote_data_source.dart';
import 'package:maktab/data/models/contract/contract_model.dart';

class ContractModelRepository {
  final ContractRemoteDataSource _remoteDataSource;

  ContractModelRepository(this._remoteDataSource);

  Future<Either<AppException, List<Contract>>> getContract() async {
    final result = await _remoteDataSource.getContract();
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final List<Contract> contracts = List<Contract>.from(
            right.data.map((dynamic data) => Contract.fromJson(data)),
          );
          return Right(contracts);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, Contract>> getContractById(id) async {
    final result = await _remoteDataSource.getContractById(id);
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final Contract contract = Contract.fromJson(right.data);
          return Right(contract);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, Contract>> createContract({
    required int status,
    required String statusContract,
    required String type,
    required num totalPrice,
    required int ownershipNumber,
    required String contentContract,
    required int orderId,
  }) async {
    try {
      final contractData = _createContractDataMap(
          status: status,
          statusContract: statusContract,
          type: type,
          totalPrice: totalPrice,
          ownershipNumber: ownershipNumber,
          contentContract: contentContract,
          orderId: orderId);
      final result = await _remoteDataSource.createContract(contractData);
      return result.fold(
        (error) => Left(error),
        (right) {
          try {
            final Contract contract = Contract.fromJson(right.data);
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

  Future<Either<AppException, Contract>> updateContract({
    required int id,
    required int status,
    required String statusContract,
    required String type,
    required num totalPrice,
    required int ownershipNumber,
    required String contentContract,
    required int orderId,
  }) async {
    try {
      final contractData = _createContractDataMap(
          status: status,
          statusContract: statusContract,
          type: type,
          totalPrice: totalPrice,
          ownershipNumber: ownershipNumber,
          contentContract: contentContract,
          orderId: orderId);
      final result = await _remoteDataSource.updateContract(id, contractData);
      return result.fold(
        (error) => Left(error),
        (right) {
          try {
            final Contract contract = Contract.fromJson(right.data);
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

  Future<Either<AppException, void>> deleteContract(id) async {
    final result = await _remoteDataSource.deleteContract(id);
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

  Map<String, dynamic> _createContractDataMap({
    required int status,
    required String statusContract,
    required String type,
    required num totalPrice,
    required int ownershipNumber,
    required String contentContract,
    required int orderId,
  }) {
    return {
      'status': status,
      'statusContract': statusContract,
      'type': type,
      'totalPrice': totalPrice,
      'ownershipNumber': ownershipNumber,
      'contentContract': contentContract,
      'orderId': orderId,
    };
  }
}

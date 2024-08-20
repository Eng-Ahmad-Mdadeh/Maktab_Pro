import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';
import 'package:maktab_lessor/core/classes/exception/data_exceptions.dart';
import 'package:maktab_lessor/data/data_sources/remote/contract_remote_data_source.dart';
import 'package:maktab_lessor/data/models/contract/contract_model.dart';
import 'package:maktab_lessor/domain/contracts/contract/add/contract_state.dart';

class ContractRepository {
  final ContractRemoteDataSource _remoteDataSource;

  ContractRepository(this._remoteDataSource);

  Future<Either<AppException, List<ContractModel>>> getContract() async {
    final result = await _remoteDataSource.getContract();
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final List<ContractModel> contracts = List<ContractModel>.from(
            right.data.map((dynamic data) => ContractModel.fromJson(data)),
          );
          return Right(contracts);
        } catch (e, s) {
          log(e.toString());
          log(s.toString());
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, ContractModel>> getContractById(id) async {
    final result = await _remoteDataSource.getContractById(id);
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final ContractModel contract = ContractModel.fromJson(right.data);
          return Right(contract);
        } catch (e) {
          // rethrow;
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, ContractModel>> createContract(ContractEntity contractEntity) async {
    try {
      final result = await _remoteDataSource.createContract(contractEntity.toJson());
      log(result.toString());
      return result.fold(
        (error) => Left(error),
        (right) {
          try {
            final ContractModel contract = ContractModel.fromJson(right.data);
            return Right(contract);
          } catch (e, s) {
            log(e.toString());
            log(s.toString());
            return Left(ConversionException(e.toString()));
          }
        },
      );
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      return Left(ConversionException(e.toString()));
    }
  }

  Future<Either<AppException, ContractModel>> updateContract({
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

  Future<Either<AppException, bool>> deleteContract(id) async {
    final result = await _remoteDataSource.deleteContract(id);
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          return Right(right.status);
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

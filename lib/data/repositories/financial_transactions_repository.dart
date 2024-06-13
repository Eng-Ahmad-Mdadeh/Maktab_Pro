import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:maktab/core/classes/exception/app_exception.dart';
import 'package:maktab/data/data_sources/remote/financial_transactions_data_source.dart';
import 'package:maktab/data/models/financial_transactions/bank_account.dart';
import 'package:maktab/data/models/financial_transactions/receiving_method_model.dart';
import 'package:maktab/data/models/user/user_model.dart';

class FinancialTransactionsRepository {
  final FinancialTransactionsRemoteDataSource _remoteDataSource;

  FinancialTransactionsRepository(
      {required FinancialTransactionsRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  Future<Either<AppException, ReceivingMethod>> getReceiveMoneyMethod() async {
    final result = await _remoteDataSource.getReceiveMoneyMethod();
    return result.fold(
      (error) => Left(error),
      (right) {
        if (right.status) {
          final ReceivingMethod receivingMethod =
              ReceivingMethod.fromJson(right.data);
          return Right(receivingMethod);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, ReceivingMethod>> setBankMethod(
      {required String bankName,
      required String accountOwnerName,
      required String ibanNumber}) async {
    final result = await _remoteDataSource.setBankMethod({
      'bank_name': bankName,
      'account_owner_name': accountOwnerName,
      'iban_number': ibanNumber,
    });
    return result.fold(
      (error) => Left(error),
      (right) {
        if (right.status) {
          final ReceivingMethod receivingMethod =
              ReceivingMethod.fromJson(right.data);
          return Right(receivingMethod);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, ReceivingMethod>> setSTCMethod(
      {required String mobile}) async {
    final result =
        await _remoteDataSource.setSTCMethod({'mobile': '+966$mobile'});
    return result.fold(
      (error) => Left(error),
      (right) {
        if (right.status) {
          final ReceivingMethod receivingMethod =
              ReceivingMethod.fromJson(right.data);
          return Right(receivingMethod);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, void>> deleteReceiveMoneyMethod() async {
    final result = await _remoteDataSource.deleteReceiveMoneyMethod();
    return result.fold(
      (error) => Left(error),
      (right) {
        if (right.status) {
          // log(right.message);
          return const Right(null);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, List<BankAccount>>> getBankAccounts() async {
    final result = await _remoteDataSource.getBankAccounts();
    return result.fold(
      (error) => Left(error),
      (right) {
        if (right.status) {
          final List<BankAccount> bankAccounts = List<BankAccount>.from(
            right.data.map((dynamic data) => BankAccount.fromJson(data)),
          );
          return Right(bankAccounts);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, User?>> verifyNationalID(
      {required String nationalID}) async {
    final result =
        await _remoteDataSource.verifyNationalID({'nationalId': nationalID});
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          if (right.data == null) {
            return Left(AppException(right.message?? 'Unknown error'));
          }
          final User user = User.fromJson(right.data);
          return Right(user);
        } catch (e) {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, User?>> verifyResidenceID(
      {required String residenceId}) async {
    final result =
        await _remoteDataSource.verifyResidenceID({'residenceId': residenceId});
    return result.fold(
      (error) => Left(error),
      (right) {
        if (right.data == null) {
          return Left(AppException(right.message?? 'Unknown error'));
        }
        final User user = User.fromJson(right.data);

        return Right(user);
      },
    );
  }
}

import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';
import 'package:maktab_lessor/core/classes/exception/data_exceptions.dart';
import 'package:maktab_lessor/data/data_sources/remote/price_remote_data_source.dart';
import 'package:maktab_lessor/data/models/office/office_model.dart';
import 'package:maktab_lessor/data/models/office/office_price_model.dart';
import 'package:maktab_lessor/data/models/response/response_model.dart' as r;

class PriceRepository {
  final PriceRemoteDataSource _priceRemoteDataSource;

  PriceRepository({required PriceRemoteDataSource priceRemoteDataSource})
      : _priceRemoteDataSource = priceRemoteDataSource;

  Future<Either<AppException, List<Office>>> getPrices() async {
    final result = await _priceRemoteDataSource.getAllPrices();
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final List<Office> prices = List<Office>.from(
            right.data.map((data) => Office.fromJson(data)),
          );
          return Right(prices);
        } catch (e, s) {
          log(e.toString());
          log(s.toString());
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, Office>> getPriceById(id) async {
    final result = await _priceRemoteDataSource.getPriceById(id);
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final Office price = Office.fromJson(right.data);
          return Right(price);
        } catch (e, s) {
          log(e.toString());
          log(s.toString());
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, Office>> addToOffice({
    required int adsId,
    required List<OfficePrice> prices,
  }) async {
    return _executeRequest(
      () => _priceRemoteDataSource.addToOffice(
        adsId,
        _createPricesDataMap(prices),
      ),
    );
  }

  Future<Either<AppException, Office>> updateToOffice({
    required int adsId,
    required List<OfficePrice> prices,
  }) async {
    return _executeRequest(
      () => _priceRemoteDataSource.updateToOffice(
        adsId,
        _createPricesDataMap(prices),
      ),
    );
  }

  Future<Either<AppException, Office>> deleteFromOffice(
    int officeId,
    int priceId,
  ) async {
    final priceData = {"id": priceId};
    return _executeRequest(
      () => _priceRemoteDataSource.deleteFromOffice(officeId, priceData),
    );
  }

  Future<Either<AppException, Office>> _executeRequest(
    Future<Either<AppException, r.Response>> Function() action,
  ) async {
    try {
      final result = await action();
      return result.fold(
        (error) => Left(error),
        (right) => _handleResult(right.data),
      );
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      return Left(ConversionException(e.toString()));
    }
  }

  Either<AppException, Office> _handleResult(Map<String, dynamic> right) {
    try {
      final Office office = Office.fromJson(right);
      return Right(office);
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      return Left(ConversionException(e.toString()));
    }
  }

  Map<String, dynamic> _createPricesDataMap(List<OfficePrice> prices) {
    final pricesData = <String, dynamic>{};
    for (int i = 0; i < prices.length; i++) {
      pricesData.addAll({
        'prices[$i][id]': prices[i].id,
        'prices[$i][type_res_id]': prices[i].typeResId,
        'prices[$i][price]': prices[i].price,
        'prices[$i][status]': prices[i].status,
      });
    }
    return pricesData;
  }
}

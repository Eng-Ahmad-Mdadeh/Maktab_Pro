// ignore_for_file: unused_local_variable

import 'package:dartz/dartz.dart';
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';
import 'package:maktab_lessor/core/classes/exception/data_exceptions.dart';
import 'package:maktab_lessor/data/data_sources/remote/offer_remote_data_source.dart';
import 'package:maktab_lessor/data/models/offer/offer_model.dart';
import 'package:maktab_lessor/data/models/office/office_model.dart';
import 'package:maktab_lessor/data/models/office/office_price_model.dart';

class OfferRepository {
  final OfferRemoteDataSource _offerRemoteDataSource;

  OfferRepository({required OfferRemoteDataSource offerRemoteDataSource})
      : _offerRemoteDataSource = offerRemoteDataSource;

  Future<Either<AppException, List<Office>>> getAllOffers() async {
    final result = await _offerRemoteDataSource.getAllOffers();
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final List<Office> prices = List<Office>.from(
            right.data.map((data) => Office.fromJson(data)),
          );
          return Right(prices);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, List<Office>>> getMyOffers() async {
    final result = await _offerRemoteDataSource.getMyOffers();
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final List<Office> prices = List<Office>.from(
            right.data.map((data) => Office.fromJson(data)),
          );
          return Right(prices);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, Office>> getOfferById(id) async {
    final result = await _offerRemoteDataSource.getOfferById(id);
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final Office prices = Office.fromJson(right.data);
          return Right(prices);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, Office?>> createOffer({
    required String name,
    required num discount,
    required String discountType,
    required DateTime startDate,
    required DateTime endDate,
    required int officeId,
    required List<int> prices,
  }) async {
    try {
      final offerData = {
        'name': name,
        'discount': discount,
        'type_discount': discountType,
        'start_date': startDate,
        'end_date': endDate,
        'status': 1,
        'ads_id': officeId,
      };
      for (int index = 0; index < prices.length; index++) {
        offerData['ads_prices[$index][ads_price_id]'] = prices[index];
      }
      final result = await _offerRemoteDataSource.createOffer(offerData);
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
    } catch (e) {
      return Left(ConversionException(e.toString()));
    }
  }

  Future<Either<AppException, Office>> updateOfferToOffice({
    required int offerId,
    required String name,
    required String discount,
    required String discountType,
    required DateTime startDate,
    required DateTime endDate,
    required String status,
    required int officeId,
    required List<int> prices,
  }) async {
    try {
      final offerData = _createOfferDataMap(
          name: name,
          discount: discount,
          discountType: discountType,
          startDate: startDate,
          endDate: endDate,
          status: status,
          officeId: officeId,
          prices: prices);
      final result =
          await _offerRemoteDataSource.updateOfferToOffice(offerId, offerData);
      return result.fold(
        (error) => Left(error),
        (right) {
          try {
            final Office offer = Office.fromJson(right.data);
            return Right(offer);
          } catch (e) {
            return Left(ConversionException(e.toString()));
          }
        },
      );
    } catch (e) {
      return Left(ConversionException(e.toString()));
    }
  }

  Future<Either<AppException, Office>> setOfferPrices({
    required int offerId,
    required int officeId,
    required List<OfficePrice> prices,
  }) async {
    try {
      final offerModelData =
          _createOfficePricesDataMap(officeId: officeId, prices: prices);
      final result =
          await _offerRemoteDataSource.setOfferPrices(offerId, offerModelData);
      return result.fold(
        (error) => Left(error),
        (right) {
          try {
            final Office offer = Office.fromJson(right.data);
            return Right(offer);
          } catch (e) {
            return Left(ConversionException(e.toString()));
          }
        },
      );
    } catch (e) {
      return Left(ConversionException(e.toString()));
    }
  }

  Future<Either<AppException, Offer>> setOfferStatus(id) async {
    final result = await _offerRemoteDataSource.setOfferStatus(id);
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final Offer offer = Offer.fromJson(right.data);
          return Right(offer);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, void>> deleteOffer(offerId) async {
    final result = await _offerRemoteDataSource.deleteOffer(offerId);
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

  Future<Either<AppException, void>> deleteOfferFromOfficePrice(
      offerId, officeId, priceeId) async {
    final result = await _offerRemoteDataSource.deleteOfferByOfficePrice(
        offerId, {"ads_price_id": priceeId, "ads_id": officeId});
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

  Map<String, dynamic> _createOfferDataMap({
    required String name,
    required String discount,
    required String discountType,
    required DateTime startDate,
    required DateTime endDate,
    required String status,
    required int officeId,
    required List<int> prices,
  }) {
    Map<String, dynamic> offerMap = {};
    offerMap.addAll({
      'name': name,
      'discount': discount,
      'type_discount': discountType,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'status': status,
      'ads_id': officeId,
    });
    for (int i = 0; i < prices.length; i++) {
      offerMap.addAll({
        'prices[$i][ads_price_id]': prices[i],
      });
    }
    return offerMap;
  }

  Map<String, dynamic> _createOfficePricesDataMap({
    required int officeId,
    required List<OfficePrice> prices,
  }) {
    Map<String, dynamic> offerMap = {};
    offerMap.addAll({
      'ads_id': officeId,
    });
    for (int i = 0; i < prices.length; i++) {
      offerMap.addAll({
        'prices[$i][ads_price_id]': prices[i].id,
      });
    }
    return offerMap;
  }
}

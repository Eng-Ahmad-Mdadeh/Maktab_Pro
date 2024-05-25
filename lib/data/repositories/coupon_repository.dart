import 'package:dartz/dartz.dart';
import 'package:maktab/core/classes/exception/app_exception.dart';
import 'package:maktab/core/classes/exception/data_exceptions.dart';
import 'package:maktab/data/data_sources/remote/coupon_remote_data_source.dart';
import 'package:maktab/data/models/coupon/coupon_model.dart';
import 'package:maktab/data/models/office/office_model.dart';
import 'package:maktab/data/models/office/office_price_model.dart';

class CouponRepository {
  final CouponRemoteDataSource _remoteDataSource;

  CouponRepository({required CouponRemoteDataSource couponRemoteDataSource})
      : _remoteDataSource = couponRemoteDataSource;

  Future<Either<AppException, List<Office>>> getAllCoupons() async {
    final result = await _remoteDataSource.getAllCoupons();
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final List<Office> coupons = List<Office>.from(
              right.data.map((coupon) => Office.fromJson(coupon)));
          return Right(coupons);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, Coupon>> getCouponById(id) async {
    final result = await _remoteDataSource.getCouponById(id);
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final Coupon coupon = Coupon.fromJson(right.data);
          return Right(coupon);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, Coupon>> createCoupon({
    required String name,
    required String discount,
    required String discountType,
    required DateTime startDate,
    required DateTime endDate,
    required String status,
    required int officeId,
    required List<OfficePrice> prices,
  }) async {
    try {
      final offerModelData = _createCouponDataMap(
          name: name,
          discount: discount,
          discountType: discountType,
          startDate: startDate,
          endDate: endDate,
          status: status,
          officeId: officeId,
          prices: prices);
      final result = await _remoteDataSource.createCoupon(offerModelData);
      return result.fold(
        (error) => Left(error),
        (right) {
          try {
            final Coupon coupon = Coupon.fromJson(right.data);
            return Right(coupon);
          } catch (e) {
            return Left(ConversionException(e.toString()));
          }
        },
      );
    } catch (e) {
      return Left(ConversionException(e.toString()));
    }
  }

  Future<Either<AppException, Coupon>> updateCoupon({
    required int couponId,
    required String name,
    required String discount,
    required String discountType,
    required DateTime startDate,
    required DateTime endDate,
    required String status,
    required int officeId,
    required List<OfficePrice> prices,
  }) async {
    try {
      final offerModelData = _createCouponDataMap(
          name: name,
          discount: discount,
          discountType: discountType,
          startDate: startDate,
          endDate: endDate,
          status: status,
          officeId: officeId,
          prices: prices);
      final result =
          await _remoteDataSource.updateCoupon(couponId, offerModelData);
      return result.fold(
        (error) => Left(error),
        (right) {
          try {
            final Coupon coupon = Coupon.fromJson(right.data);
            return Right(coupon);
          } catch (e) {
            return Left(ConversionException(e.toString()));
          }
        },
      );
    } catch (e) {
      return Left(ConversionException(e.toString()));
    }
  }

  Future<Either<AppException, Coupon>> setOfficePrices({
    required int couponId,
    required int officeId,
    required List<OfficePrice> prices,
  }) async {
    try {
      final couponData =
          _createOfficePricesDataMap(officeId: officeId, prices: prices);
      final result =
          await _remoteDataSource.setOfficePrices(couponId, couponData);
      return result.fold(
        (error) => Left(error),
        (right) {
          try {
            final Coupon coupon = Coupon.fromJson(right.data);
            return Right(coupon);
          } catch (e) {
            return Left(ConversionException(e.toString()));
          }
        },
      );
    } catch (e) {
      return Left(ConversionException(e.toString()));
    }
  }

  Future<Either<AppException, Coupon>> updateStatus(couponId) async {
    final result = await _remoteDataSource.updateStatus(couponId);
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final Coupon coupon = Coupon.fromJson(right.data);
          return Right(coupon);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, void>> deleteCoupon(couponId) async {
    final result = await _remoteDataSource.deleteCoupon(couponId);
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

  Future<Either<AppException, void>> deleteCouponByOfficePrice(
      couponId, officeId, priceId) async {
    final result = await _remoteDataSource.deleteByOfficePrice(
        couponId, {"ads_price_id": priceId, "ads_id": officeId});
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

  Map<String, dynamic> _createCouponDataMap({
    required String name,
    required String discount,
    required String discountType,
    required DateTime startDate,
    required DateTime endDate,
    required String status,
    required int officeId,
    required List<OfficePrice> prices,
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
        'prices[$i][ads_price_id]': prices[i].id,
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

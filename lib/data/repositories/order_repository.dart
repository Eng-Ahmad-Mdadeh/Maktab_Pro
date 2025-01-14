import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';
import 'package:maktab_lessor/core/classes/exception/data_exceptions.dart';
import 'package:maktab_lessor/data/data_sources/remote/order_remote_data_source.dart';
import 'package:maktab_lessor/data/models/order/order_model.dart' as o;

class OrderRepository {
  final OrderRemoteDataSource _remoteDataSource;

  OrderRepository(this._remoteDataSource);

  Future<Either<AppException, List<o.OrderModel>>> getAllOrders(int page) async {
    final result = await _remoteDataSource.getAllOrders(page);
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final List<o.OrderModel> orders = List<o.OrderModel>.from(
            right.data['data'].map((dynamic data) => o.OrderModel.fromJson(data, int.parse(right.data['last_page'].toString()))),
          );
          return Right(orders);
        } catch (e, s) {
          log(e.toString());
          log(s.toString());
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, List<o.OrderModel>>> getOrdersWithoutPage() async {
    final result = await _remoteDataSource.getOrdersWithoutPage();
    return result.fold(
          (error) => Left(error),
          (right) {
        try {
          final List<o.OrderModel> orders = List<o.OrderModel>.from(
            right.data.map((dynamic data) => o.OrderModel.fromJson(data)),
          );
          return Right(orders);
        } catch (e, s) {
          log(e.toString());
          log(s.toString());
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, o.OrderModel>> getOrderById(orderId) async {
    final result = await _remoteDataSource.getOrderById(orderId);
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final o.OrderModel order = o.OrderModel.fromJson(right.data);
          return Right(order);
        } catch (e, s) {
          log(e.toString());
          log(s.toString());
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, o.OrderModel>> setPending() async {
    final result = await _remoteDataSource.setPending();
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final o.OrderModel order = o.OrderModel.fromJson(right.data);
          return Right(order);
        } catch (e, s) {
          log(e.toString());
          log(s.toString());
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, o.OrderModel>> setCancel(int id) async {
    final result = await _remoteDataSource.setCancel(id);
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final o.OrderModel order = o.OrderModel.fromJson(right.data);
          return Right(order);
        } catch (e, s) {
          log(e.toString());
          log(s.toString());
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }
}

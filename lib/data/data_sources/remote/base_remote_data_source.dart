import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:maktab/core/classes/exception/app_exception.dart';
import 'package:maktab/core/network/network_helper.dart';
import '../../../core/classes/exception/api_exceptions.dart';
import '../../models/response/response_model.dart' as r;

class BaseRemoteDataSource<T> {
  final NetworkHelper _networkHelper = NetworkHelper();
  final String baseEndpoint;

  BaseRemoteDataSource(this.baseEndpoint);

  Future<Either<ApiException, r.Response>> fetchAllData([int? page]) async {
    try {
      final Either response = await _networkHelper.get('$baseEndpoint${page != null ? '?page=$page' : ''}');
      return response.fold(
        (error) => Left(error),
        (right) {
          return Right(r.Response.fromJson(right));
        },
      );
    } on ApiException catch (e) {
      return Left(e);
    }
  }

  Future<Either<AppException, r.Response>> fetchData({required String endpoint, Map<String, dynamic>? data}) async {
    log(baseEndpoint + endpoint);
    try {
      final Either response = await _networkHelper.get(
        baseEndpoint + endpoint,
        queryParams: data,
      );
      return response.fold(
        (error) => Left(error),
        (right) {
          return Right(r.Response.fromJson(right));
        },
      );
    } on AppException catch (e) {
      return Left(e);
    }catch(e){
      rethrow;
    }
  }

  Future<Either<ApiException, r.Response>> fetchDataWithId(id) async {
    try {
      final Either response = await _networkHelper.get('$baseEndpoint/$id');
      return response.fold(
        (error) => Left(error),
        (right) {
          return Right(r.Response.fromJson(right));
        },
      );
    } on ApiException catch (e) {
      return Left(e);
    }
  }

  Future<Either<ApiException, r.Response>> postData({String endpoint = '', data, List<Map<String, dynamic>>? files}) async {
    print(baseEndpoint + endpoint);
    try {
      final Either response = await _networkHelper.post(baseEndpoint + endpoint, data: data, files: files);
      return response.fold(
        (error) => Left(error),
        (right) {
          return Right(r.Response.fromJson(right));
        },
      );
    } on ApiException catch (e) {
      return Left(e);
    }
  }

  Future<Either<AppException, r.Response>> deleteData({String endpoint = '', data}) async {
    try {
      print(baseEndpoint + endpoint);
      final Either response = await _networkHelper.delete(baseEndpoint + endpoint, data: data);
      return response.fold(
        (error) => Left(error),
        (right) {
          return Right(r.Response.fromJson(right));
        },
      );
    } on AppException catch (e) {
      return Left(e);
    }
  }
}

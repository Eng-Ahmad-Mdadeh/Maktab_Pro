import 'package:dartz/dartz.dart';
import 'package:maktab/core/classes/exception/app_exception.dart';
import 'package:maktab/core/classes/exception/data_exceptions.dart';
import 'package:maktab/data/data_sources/remote/contract_ejar_remote_data_source.dart';
import 'package:maktab/data/models/contract/contract_ejar_model.dart';

class ContractEjarRepository {
  final ContractEjarRemoteDataSource _remoteDataSource;

  ContractEjarRepository(this._remoteDataSource);

  Future<Either<AppException, List<ContractEjar>>> getAllContracts() async {
    final result = await _remoteDataSource.getAllContracts();
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final List<ContractEjar> contracts = List<ContractEjar>.from(
            right.data.map((dynamic data) => ContractEjar.fromJson(data)),
          );
          return Right(contracts);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, ContractEjar>> getContractById(id) async {
    final result = await _remoteDataSource.getContractById(id);
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final ContractEjar contract = ContractEjar.fromJson(right.data);
          return Right(contract);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, ContractEjar>> createContract({
    required int contractId,
    required int status,
    required DateTime startDate,
    required DateTime endDate,
    required String imageRecord,
    required String imageInstrument,
    required int lessorId,
    required String lessorMobile,
    required String lessorNeighborhood,
    required String lessorStreet,
    required String lessorCity,
    required String lessorConstructionNumber,
    required int tenantId,
    required String tenantMobile,
    required String tenantNeighborhood,
    required String tenantStreet,
    required String tenantCity,
    required String tenantConstructionNumber,
    required String aqarType,
    required String spaceUnit,
    required num frontEndLength,
    required bool isMushtab,
    required bool noFloorUnit,
    required String unitType,
    required bool noCentralConditioners,
    required bool noWindowConditioners,
    required bool noSplitConditioners,
    required String waterPaymentMethod,
    required num waterMoney,
    required String electricityPaymentMethod,
    required String rentPaymentCycle,
    required num downPayment,
    required int durationDaysOpenContract,
    required int durationDaysCancelContract,
    required int orderId,
  }) async {
    try {
      final contractEjarData = _createContractDataMap(
          status: status,
          startDate: startDate,
          endDate: endDate,
          imageRecord: imageRecord,
          imageInstrument: imageInstrument,
          lessorId: lessorId,
          lessorMobile: lessorMobile,
          lessorNeighborhood: lessorNeighborhood,
          lessorStreet: lessorStreet,
          lessorCity: lessorCity,
          lessorConstructionNumber: lessorConstructionNumber,
          tenantId: tenantId,
          tenantMobile: tenantMobile,
          tenantNeighborhood: tenantNeighborhood,
          tenantStreet: tenantStreet,
          tenantCity: tenantCity,
          tenantConstructionNumber: tenantConstructionNumber,
          aqarType: aqarType,
          spaceUnit: spaceUnit,
          frontEndLength: frontEndLength,
          isMushtab: isMushtab,
          noFloorUnit: noFloorUnit,
          unitType: unitType,
          noCentralConditioners: noCentralConditioners,
          noWindowConditioners: noWindowConditioners,
          noSplitConditioners: noSplitConditioners,
          waterPaymentMethod: waterPaymentMethod,
          waterMoney: waterMoney,
          electricityPaymentMethod: electricityPaymentMethod,
          rentPaymentCycle: rentPaymentCycle,
          downPayment: downPayment,
          durationDaysOpenContract: durationDaysOpenContract,
          durationDaysCancelContract: durationDaysCancelContract,
          orderId: orderId);
      final result = await _remoteDataSource.createContract(contractEjarData);
      return result.fold(
        (error) => Left(error),
        (right) {
          try {
            final ContractEjar contract = ContractEjar.fromJson(right.data);
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

  Future<Either<AppException, ContractEjar>> updateContract({
    required int contractId,
    required int status,
    required DateTime startDate,
    required DateTime endDate,
    required String imageRecord,
    required String imageInstrument,
    required int lessorId,
    required String lessorMobile,
    required String lessorNeighborhood,
    required String lessorStreet,
    required String lessorCity,
    required String lessorConstructionNumber,
    required int tenantId,
    required String tenantMobile,
    required String tenantNeighborhood,
    required String tenantStreet,
    required String tenantCity,
    required String tenantConstructionNumber,
    required String aqarType,
    required String spaceUnit,
    required num frontEndLength,
    required bool isMushtab,
    required bool noFloorUnit,
    required String unitType,
    required bool noCentralConditioners,
    required bool noWindowConditioners,
    required bool noSplitConditioners,
    required String waterPaymentMethod,
    required num waterMoney,
    required String electricityPaymentMethod,
    required String rentPaymentCycle,
    required num downPayment,
    required int durationDaysOpenContract,
    required int durationDaysCancelContract,
    required int orderId,
  }) async {
    try {
      final contractEjarData = _createContractDataMap(
          status: status,
          startDate: startDate,
          endDate: endDate,
          imageRecord: imageRecord,
          imageInstrument: imageInstrument,
          lessorId: lessorId,
          lessorMobile: lessorMobile,
          lessorNeighborhood: lessorNeighborhood,
          lessorStreet: lessorStreet,
          lessorCity: lessorCity,
          lessorConstructionNumber: lessorConstructionNumber,
          tenantId: tenantId,
          tenantMobile: tenantMobile,
          tenantNeighborhood: tenantNeighborhood,
          tenantStreet: tenantStreet,
          tenantCity: tenantCity,
          tenantConstructionNumber: tenantConstructionNumber,
          aqarType: aqarType,
          spaceUnit: spaceUnit,
          frontEndLength: frontEndLength,
          isMushtab: isMushtab,
          noFloorUnit: noFloorUnit,
          unitType: unitType,
          noCentralConditioners: noCentralConditioners,
          noWindowConditioners: noWindowConditioners,
          noSplitConditioners: noSplitConditioners,
          waterPaymentMethod: waterPaymentMethod,
          waterMoney: waterMoney,
          electricityPaymentMethod: electricityPaymentMethod,
          rentPaymentCycle: rentPaymentCycle,
          downPayment: downPayment,
          durationDaysOpenContract: durationDaysOpenContract,
          durationDaysCancelContract: durationDaysCancelContract,
          orderId: orderId);
      final result =
          await _remoteDataSource.updateContract(contractId, contractEjarData);
      return result.fold(
        (error) => Left(error),
        (right) {
          try {
            final ContractEjar contract = ContractEjar.fromJson(right.data);
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
    required DateTime startDate,
    required DateTime endDate,
    required String imageRecord,
    required String imageInstrument,
    required int lessorId,
    required String lessorMobile,
    required String lessorNeighborhood,
    required String lessorStreet,
    required String lessorCity,
    required String lessorConstructionNumber,
    required int tenantId,
    required String tenantMobile,
    required String tenantNeighborhood,
    required String tenantStreet,
    required String tenantCity,
    required String tenantConstructionNumber,
    required String aqarType,
    required String spaceUnit,
    required num frontEndLength,
    required bool isMushtab,
    required bool noFloorUnit,
    required String unitType,
    required bool noCentralConditioners,
    required bool noWindowConditioners,
    required bool noSplitConditioners,
    required String waterPaymentMethod,
    required num waterMoney,
    required String electricityPaymentMethod,
    required String rentPaymentCycle,
    required num downPayment,
    required int durationDaysOpenContract,
    required int durationDaysCancelContract,
    required int orderId,
  }) {
    return {
      'status': status,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'image_record': imageRecord,
      'image_instrument': imageInstrument,
      'id_number_lessor': lessorId,
      'mobile_lessor': lessorMobile,
      'neighborhood_lessor': lessorNeighborhood,
      'street_lessor': lessorStreet,
      'city_lessor': lessorCity,
      'construction_number_lessor': lessorConstructionNumber,
      'id_number_tenant': tenantId,
      'mobile_tenant': tenantMobile,
      'neighborhood_tenant': tenantNeighborhood,
      'street_tenant': tenantStreet,
      'city_tenant': tenantCity,
      'construction_number_tenant': tenantConstructionNumber,
      'type_aqar': aqarType,
      'space_unit': spaceUnit,
      'length_front_end': frontEndLength,
      'is_mushtab': isMushtab,
      'no_floor_unit': noFloorUnit,
      'type_unit': unitType,
      'no_central_conditioners': noCentralConditioners,
      'no_window_conditioners': noWindowConditioners,
      'no_split_conditioners': noSplitConditioners,
      'water_payment_method': waterPaymentMethod,
      'water_money': waterMoney,
      'electricity_payment_method': electricityPaymentMethod,
      'rent_payment_cycle': rentPaymentCycle,
      'down_payment': downPayment,
      'duration_days_open_contract': durationDaysOpenContract,
      'duration_days_cancel_contract': durationDaysCancelContract,
      'order_id': orderId,
    };
  }
}

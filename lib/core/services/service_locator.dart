import 'package:get_it/get_it.dart';
import 'package:maktab/core/helpers/file_picker_helper.dart';
import 'package:maktab/core/helpers/hive_helper.dart';
import 'package:maktab/core/helpers/location_helper.dart';
import 'package:maktab/core/network/network_helper.dart';
import 'package:maktab/data/data_sources/local/user_local_data_source.dart';
import 'package:maktab/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:maktab/data/data_sources/remote/calendar_remote_data_source.dart';
import 'package:maktab/data/data_sources/remote/complaint_remote_data_source.dart';
import 'package:maktab/data/data_sources/remote/coupon_remote_data_source.dart';
import 'package:maktab/data/data_sources/remote/feature_remote_data_source.dart';
import 'package:maktab/data/data_sources/remote/financial_transactions_data_source.dart';
import 'package:maktab/data/data_sources/remote/map_remote_data_source.dart';
import 'package:maktab/data/data_sources/remote/offer_remote_data_source.dart';
import 'package:maktab/data/data_sources/remote/office_remote_data_source.dart';
import 'package:maktab/data/data_sources/remote/price_remote_data_source.dart';
import 'package:maktab/data/data_sources/remote/profile_remote_data_source.dart';
import 'package:maktab/data/data_sources/remote/settings_remote_data_source.dart';
import 'package:maktab/data/data_sources/remote/transfer_money_data_source.dart';
import 'package:maktab/data/data_sources/remote/user_remote_data_source.dart';
import 'package:maktab/data/repositories/auth_repository.dart';
import 'package:maktab/data/repositories/calendar_repository.dart';
import 'package:maktab/data/repositories/complaint_repository.dart';
import 'package:maktab/data/repositories/coupon_repository.dart';
import 'package:maktab/data/repositories/financial_transactions_repository.dart';
import 'package:maktab/data/repositories/map_repository.dart';
import 'package:maktab/data/repositories/offer_repository.dart';
import 'package:maktab/data/repositories/office_repository.dart';
import 'package:maktab/data/repositories/price_repository.dart';
import 'package:maktab/data/repositories/profile_repository.dart';
import 'package:maktab/data/repositories/transfer_money_repository.dart';
import 'package:maktab/data/repositories/user_repository.dart';
import 'package:maktab/domain/auth/auth_bloc.dart';
import 'package:maktab/domain/calendar/calendar_bloc.dart';
import 'package:maktab/domain/coupon/coupon_bloc.dart';
import 'package:maktab/domain/home/home_bloc.dart';
import 'package:maktab/domain/map/map_cubit.dart';
import 'package:maktab/domain/national_access/national_access_bloc.dart';
import 'package:maktab/domain/offer/offer_bloc.dart';
import 'package:maktab/domain/offices/offices_cubit.dart';
import 'package:maktab/domain/receiving_method/receiving_method_bloc.dart';
import 'package:maktab/domain/location/location_bloc.dart';
import 'package:maktab/domain/office/office_bloc.dart';
import 'package:maktab/domain/profile/profile_bloc.dart';
import 'package:maktab/domain/shimmer/shimmer_bloc.dart';
import 'package:maktab/domain/splash/splash_bloc.dart';
import 'package:maktab/domain/transfers/transdfers_bloc.dart';
import 'package:maktab/domain/unit/unit_bloc.dart';
import 'package:maktab/domain/user/user_bloc.dart';
import 'package:maktab/domain/video/video_bloc.dart';

import '../../data/data_sources/remote/account_summary_data_source.dart';
import '../../data/data_sources/remote/contract_model_remote_data_source.dart';
import '../../data/data_sources/remote/contract_remote_data_source.dart';
import '../../data/data_sources/remote/invoice_remote_data_source.dart';
import '../../data/data_sources/remote/order_remote_data_source.dart';
import '../../data/repositories/account_summary_repository.dart';
import '../../data/repositories/contract_model_repository.dart';
import '../../data/repositories/contract_repository.dart';
import '../../data/repositories/invoice_repository.dart';
import '../../data/repositories/order_repository.dart';
import '../../data/repositories/settings_repository.dart';
import '../../domain/account_summary/account_summary_bloc.dart';
import '../../domain/contract_models/contract_model/contract_model_bloc.dart';
import '../../domain/contract_models/contract_models_bloc.dart';
import '../../domain/contracts/contract/contract_bloc.dart';
import '../../domain/contracts/contracts_bloc.dart';
import '../../domain/invoice/invoice_bloc.dart';
import '../../domain/orders/order/order_bloc.dart';
import '../../domain/orders/orders_bloc.dart';
import '../../domain/settings/settings_bloc.dart';

final locator = GetIt.I;

Future<void> setup() async {
  //Presentation Layer
  locator.registerFactory<SplashBloc>(
    () => SplashBloc(
      authRepository: locator<AuthRepository>(),
      profileRepository: locator<ProfileRepository>(),
    )..add(CheckAuthenticationEvent()),
  );
  locator.registerFactory<ShimmerBloc>(
    () => ShimmerBloc(),
  );
  locator.registerFactory<AuthBloc>(
    () => AuthBloc(
      authRepository: locator<AuthRepository>(),
    ),
  );
  locator.registerFactory<HomeBloc>(
    () => HomeBloc(
      userRepository: locator<UserRepository>(),
    ),
  );
  locator.registerFactory<CalendarBloc>(
    () => CalendarBloc(locator<CalendarRepository>()),
  );
  locator.registerFactory<OfficeBloc>(
    () => OfficeBloc(
      officeRepository: locator<OfficeRepository>(),
      mapRepository: locator<MapRepository>(),
    ),
  );
  locator.registerFactory<LocationBloc>(
    () => LocationBloc(),
  );
  locator.registerFactory<VideoBloc>(
    () => VideoBloc(),
  );
  locator.registerLazySingleton<ProfileBloc>(
    () => ProfileBloc(
      authRepository: locator<AuthRepository>(),
      profileRepository: locator<ProfileRepository>(),
      userRepository: locator<UserRepository>(),
    ),
  );
  locator.registerFactory<ReceivingMethodBloc>(
    () => ReceivingMethodBloc(
      repository: locator<FinancialTransactionsRepository>(),
    ),
  );
  locator.registerFactory<TransferBloc>(
        () => TransferBloc(
      transferMoneyRepository: locator<TransferMoneyRepository>(),
    ),
  );
  locator.registerFactory<NationalAccessBloc>(
    () => NationalAccessBloc(
      repository: locator<FinancialTransactionsRepository>(),
    ),
  );
  locator.registerFactory<MapCubit>(
    () => MapCubit(
      mapRepository: locator<MapRepository>(),
    ),
  );
  locator.registerFactory<OfficesCubit>(
    () => OfficesCubit(
      officeRepository: locator<OfficeRepository>(),
      priceRepository: locator<PriceRepository>(),
      offerRepository: locator<OfferRepository>(),
      couponRepository: locator<CouponRepository>(),
      complaintRepository: locator<ComplaintRepository>(),
      calendarRepository: locator<CalendarRepository>(),
    ),
  );
  locator.registerFactory<UnitBloc>(
    () => UnitBloc(
      officeRepository: locator<OfficeRepository>(),
    ),
  );
  locator.registerFactory<UserBloc>(
    () => UserBloc(
      userRepository: locator<UserRepository>(),
    ),
  );
  locator.registerFactory<OfferBloc>(
    () => OfferBloc(
      offerRepository: locator<OfferRepository>(),
    ),
  );
  locator.registerFactory<CouponBloc>(
    () => CouponBloc(
      offerRepository: locator<CouponRepository>(),
    ),
  );

  locator.registerFactory<OrdersBloc>(
        () => OrdersBloc(
      locator<OrderRepository>(),
    ),
  );

  locator.registerFactory<OrderBloc>(
        () => OrderBloc(
      locator<OrderRepository>(),
    ),
  );

  locator.registerFactory<AccountSummaryBloc>(
        () => AccountSummaryBloc(
      locator<AccountSummaryRepository>(),
    ),
  );

  locator.registerFactory<InvoiceBloc>(
        () => InvoiceBloc(
      locator<InvoiceRepository>(),
    ),
  );

  locator.registerFactory<ContractsBloc>(
        () => ContractsBloc(
      locator<ContractRepository>(),
    ),
  );

  locator.registerFactory<ContractBloc>(
        () => ContractBloc(
      locator<ContractRepository>(),
    ),
  );

  locator.registerFactory<GeneralSettingBloc>(
        () => GeneralSettingBloc(
      locator<SettingsRepository>(),
    ),
  );
  locator.registerFactory<SearchDataBloc>(
        () => SearchDataBloc(
      locator<OfficeRepository>(),
    ),
  );

  locator.registerFactory<ContractModelsBloc>(
        () => ContractModelsBloc(
      locator<ContractModelRepository>(),
    ),
  );

  locator.registerFactory<ContractModelBloc>(
        () => ContractModelBloc(
      locator<ContractModelRepository>(),
    ),
  );


  //Repositories
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      authRemoteDataSource: locator<AuthRemoteDataSource>(),
      userLocalDataSource: locator<UserLocalDataSource>(),
    ),
  );
  locator.registerLazySingleton<ProfileRepository>(
    () => ProfileRepository(
      remoteDataSource: locator<ProfileRemoteDataSource>(),
    ),
  );
  locator.registerLazySingleton<TransferMoneyRepository>(
        () => TransferMoneyRepository(
      transferMoneyRemoteDataSource: locator<TransferMoneyRemoteDataSource>(),
    ),
  );
  locator.registerLazySingleton<UserRepository>(
    () => UserRepository(
      remoteDataSource: locator<UserRemoteDataSource>(),
    ),
  );
  locator.registerLazySingleton<FinancialTransactionsRepository>(
    () => FinancialTransactionsRepository(
      remoteDataSource: locator<FinancialTransactionsRemoteDataSource>(),
    ),
  );
  locator.registerLazySingleton<OfficeRepository>(
    () => OfficeRepository(
      officeRemoteDataSource: locator<OfficeRemoteDataSource>(),
      settingsRemoteDataSource: locator<SettingsRemoteDataSource>(),
    ),
  );
  locator.registerLazySingleton<MapRepository>(
    () => MapRepository(
      mapRemoteDataSource: locator<MapRemoteDataSource>(),
    ),
  );
  locator.registerFactory<PriceRepository>(
    () => PriceRepository(
      priceRemoteDataSource: locator<PriceRemoteDataSource>(),
    ),
  );
  locator.registerLazySingleton<OfferRepository>(
    () => OfferRepository(
      offerRemoteDataSource: locator<OfferRemoteDataSource>(),
    ),
  );
  locator.registerLazySingleton<CouponRepository>(
    () => CouponRepository(
      couponRemoteDataSource: locator<CouponRemoteDataSource>(),
    ),
  );

  locator.registerLazySingleton<ComplaintRepository>(
    () => ComplaintRepository(
      complaintRemoteDataSource: locator<ComplaintRemoteDataSource>(),
    ),
  );
  locator.registerLazySingleton<CalendarRepository>(
    () => CalendarRepository(
      calendarRemoteDataSource: locator<CalendarRemoteDataSource>(),
    ),
  );

  locator.registerLazySingleton<OrderRepository>(
        () => OrderRepository(
     locator<OrderRemoteDataSource>(),
    ),
  );

  locator.registerLazySingleton<AccountSummaryRepository>(
        () => AccountSummaryRepository(
      locator<AccountSummaryDataSource>(),
    ),
  );

  locator.registerLazySingleton<SettingsRepository>(
        () => SettingsRepository(
      locator<SettingsRemoteDataSource>(),
    ),
  );

  locator.registerLazySingleton<InvoiceRepository>(
        () => InvoiceRepository(
      locator<InvoiceRemoteDataSource>(),
    ),
  );

  locator.registerLazySingleton<ContractRepository>(
        () => ContractRepository(
      locator<ContractRemoteDataSource>(),
    ),
  );

  locator.registerLazySingleton<ContractModelRepository>(
        () => ContractModelRepository(
      locator<ContractModelRemoteDataSource>(),
    ),
  );

  //Data Sources
  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(),
  );
  locator.registerLazySingleton<TransferMoneyRemoteDataSource>(
        () => TransferMoneyRemoteDataSource(),
  );
  locator.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSource(),
  );
  locator.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSource(),
  );
  locator.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSource(),
  );
  locator.registerLazySingleton<FinancialTransactionsRemoteDataSource>(
    () => FinancialTransactionsRemoteDataSource(),
  );
  locator.registerLazySingleton<OfficeRemoteDataSource>(
    () => OfficeRemoteDataSource(),
  );
  locator.registerLazySingleton<SettingsRemoteDataSource>(
    () => SettingsRemoteDataSource(),
  );
  locator.registerLazySingleton<FeatureRemoteDataSource>(
    () => FeatureRemoteDataSource(),
  );
  locator.registerLazySingleton<MapRemoteDataSource>(
    () => MapRemoteDataSource(),
  );
  locator.registerLazySingleton<PriceRemoteDataSource>(
    () => PriceRemoteDataSource(),
  );
  locator.registerLazySingleton<OfferRemoteDataSource>(
    () => OfferRemoteDataSource(),
  );
  locator.registerLazySingleton<CouponRemoteDataSource>(
    () => CouponRemoteDataSource(),
  );
  locator.registerLazySingleton<ComplaintRemoteDataSource>(
    () => ComplaintRemoteDataSource(),
  );
  locator.registerLazySingleton<CalendarRemoteDataSource>(
    () => CalendarRemoteDataSource(),
  );

  locator.registerLazySingleton<OrderRemoteDataSource>(
        () => OrderRemoteDataSource(),
  );

  locator.registerLazySingleton<AccountSummaryDataSource>(
        () => AccountSummaryDataSource(),
  );

  locator.registerLazySingleton<InvoiceRemoteDataSource>(
        () => InvoiceRemoteDataSource(),
  );

  locator.registerLazySingleton<ContractRemoteDataSource>(
        () => ContractRemoteDataSource(),
  );

  locator.registerLazySingleton<ContractModelRemoteDataSource>(
        () => ContractModelRemoteDataSource(),
  );

  //External
  locator.registerLazySingleton<NetworkHelper>(() => NetworkHelper());
  locator.registerLazySingleton<HiveHelper>(() => HiveHelper());
  locator.registerLazySingleton<LocationHelper>(() => LocationHelper());
  locator.registerLazySingleton<FilePickerHelper>(() => FilePickerHelper());
}

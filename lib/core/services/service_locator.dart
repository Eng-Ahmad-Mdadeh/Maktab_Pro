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
import 'package:maktab/domain/navigation/navigation_cubit.dart';
import 'package:maktab/domain/office/office_bloc.dart';
import 'package:maktab/domain/profile/profile_bloc.dart';
import 'package:maktab/domain/shimmer/shimmer_bloc.dart';
import 'package:maktab/domain/splash/splash_bloc.dart';
import 'package:maktab/domain/transfers/transdfers_bloc.dart';
import 'package:maktab/domain/unit/unit_bloc.dart';
import 'package:maktab/domain/user/user_bloc.dart';
import 'package:maktab/domain/video/video_bloc.dart';

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
  locator.registerFactory<NavigationCubit>(
    () => NavigationCubit(),
  );
  locator.registerFactory<HomeBloc>(
    () => HomeBloc(
      userRepository: locator<UserRepository>(),
    ),
  );
  locator.registerFactory<CalendarBloc>(
    () => CalendarBloc(),
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

  //External
  locator.registerLazySingleton<NetworkHelper>(() => NetworkHelper());
  locator.registerLazySingleton<HiveHelper>(() => HiveHelper());
  locator.registerLazySingleton<LocationHelper>(() => LocationHelper());
  locator.registerLazySingleton<FilePickerHelper>(() => FilePickerHelper());
}

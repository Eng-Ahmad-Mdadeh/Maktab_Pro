import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/core/router/app_router.dart';
import 'package:maktab_lessor/core/services/app_services.dart';
import 'package:maktab_lessor/core/services/service_locator.dart';
import 'package:maktab_lessor/core/themes/app_theme.dart';
import 'package:maktab_lessor/domain/auth/auth_bloc.dart';
import 'package:maktab_lessor/domain/coupon/coupon_bloc.dart';
import 'package:maktab_lessor/domain/home/home_bloc.dart';
import 'package:maktab_lessor/domain/map/map_cubit.dart';
import 'package:maktab_lessor/domain/nafath/request_status/request_status_bloc.dart';
import 'package:maktab_lessor/domain/nafath/send_request/send_request_bloc.dart';
import 'package:maktab_lessor/domain/offices/offices_cubit.dart';
import 'package:maktab_lessor/domain/receiving_method/receiving_method_bloc.dart';
import 'package:maktab_lessor/domain/location/location_bloc.dart';
import 'package:maktab_lessor/domain/profile/profile_bloc.dart';
import 'package:maktab_lessor/domain/shimmer/shimmer_bloc.dart';
import 'package:maktab_lessor/domain/splash/splash_bloc.dart';
import 'package:maktab_lessor/domain/transfers/transfers_bloc.dart';
import 'package:maktab_lessor/domain/unit/unit_bloc.dart';
import 'package:maktab_lessor/domain/user/user_bloc.dart';
import 'package:maktab_lessor/domain/video/video_bloc.dart';

import 'domain/account_summary/account_summary_bloc.dart';
import 'domain/contract_models/contract_model/contract_model_bloc.dart';
import 'domain/contract_models/contract_models_bloc.dart';
import 'domain/contracts/contract/contract_bloc.dart';
import 'domain/contracts/contracts_bloc.dart';
import 'domain/evaluation/evaluation_bloc.dart';
import 'domain/invoice/invoice_bloc.dart';
import 'domain/navigation/navigation_bloc.dart';
import 'domain/notification/notification_bloc.dart';
import 'domain/orders/order/order_bloc.dart';
import 'domain/orders/orders_bloc.dart';
import 'domain/settings/settings_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppServices.initialServices();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  runApp(const MaktabApp());
}

class MaktabApp extends StatelessWidget {
  const MaktabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MultiBlocProvider(
        providers: [
          BlocProvider<SplashBloc>(create: (context) => locator<SplashBloc>()),
          BlocProvider<ShimmerBloc>(create: (context) => locator<ShimmerBloc>()),
          BlocProvider<AuthBloc>(create: (context) => locator<AuthBloc>()),
          BlocProvider<HomeBloc>(create: (context) => locator<HomeBloc>()),
          BlocProvider<MapCubit>(create: (context) => locator<MapCubit>()),
          BlocProvider<VideoBloc>(create: (context) => locator<VideoBloc>()),
          BlocProvider<LocationBloc>(create: (context) => locator<LocationBloc>()),
          BlocProvider<OfficesCubit>(create: (context) => locator<OfficesCubit>()),
          BlocProvider<UnitBloc>(create: (context) => locator<UnitBloc>()),
          BlocProvider<ProfileBloc>(create: (context) => locator<ProfileBloc>()),
          BlocProvider<ReceivingMethodBloc>(create: (context) => locator<ReceivingMethodBloc>()),
          BlocProvider<UserBloc>(create: (context) => locator<UserBloc>()),
          BlocProvider<CouponBloc>(create: (context) => locator<CouponBloc>()),
          BlocProvider<TransferBloc>(create: (context) => locator<TransferBloc>()),
          BlocProvider<OrdersBloc>(create: (context) => locator<OrdersBloc>()),
          BlocProvider<OrderBloc>(create: (context) => locator<OrderBloc>()),
          BlocProvider<AccountSummaryBloc>(create: (context) => locator<AccountSummaryBloc>()),
          BlocProvider<InvoiceBloc>(create: (context) => locator<InvoiceBloc>()),
          BlocProvider<ContractsBloc>(create: (context) => locator<ContractsBloc>()),
          BlocProvider<ContractBloc>(create: (context) => locator<ContractBloc>()),
          BlocProvider<GeneralSettingBloc>(create: (context) => locator<GeneralSettingBloc>()),
          BlocProvider<ContractModelsBloc>(create: (context) => locator<ContractModelsBloc>()),
          BlocProvider<ContractModelBloc>(create: (context) => locator<ContractModelBloc>()),
          BlocProvider<NotificationsBloc>(create: (context) => locator<NotificationsBloc>()),
          BlocProvider<EvaluationBloc>(create: (context) => locator<EvaluationBloc>()),
          BlocProvider<SendRequestBloc>(create: (context) => locator<SendRequestBloc>()),
          BlocProvider<RequestStatusBloc>(create: (context) => locator<RequestStatusBloc>()),
          BlocProvider<NavigationBloc>(create: (context) => NavigationBloc()),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en', ''), Locale('ar', '')],
          routerConfig: appRouter,
          builder: (context, child) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: child!,
            );
          },
        ),
      ),
    );
  }
}

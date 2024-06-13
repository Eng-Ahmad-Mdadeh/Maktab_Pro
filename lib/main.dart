import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:maktab/core/classes/custom_scroll_behavior.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/core/router/app_router.dart';
import 'package:maktab/core/services/app_services.dart';
import 'package:maktab/core/services/service_locator.dart';
import 'package:maktab/core/themes/app_theme.dart';
import 'package:maktab/domain/auth/auth_bloc.dart';
import 'package:maktab/domain/coupon/coupon_bloc.dart';
import 'package:maktab/domain/home/home_bloc.dart';
import 'package:maktab/domain/map/map_cubit.dart';
import 'package:maktab/domain/offices/offices_cubit.dart';
import 'package:maktab/domain/receiving_method/receiving_method_bloc.dart';
import 'package:maktab/domain/location/location_bloc.dart';
import 'package:maktab/domain/profile/profile_bloc.dart';
import 'package:maktab/domain/shimmer/shimmer_bloc.dart';
import 'package:maktab/domain/splash/splash_bloc.dart';
import 'package:maktab/domain/transfers/transdfers_bloc.dart';
import 'package:maktab/domain/unit/unit_bloc.dart';
import 'package:maktab/domain/user/user_bloc.dart';
import 'package:maktab/domain/video/video_bloc.dart';

import 'core/services/notification_services.dart';
import 'domain/account_summary/account_summary_bloc.dart';
import 'domain/contract_models/contract_model/contract_model_bloc.dart';
import 'domain/contract_models/contract_models_bloc.dart';
import 'domain/contracts/contract/contract_bloc.dart';
import 'domain/contracts/contracts_bloc.dart';
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
          BlocProvider(create: (context) => locator<SplashBloc>()),
          BlocProvider(create: (context) => locator<ShimmerBloc>()),
          BlocProvider(create: (context) => locator<AuthBloc>()),
          BlocProvider(create: (context) => locator<HomeBloc>()),
          BlocProvider(create: (context) => locator<MapCubit>()),
          BlocProvider(create: (context) => locator<VideoBloc>()),
          BlocProvider(create: (context) => locator<LocationBloc>()),
          BlocProvider(create: (context) => locator<OfficesCubit>()),
          BlocProvider(create: (context) => locator<UnitBloc>()),
          BlocProvider(create: (context) => locator<ProfileBloc>()),
          BlocProvider(create: (context) => locator<ReceivingMethodBloc>()),
          BlocProvider(create: (context) => locator<UserBloc>()),
          BlocProvider(create: (context) => locator<CouponBloc>()),
          BlocProvider(create: (context) => locator<TransferBloc>()),
          BlocProvider(create: (context) => locator<OrdersBloc>()),
          BlocProvider(create: (context) => locator<OrderBloc>()),
          BlocProvider(create: (context) => locator<AccountSummaryBloc>()),
          BlocProvider(create: (context) => locator<InvoiceBloc>()),
          BlocProvider(create: (context) => locator<ContractsBloc>()),
          BlocProvider(create: (context) => locator<ContractBloc>()),
          BlocProvider(create: (context) => locator<GeneralSettingBloc>()),
          BlocProvider(create: (context) => locator<ContractModelsBloc>()),
          BlocProvider(create: (context) => locator<ContractModelBloc>()),
          BlocProvider(create: (context) => locator<NotificationsBloc>()),

          BlocProvider(create: (context) => NavigationBloc()),
          // BlocProvider(create: (context) => ContractStepCubit()),
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
            return ScrollConfiguration(
              behavior: CustomScrollBehavior(),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: child!,
              ),
            );
          },
        ),
      ),
    );
  }
}

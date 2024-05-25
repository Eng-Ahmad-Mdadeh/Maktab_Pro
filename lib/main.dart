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
import 'package:maktab/domain/calendar/calendar_bloc.dart';
import 'package:maktab/domain/home/home_bloc.dart';
import 'package:maktab/domain/map/map_cubit.dart';
import 'package:maktab/domain/offices/offices_cubit.dart';
import 'package:maktab/domain/receiving_method/receiving_method_bloc.dart';
import 'package:maktab/domain/location/location_bloc.dart';
import 'package:maktab/domain/navigation/navigation_cubit.dart';
import 'package:maktab/domain/profile/profile_bloc.dart';
import 'package:maktab/domain/shimmer/shimmer_bloc.dart';
import 'package:maktab/domain/splash/splash_bloc.dart';
import 'package:maktab/domain/unit/unit_bloc.dart';
import 'package:maktab/domain/user/user_bloc.dart';
import 'package:maktab/domain/video/video_bloc.dart';

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
          BlocProvider(create: (context) => locator<NavigationCubit>()),
          BlocProvider(create: (context) => locator<HomeBloc>()),
          BlocProvider(create: (context) => locator<CalendarBloc>()),
          BlocProvider(create: (context) => locator<MapCubit>()),
          BlocProvider(create: (context) => locator<VideoBloc>()),
          BlocProvider(create: (context) => locator<LocationBloc>()),
          BlocProvider(create: (context) => locator<OfficesCubit>()),
          BlocProvider(create: (context) => locator<UnitBloc>()),
          BlocProvider(create: (context) => locator<ProfileBloc>()),
          BlocProvider(create: (context) => locator<ReceivingMethodBloc>()),
          BlocProvider(create: (context) => locator<UserBloc>()),
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

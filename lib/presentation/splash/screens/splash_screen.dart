import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/core/router/app_routes.dart';
import 'package:maktab/domain/home/home_bloc.dart';
import 'package:maktab/domain/offices/offices_cubit.dart';
import 'package:maktab/domain/receiving_method/receiving_method_bloc.dart';
import 'package:maktab/domain/splash/splash_bloc.dart';
import 'package:maktab/presentation/resources/app_assets.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_button.dart';
import 'package:maktab/presentation/widgets/maktab_image_view.dart';
import 'package:maktab/presentation/widgets/maktab_snack_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (context, state) async {
        if (state is NavigationToIntroScreenState) {
          context.pushReplacement(AppRoutes.introScreen);
        } else if (state is NavigationToHomeScreenState) {
          context.read<ReceivingMethodBloc>().add(GetReceivingMoneyMethodEvent());
          context.read<OfficesCubit>().getIncompleteUnits();
          await context
              .read<OfficesCubit>()
              .stream
              .firstWhere((state) => state.incompleteUnitsApiCallState != OfficesApiCallState.loading)
              .then((e) {
            context.read<HomeBloc>().add(GetStatisticsEvent());
            context
                .read<HomeBloc>()
                .stream
                .firstWhere((state) => state.homeApiCallState != HomeApiCallState.loading)
                .then((e) {
              context.pushReplacement(AppRoutes.homeScreen);
            });
          });
        } else if (state is NavigationToEditProfileScreen) {
          MaktabSnackbar.showWarning(context, "الرجاء اكمال الملف الشخصي");
          //context.pushReplacement(AppRoutes.homeScreen);
          context.pushNamed(AppRoutes.editProfileScreen, extra: true);
        } else if (state is ConnectionFailed) {
          MaktabSnackbar.showError(context, 'حدث خطأ ما');
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              width: SizeHelper.width,
              color: AppColors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(50),
                      child: MaktabImageView(
                        imagePath: AppAssets.gifLogo,
                        fit: BoxFit.fill,
                      ),
                    ),
                    if (context.read<SplashBloc>().state is ConnectionFailed)
                      Column(
                        children: [
                          SizedBox(height: 25.h),
                          MaktabButton(
                            onPressed: () {
                              context.read<SplashBloc>().add(CheckAuthenticationEvent());
                            },
                            width: 200.v,
                            backgroundColor: AppColors.softAsh,
                            color: AppColors.steelBlue,
                            text: 'اعادة المحاولة',
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

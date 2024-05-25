// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/core/router/app_routes.dart';
import 'package:maktab/domain/shimmer/shimmer_bloc.dart';
import 'package:maktab/presentation/resources/app_assets.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_button.dart';
import 'package:maktab/presentation/widgets/maktab_image_view.dart';
import 'package:maktab/presentation/widgets/page_title.dart';
import 'package:maktab/presentation/widgets/shimmer_effect.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    context.read<ShimmerBloc>().add(BeginShimmerEffectEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: SizeHelper.height,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: BlocBuilder<ShimmerBloc, ShimmerState>(
                builder: (context, state) {
              return ShimmerEffect(
                isLoading: state is ShowShimmerEffectState,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(50),
                      child: MaktabImageView(
                        imagePath: AppAssets.logo,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: 50.v),
                    const PageTitle(
                      title: 'أجر واستأجر معنا',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 60.v),
                    MaktabButton(
                      onPressed: () {
                        context.pushNamed(AppRoutes.loginScreen);
                      },
                      backgroundColor: AppColors.lightCyan,
                      text: 'سجل واجر مكتبك معنا',
                    ),
                    SizedBox(height: 15.v),
                    MaktabButton(
                      onPressed: () {},
                      isBordered: true,
                      backgroundColor: AppColors.white,
                      color: AppColors.lightCyan,
                      borderColor: AppColors.lightCyan,
                      text: 'سجل دخول لتطبيق المؤجرين',
                    ),
                    SizedBox(height: 30.v),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                                'تبي تحجز مكتب وغيرها من مكاتب الاعمال ؟\nحمل من هنا ',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: AppColors.slateGray,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          TextSpan(
                            text: 'تطبيق مكتب افراد',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: AppColors.lightCyan,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

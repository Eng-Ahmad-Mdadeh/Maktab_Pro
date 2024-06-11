// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/core/router/app_routes.dart';
import 'package:maktab/core/services/service_locator.dart';
import 'package:maktab/data/repositories/settings_repository.dart';
import 'package:maktab/domain/shimmer/shimmer_bloc.dart';
import 'package:maktab/presentation/resources/app_assets.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_button.dart';
import 'package:maktab/presentation/widgets/maktab_image_view.dart';
import 'package:maktab/presentation/widgets/maktab_rich_text.dart';
import 'package:maktab/presentation/widgets/maktab_snack_bar.dart';
import 'package:maktab/presentation/widgets/page_title.dart';
import 'package:maktab/presentation/widgets/shimmer_effect.dart';
import 'package:url_launcher/url_launcher.dart';

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
            child: BlocBuilder<ShimmerBloc, ShimmerState>(builder: (context, state) {
              return ShimmerEffect(
                isLoading: state is ShowShimmerEffectState,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(50),
                      child: MaktabImageView(
                        imagePath: AppAssets.logo,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: 50.v),
                    const Center(
                      child: PageTitle(
                        title: 'أجر واستأجر معنا',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    MaktabButton(
                      onPressed: () {},
                      isBordered: false,
                      padding: EdgeInsets.zero,
                      backgroundColor: AppColors.white,
                      color: AppColors.lightCyan,
                      borderColor: AppColors.lightCyan,
                      text: 'سجل دخولك لتطبيق المؤجرين',
                    ),
                    SizedBox(height: 10.v),
                    MaktabButton(
                      onPressed: () {
                        context.pushNamed(AppRoutes.loginScreen);
                      },
                      backgroundColor: AppColors.lightCyan,
                      text: 'الدخول او انشاء حساب جديد',
                      fontSize: 21,
                      height: 80.0.v,
                    ),
                    SizedBox(height: 30.v),
                    MaktabRichText(
                      texts: [
                        MaktabRichTextModel(
                          text: 'تبي تحجز مكتب وغيرها من مكاتب الاعمال ؟\nحمل من هنا ',
                          fontWeight: FontWeight.w700,
                          color: AppColors.slateGray,
                          fontSize: 17,
                        ),
                        MaktabRichTextModel(
                          text: 'تطبيق مكتب افراد',
                          color: AppColors.lightCyan,
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          onTap: () async {
                            late final String redirectUrl;
                            final result = await locator<SettingsRepository>().getGeneralSettings();
                            result.fold(
                                  (l) {
                                MaktabSnackbar.showError(context, 'هالك خطأ في الوصول للأعدادات العامة');
                              },
                                  (generalSettings) async {
                                redirectUrl = Platform.isAndroid
                                    ? 'market://details?id=${generalSettings.packageNameAndroidIndividual}'
                                    : Platform.isIOS
                                    ? 'https://apps.apple.com/app/id${generalSettings.packageNameIosIndividual}'
                                    : '';
                                final uri = Uri(
                                  host: "ordinary.maktab.sa",
                                  scheme: "https",
                                  path: "/homeScreen",
                                  queryParameters: {"redirect": redirectUrl},
                                );
                                if (await canLaunchUrl(uri)) {
                                  launchUrl(uri);
                                }
                              },
                            );
                          },
                        ),
                      ],
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

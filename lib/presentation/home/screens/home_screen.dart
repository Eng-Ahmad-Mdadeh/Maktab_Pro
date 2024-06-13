import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/core/helpers/version_helper.dart';
import 'package:maktab/presentation/home/widgets/home_header.dart';
import 'package:maktab/presentation/home/widgets/latest_complaints_card.dart';
import 'package:maktab/presentation/home/widgets/latest_evaluation_section.dart.dart';
import 'package:maktab/presentation/home/widgets/latest_orders_card.dart';
import 'package:maktab/presentation/home/widgets/latest_transfers_section.dart';
import 'package:maktab/presentation/home/widgets/ordinary_search_box.dart';
import 'package:maktab/presentation/home/widgets/units_card.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/services/notification_services.dart';
import '../../../domain/offices/offices_cubit.dart';
import '../../../domain/settings/settings_bloc.dart';
import '../../widgets/body_text.dart';
import '../../widgets/maktab_bottom_app_bar.dart';
import '../../widgets/section_title.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<GeneralSettingBloc, SettingsState>(
      listener: (context, state) async {
        if (state is SettingsSuccess) {
          final vAndroid = state.generalSettings.vAndroid;
          final vIos = state.generalSettings.vIos;
          // final vAppGallery = state.generalSettings.vAppGallery;

          await PackageInfo.fromPlatform().then((packageInfo) {
            final lVersion = VersionHelper.parse(packageInfo.version);
            final rVersion = VersionHelper.parse(Platform.isAndroid
                ? (vAndroid ?? '1.0.0')
                : Platform.isIOS
                    ? (vIos ?? '1.0.0')
                    : '1.0.0');
            if (lVersion < rVersion) {
              showDialog(
                context: context,
                builder: (context) {
                  return PopScope(
                    canPop: false,
                    child: AlertDialog(
                      content: const SectionTitle(title: 'يجب تحديث نسخة التطبيق لديك'),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            final url = Uri.parse(Platform.isAndroid
                                ? 'market://details?id=${packageInfo.packageName}'
                                : Platform.isIOS
                                    ? 'https://apps.apple.com/app/id${packageInfo.packageName}'
                                    : '');

                            if (await canLaunchUrl(url)) {
                              launchUrl(url);
                            }
                          },
                          child: const BodyText(text: "تحديث"),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return packageInfo;
          });
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: SizedBox(
            height: SizeHelper.height,
            child: Stack(
              fit: StackFit.loose,
              children: [
                const HomeHeader(),
                Positioned(
                  top: 55.v,
                  left: 20.h,
                  right: 20.h,
                  bottom: 0,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const OrdinarySearchBox(),
                        if (context.read<OfficesCubit>().state.incompleteOffices.isNotEmpty) UnitsCard(),
                        SizedBox(height: 20.v),
                        LatestTransfersSection(),
                        SizedBox(height: 20.v),
                        LatestEvaluationsSection(),
                        SizedBox(height: 20.v),
                        LatestOrdersCard(),
                        SizedBox(height: 20.v),
                        LatestComplaintsCard(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const MaktabBottomAppBar(),
      ),
    );
  }
}

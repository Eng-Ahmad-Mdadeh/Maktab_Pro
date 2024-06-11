import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maktab/presentation/widgets/section_title.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/helpers/size_helper.dart';
import '../../../core/services/service_locator.dart';
import '../../../data/repositories/settings_repository.dart';
import '../../resources/app_colors.dart';
import '../../widgets/body_text.dart';
import '../../widgets/maktab_snack_bar.dart';

class OrdinarySearchBox extends StatelessWidget {
  const OrdinarySearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
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

        // PackageInfo packageInfo = await PackageInfo.fromPlatform();
        // late final String redirectUrl;
        //
        // if (Platform.isAndroid) {
        //   redirectUrl = "https://play.google.com/store/apps/details?id=${packageInfo.packageName}";
        // }
        // final uri = Uri(
        //   host: "ordinary.maktab.sa",
        //   scheme: "https",
        //   path: "/homeScreen",
        //   queryParameters: {"redirect": redirectUrl},
        // );
        // if (await canLaunchUrl(uri)) {
        //   launchUrl(uri);
        // }
      },
      child: Container(
        width: SizeHelper.width * .5,
        height: 45.0.v,
        decoration: BoxDecoration(
          color: AppColors.mintGreen,
          borderRadius: BorderRadius.circular(30.0.adaptSize),
        ),
        padding: EdgeInsets.all(7.0.adaptSize),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 3.0.v),
              child: Icon(
                FontAwesomeIcons.mapLocationDot,
                size: 23.0.adaptSize,
              ),
            ),
            SizedBox(
              width: 7.0.h,
            ),
            const SectionTitle(
              title: "بحث عن الاعلانات",
              textColor: AppColors.white,

            )
          ],
        ),
      ),
    );
  }
}

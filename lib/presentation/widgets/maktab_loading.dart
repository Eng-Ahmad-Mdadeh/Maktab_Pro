import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/resources/app_assets.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';

Widget loadingItem() {
  return LottieBuilder.asset(
    AppAssets.loadingImage,
    alignment: AlignmentDirectional.center,
    width: 300.h,
    height: 300.v,
    delegates: LottieDelegates(
      values: [
        ValueDelegate.color(
          const ['**', '3d_box', '**'],
          value: AppColors.lightCyan,
        ),
      ],
    ),
  );
}

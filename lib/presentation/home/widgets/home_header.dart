// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.v,
      padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 20.v),
      color: AppColors.deepBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.headphones_outlined,
                color: AppColors.white,
                size: 30,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                'لوحة المعلومات',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: AppColors.white),
              ),
            ),
          ),
          const Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.chat_rounded,
                  color: AppColors.white,
                  size: 25,
                ),
                Icon(
                  Icons.notifications_on_outlined,
                  color: AppColors.white,
                  size: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

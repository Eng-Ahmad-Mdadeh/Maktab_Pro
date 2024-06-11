// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/core/router/app_routes.dart';
import 'package:maktab/domain/notification/notification_bloc.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.v,
      padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 20.v),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.deepBlue,
            AppColors.mintGreen,
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: Align(
              alignment: Alignment.topRight,
              child: SizedBox()
              /*Icon(
                Icons.headphones_outlined,
                color: AppColors.white,
                size: 30,
              )*/
              ,
            ),
          ),
          const Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: SectionTitle(
                title: 'لوحة المعلومات',
                textAlign: TextAlign.center,
                textColor: AppColors.white,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // const Icon(
                //   Icons.chat_rounded,
                //   color: AppColors.white,
                //   size: 25,
                // ),
                IconButton(
                  onPressed: () {
                    context.read<NotificationsBloc>().add(GetNotificationsEvent());
                    context.pushNamed(AppRoutes.notificationsScreen);
                  },
                  icon: const Icon(
                    Icons.notifications_on_outlined,
                    color: AppColors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

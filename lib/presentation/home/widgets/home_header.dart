// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/core/router/app_routes.dart';
import 'package:maktab/domain/notification/notification_bloc.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

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
              )*/,
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
                  onPressed: (){
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

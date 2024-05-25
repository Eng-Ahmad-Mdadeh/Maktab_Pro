// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/core/router/app_routes.dart';
import 'package:maktab/domain/navigation/navigation_cubit.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

class MaktabBottomAppBar extends StatefulWidget {
  const MaktabBottomAppBar({super.key});

  @override
  State<MaktabBottomAppBar> createState() => _MaktabBottomAppBarState();
}

class _MaktabBottomAppBarState extends State<MaktabBottomAppBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: AppColors.white,
      child: SizedBox(
        height: 80.0.v,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavItem(
              index: 0,
              icon: FontAwesomeIcons.house,
              label: 'الرئيسية',
            ),
            NavItem(
              index: 1,
              icon: FontAwesomeIcons.calendarDays,
              label: 'التقويم',
            ),
            NavItem(
              index: 2,
              icon: FontAwesomeIcons.list,
              label: 'الطلبات',
            ),
            NavItem(
              index: 3,
              icon: FontAwesomeIcons.building,
              label: 'المكاتب',
            ),
            NavItem(
              index: 4,
              icon: FontAwesomeIcons.ellipsis,
              label: 'المزيد',
            ),
          ],
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  const NavItem({
    super.key,
    required this.index,
    required this.icon,
    required this.label,
  });

  final int index;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (_, state) {
        return InkWell(
          onTap: () {
            log(state.currentIndexs.toString());
            state.currentIndexs.add(index);
            log(state.currentIndexs.toString());
            _navItemNavigation(index, context);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 35.v,
                color: context.read<NavigationCubit>().state.index == index
                    ? AppColors.lightCyan
                    : AppColors.softAsh,
              ),
              SizedBox(height: 4.v),
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontWeight:
                      context.read<NavigationCubit>().state.index == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                  color: context.read<NavigationCubit>().state.index == index
                      ? AppColors.lightCyan
                      : AppColors.softAsh,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _navItemNavigation(index, BuildContext context) {
    context.read<NavigationCubit>().getNavBarItem(index);
    switch (index) {
      case 0:
        context.pushNamed(AppRoutes.homeScreen);
        break;
      case 1:
        context.pushNamed(AppRoutes.calendarScreen);
        break;
      case 2:
        context.pushNamed(AppRoutes.ordersScreen);
        break;
      case 3:
        context.pushNamed(AppRoutes.officesScreen);
        break;
      case 4:
        context.pushNamed(AppRoutes.moreScreen);
        break;
    }
  }
}

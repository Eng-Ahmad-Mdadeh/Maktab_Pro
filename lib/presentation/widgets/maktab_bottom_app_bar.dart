import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/helpers/size_helper.dart';
import '../../domain/navigation/navigation_bloc.dart';
import '../../domain/navigation/navigation_state.dart';
import '../resources/app_colors.dart';
import 'nav_item.dart';

class MaktabBottomAppBar extends StatelessWidget {
  const MaktabBottomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: AppColors.white,
          child: SizedBox(
            height: 80.0.v,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NavItem(
                  navState: NavigationStates.home,
                  icon: FontAwesomeIcons.house,
                  label: 'الرئيسية',
                  selected: state is HomeNavigationState,
                ),
                NavItem(
                  navState: NavigationStates.calendar,
                  icon: FontAwesomeIcons.calendarDays,
                  label: 'التقويم',
                  selected: state is CalendarNavigationState,
                ),
                NavItem(
                  navState: NavigationStates.orders,
                  icon: FontAwesomeIcons.list,
                  label: 'الطلبات',
                  selected: state is OrdersNavigationState,
                ),
                NavItem(
                  navState: NavigationStates.offices,
                  icon: FontAwesomeIcons.building,
                  label: 'المكاتب',
                  selected: state is OfficesNavigationState,
                ),
                NavItem(//05372328155 - 05365887427
                  navState: NavigationStates.more,
                  icon: FontAwesomeIcons.ellipsis,
                  label: 'المزيد',
                  selected: state is MoreNavigationState,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
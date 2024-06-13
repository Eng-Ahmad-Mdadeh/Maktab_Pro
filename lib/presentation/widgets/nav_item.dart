import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/helpers/size_helper.dart';
import '../../core/router/app_routes.dart';
import '../../domain/navigation/navigation_state.dart';
import '../resources/app_colors.dart';
import 'body_text.dart';

class NavItem extends StatelessWidget {
  final NavigationStates navState;
  final String label;
  final IconData? icon;
  final bool selected;

  const NavItem({
    super.key,
    required this.navState,
    required this.icon,
    required this.label,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: icon == null ? null : () {
        _navItemNavigation(navState, context);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20.v,
            color: selected ? AppColors.mintGreen : AppColors.black.withOpacity(.5),
          ),
          SizedBox(height: 4.v),
          BodyText(
            text: label,
            textColor: selected ? AppColors.mintGreen : AppColors.black,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            fontSize: 13.0,
          ),
        ],
      ),
    );
  }

  void _navItemNavigation(NavigationStates navState, BuildContext context) {
    switch (navState) {
      case NavigationStates.home:
        context.pushReplacementNamed(AppRoutes.homeScreen);
      case NavigationStates.orders:
        context.pushReplacementNamed(AppRoutes.ordersScreen);
      case NavigationStates.addOffice:
        context.pushReplacementNamed(AppRoutes.addedOffersScreen);
      case NavigationStates.offices:
        context.pushReplacementNamed(AppRoutes.officesScreen);
      case NavigationStates.more:
        context.pushReplacementNamed(AppRoutes.moreScreen);
    }
  }
}
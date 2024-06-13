import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../core/helpers/size_helper.dart';
import '../../core/router/app_routes.dart';
import '../../domain/navigation/navigation_bloc.dart';
import '../../domain/navigation/navigation_state.dart';
import '../resources/app_colors.dart';
import 'body_text.dart';
import 'maktab_button.dart';
import 'nav_item.dart';

class MaktabBottomAppBar extends StatelessWidget {
  const MaktabBottomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print(SizeHelper.width);
    print(SizeHelper.height);
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return BottomAppBar(
          shape: const CircularNotchedRectangle(),
          height: 90.0.v,
          padding: EdgeInsets.zero,
          color: AppColors.white,
          child: Stack(
            children: [
              SizedBox(
                height: 90.0.v,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          NavItem(
                            navState: NavigationStates.home,
                            icon: FontAwesomeIcons.house,
                            label: 'الرئيسية',
                            selected: state is HomeNavigationState,
                          ),
                          NavItem(
                            navState: NavigationStates.orders,
                            icon: FontAwesomeIcons.list,
                            label: 'الطلبات',
                            selected: state is OrdersNavigationState,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 50.0.h,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          NavItem(
                            navState: NavigationStates.offices,
                            icon: FontAwesomeIcons.building,
                            label: 'مكاتبي',
                            selected: state is OfficesNavigationState,
                          ),
                          NavItem(
                            navState: NavigationStates.more,
                            icon: FontAwesomeIcons.ellipsis,
                            label: 'المزيد',
                            selected: state is MoreNavigationState,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // if (SizeHelper.width > 400)
                Align(
                  alignment: Alignment(0.0, SizeHelper.width < 420 ? -1.1 : -1.5),
                  child: FloatingActionButton(
                    backgroundColor: AppColors.lushGreen,
                    shape: const CircleBorder(side: BorderSide(color: AppColors.lushGreen)),
                    mini: SizeHelper.width < 420,
                    foregroundColor: AppColors.white,
                    elevation: 0,
                    onPressed: () {
                      context.pushNamed(AppRoutes.createOfficeScreen);
                    },
                    child: Icon(
                      Icons.add,
                      size: 25.0.adaptSize,
                    ),
                  ),
                ),
              // if (SizeHelper.width > 400)
                const Align(
                  alignment: Alignment(0.0, 0.4),
                  child: BodyText(
                    text: "اضف مكتبك",
                    textColor: AppColors.lushGreen,
                    fontSize: 13.0,
                  ),
                ),
              // Align(
              //   alignment: Alignment(0, SizeHelper.height > 600 ? -2 : -5),
              //   child: const AddOfficeButton(),
              // ),
            ],
          ),
        );
      },
    );
  }
}
//
// class AddOfficeButton extends StatelessWidget {
//   const AddOfficeButton({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     if (SizeHelper.width < 400) {
//       return Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           MaktabButton(
//             backgroundColor: AppColors.lushGreen,
//             color: AppColors.white,
//             isCircle: true,
//             borderRadius: BorderRadius.circular(50.0.adaptSize),
//             elevation: 0,
//             icon: Icon(
//               Icons.add,
//               size: 30.0.adaptSize,
//               color: AppColors.white,
//             ),
//             height: 50.0.h,
//             width: 50.0.h,
//             onPressed: () {
//               context.pushNamed(AppRoutes.createOfficeScreen);
//             },
//           ),
//           SizedBox(
//             height: 3.0.v,
//           ),
//           const BodyText(
//             text: "اضف مكتبك",
//             textColor: AppColors.lushGreen,
//           ),
//         ],
//       );
//     } else {
//       return const SizedBox();
//     }
//   }
// }

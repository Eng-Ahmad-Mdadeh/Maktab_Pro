// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/core/router/app_routes.dart';
import 'package:maktab/domain/offices/offices_cubit.dart';
import 'package:maktab/domain/receiving_method/receiving_method_bloc.dart';
import 'package:maktab/presentation/offices/widgets/choose_office_dialog.dart';
import 'package:maktab/presentation/offices/widgets/incomplete_offices_items_list.dart';
import 'package:maktab/presentation/offices/widgets/incomplete_unit_items_list.dart';
import 'package:maktab/presentation/offices/widgets/my_offices_items_list.dart';
import 'package:maktab/presentation/offices/widgets/required_info_dialog.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_button.dart';

import '../../widgets/text/body_text.dart';

class OfficeNavigationDropDownButton extends StatelessWidget {
  OfficeNavigationDropDownButton({super.key});

  final GlobalKey _dropdownKey1 = GlobalKey();

  List<PopupMenuItem<int>> _dropdownItems(BuildContext context) {
    final incompleteOffices = context.read<OfficesCubit>().state.incompleteOffices.length;
    final incompleteUnits = context.read<OfficesCubit>().state.incompleteUnits.length;
    return [
      _buildDropdownMenuItem(
        title: 'مكتب جديد',
        value: 0,
        context: context,
        onTap: () {
          if (context.read<ReceivingMethodBloc>().state.receivingMethod != null) {
            if (context.read<OfficesCubit>().state.searchData != null) {
              context.pushNamed(AppRoutes.createOfficeScreen);
            }
          } else {
            showDialog(
              context: context,
              builder: (context) => const RequiredInfoDialog(),
            );
          }
        },
      ),
      _buildDropdownMenuItem(
        title: 'وحدة تابعة لمكتب حالي',
        value: 1,
        context: context,
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => ChooseOfficeDialog(
              title: 'حدد المكتب',
              officesList: MyOfficesItemsList(),
            ),
          );
        },
      ),
      if(incompleteOffices != 0)
      _buildDropdownMenuItem(
        title: 'مكتب لاستكماله',
        number: incompleteOffices.toString(),
        value: 2,
        context: context,
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => const ChooseOfficeDialog(
              title: 'حدد المكتب',
              officesList: IncompleteOfficesItemsList(),
            ),
          );
        },
      ),
      if(incompleteUnits != 0)
      _buildDropdownMenuItem(
        title: 'وحدة لأستكمالها',
        number: incompleteUnits.toString(),
        value: 3,
        context: context,
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => const ChooseOfficeDialog(
              title: 'حدد الوحدة',
              officesList: IncompleteUnitItemsList(),
            ),
          );
        },
      ),
    ];
  }

  void _showDropdown(GlobalKey key, BuildContext context) {
    final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero, ancestor: overlay);

    showMenu<int>(
      context: context,
      color: AppColors.white,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + renderBox.size.height,
        offset.dx + renderBox.size.width,
        offset.dy + renderBox.size.height,
      ),
      items: _dropdownItems(context).map((PopupMenuItem<int> value) {
        return value;
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaktabButton(
      key: _dropdownKey1,
      onPressed: () {
        _showDropdown(_dropdownKey1, context);
      },
      text: "اضافة مكتب",
      backgroundColor: AppColors.lushGreen,
      fontSize: 17.0.fSize,
      icon: const Icon(Icons.add),
    );

    // return DropdownButton2(
    //     //value: items[0],
    //     isDense: true,
    //     isExpanded: true,
    //     onMenuStateChange: (value) {
    //       context.read<OfficesCubit>().getIncompleteOffices();
    //       context.read<OfficesCubit>().getIncompleteUnits();
    //     },
    //     hint: Row(
    //       children: [
    //         Icon(
    //           FontAwesomeIcons.plus,
    //           color: AppColors.white,
    //           size: 16.adaptSize,
    //         ),
    //         SizedBox(width: 10.h),
    //         Expanded(
    //           child: Text(
    //             'اضافة مكتب / وحدة',
    //             textAlign: TextAlign.center,
    //             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
    //                   color: AppColors.white,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //           ),
    //         )
    //       ],
    //     ),
    //     items: [
    //       _buildDropdownMenuItem(
    //         title: 'مكتب جديد',
    //         value: 0,
    //         context: context,
    //         onTap: () {
    //           if (context.read<ReceivingMethodBloc>().state.receivingMethod != null) {
    //             if (context.read<OfficesCubit>().state.searchData != null) {
    //               context.pushNamed(AppRoutes.createOfficeScreen);
    //             }
    //           } else {
    //             showDialog(
    //               context: context,
    //               builder: (context) => const RequiredInfoDialog(),
    //             );
    //           }
    //         },
    //       ),
    //       _buildDropdownMenuItem(
    //         title: 'وحدة تابعة لمكتب حالي',
    //         value: 1,
    //         context: context,
    //         onTap: () {
    //           showDialog(
    //             context: context,
    //             builder: (context) => ChooseOfficeDialog(
    //               title: 'حدد المكتب',
    //               officesList: MyOfficesItemsList(),
    //             ),
    //           );
    //         },
    //       ),
    //       _buildDropdownMenuItem(
    //         title: 'لديك ${context.read<OfficesCubit>().state.incompleteOffices.length} مكتب لاستكماله',
    //         value: 2,
    //         context: context,
    //         onTap: () {
    //           showDialog(
    //             context: context,
    //             builder: (context) => const ChooseOfficeDialog(
    //               title: 'حدد المكتب',
    //               officesList: IncompleteOfficesItemsList(),
    //             ),
    //           );
    //         },
    //       ),
    //       _buildDropdownMenuItem(
    //         title: 'لديك ${context.read<OfficesCubit>().state.incompleteUnits.length} وحدة لأستكمالها',
    //         value: 3,
    //         context: context,
    //         onTap: () {
    //           showDialog(
    //             context: context,
    //             builder: (context) => const ChooseOfficeDialog(
    //               title: 'حدد الوحدة',
    //               officesList: IncompleteUnitItemsList(),
    //             ),
    //           );
    //         },
    //       ),
    //     ],
    //     iconStyleData: const IconStyleData(
    //       icon: SizedBox.shrink(),
    //     ),
    //     buttonStyleData: ButtonStyleData(
    //         height: 60.v,
    //         decoration: BoxDecoration(
    //           color: AppColors.mintTeal,
    //           borderRadius: BorderRadius.circular(10),
    //         )),
    //     onChanged: (value) {},
    //   );
  }

  PopupMenuItem<int> _buildDropdownMenuItem({
    required String title,
    String? number,
    required int value,
    required BuildContext context,
    required VoidCallback onTap,
  }) {
    return PopupMenuItem<int>(
      value: value,
      enabled: false,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: SizeHelper.width * .4,
          child: Align(
            alignment: Alignment.centerRight,
            child: Row(
              children: [
                if (number != null)
                  BodyText(
                    number,
                    textColor: AppColors.black,
                  ),
                if(number != null)
                  SizedBox(width: 5.0.h,),
                BodyText(
                  title,
                  textColor: AppColors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

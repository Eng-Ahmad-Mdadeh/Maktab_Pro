// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/core/router/app_routes.dart';
import 'package:maktab_lessor/domain/offices/offices_cubit.dart';
import 'package:maktab_lessor/domain/receiving_method/receiving_method_bloc.dart';
import 'package:maktab_lessor/presentation/offices/widgets/choose_office_dialog.dart';
import 'package:maktab_lessor/presentation/offices/widgets/incomplete_offices_items_list.dart';
import 'package:maktab_lessor/presentation/offices/widgets/incomplete_unit_items_list.dart';
import 'package:maktab_lessor/presentation/offices/widgets/my_offices_items_list.dart';
import 'package:maktab_lessor/presentation/offices/widgets/required_info_dialog.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_button.dart';

import '../../widgets/body_text.dart';

class OfficeNavigationDropDownButton extends StatelessWidget {
  final Function(int) onIncompleteOfficeDelete;
  final Function(int) onIncompleteUnitDelete;
  final Function(int) onMyOfficeDelete;
  final GlobalKey _dropdownKey;

  const OfficeNavigationDropDownButton(this._dropdownKey,{
    super.key,
    required this.onIncompleteOfficeDelete,
    required this.onIncompleteUnitDelete,
    required this.onMyOfficeDelete,
  });


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
              officesList: MyOfficesItemsList(
                onMyOfficeDelete: onMyOfficeDelete,
              ),
            ),
          );
        },
      ),
      if (incompleteOffices != 0)
        _buildDropdownMenuItem(
          title: 'مكتب لاستكماله',
          number: incompleteOffices.toString(),
          value: 2,
          context: context,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => ChooseOfficeDialog(
                title: 'حدد المكتب',
                officesList: IncompleteOfficesItemsList(
                  onIncompleteOfficeDelete: onIncompleteOfficeDelete,
                ),
              ),
            );
          },
        ),
      if (incompleteUnits != 0)
        _buildDropdownMenuItem(
          title: 'وحدة لأستكمالها',
          number: incompleteUnits.toString(),
          value: 3,
          context: context,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => ChooseOfficeDialog(
                title: 'حدد الوحدة',
                officesList: IncompleteUnitItemsList(
                  onIncompleteUnitDelete: onIncompleteUnitDelete,
                ),
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
      key: _dropdownKey,
      onPressed: () {
        _showDropdown(_dropdownKey, _dropdownKey.currentContext??context);
      },
      text: "اضافة مكتب",
      backgroundColor: AppColors.lushGreen,
      fontSize: 17.0,
      height: 60.0.v,
      icon: Icon(
        Icons.add,
        size: 30.0.adaptSize,
        color: AppColors.white,
      ),
    );
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
                    text: number,
                    textColor: AppColors.mintGreen,
                  ),
                if (number != null)
                  SizedBox(
                    width: 5.0.h,
                  ),
                BodyText(
                  text: title,
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

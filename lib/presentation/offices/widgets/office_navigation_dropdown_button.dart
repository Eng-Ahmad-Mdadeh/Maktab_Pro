// ignore_for_file: depend_on_referenced_packages

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

class OfficeNavigationDropDownButton extends StatelessWidget {
  const OfficeNavigationDropDownButton({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton2(
      //value: items[0],
      isDense: true,
      isExpanded: true,
      hint: Row(
        children: [
          Icon(
            FontAwesomeIcons.plus,
            color: AppColors.white,
            size: 16.adaptSize,
          ),
          SizedBox(width: 10.h),
          Expanded(
            child: Text(
              'اضافة مكتب / وحدة',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          )
        ],
      ),
      items: [
        _buildDropdownMenuItem(
          title: 'مكتب جديد',
          value: 0,
          context: context,
          onTap: () {
            if (context.read<ReceivingMethodBloc>().state.receivingMethod !=
                null) {
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
        _buildDropdownMenuItem(
          title: 'استكمل انشاء مكتبك',
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
        _buildDropdownMenuItem(
          title: 'استكمل انشاء وحدتك',
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
      ],
      iconStyleData: const IconStyleData(
        icon: SizedBox.shrink(),
      ),
      buttonStyleData: ButtonStyleData(
          height: 60.v,
          decoration: BoxDecoration(
            color: AppColors.mintTeal,
            borderRadius: BorderRadius.circular(10),
          )),
      onChanged: (value) {},
    );
  }

  DropdownMenuItem<int> _buildDropdownMenuItem({
    required String title,
    required int value,
    required BuildContext context,
    required VoidCallback onTap,
  }) {
    return DropdownMenuItem<int>(
      value: value,
      enabled: false,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: SizeHelper.width,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
      ),
    );
  }
}

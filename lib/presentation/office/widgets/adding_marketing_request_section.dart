import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/domain/office/office_bloc.dart';
import 'package:maktab/presentation/office/widgets/office_type_option.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_switch.dart';

class AddingMarketingRequestSection extends StatelessWidget {
  const AddingMarketingRequestSection({super.key});

  @override
  Widget build(BuildContext context) {
    return OfficeTypeOption(
      onTap: context.read<OfficeBloc>().state.createdOffice == null
          ? () {
              context.read<OfficeBloc>().add(AddMarketingRequestEvent());
            }
          : () {},
      leading: Align(
        alignment: Alignment.center,
        child: Container(
          width: 50.h,
          height: 50.v,
          decoration: const ShapeDecoration(
            shape: CircleBorder(),
            color: AppColors.white,
          ),
          child: const Icon(
            Icons.home,
            color: AppColors.softAsh,
            size: 30,
          ),
        ),
      ),
      title: 'إضافة طلب التسويق',
      subtitle: 'بيانات الطلب تطور الوسطاء المرخصين فقط',
      trailing: BlocBuilder<OfficeBloc, OfficeState>(
        builder: (context, state) {
          return MaktabSwitch(
            value: state.marketingRequestState == VisibilityStates.show,
            // activeColor: AppColors.emeraldTeal,
            // activeTrackColor: AppColors.mintGreen,
            onChanged: context.read<OfficeBloc>().state.createdOffice == null
                ? (value) => context.read<OfficeBloc>().add(AddMarketingRequestEvent())
                : (value) {},
          );
        },
      ),
    );
  }
}

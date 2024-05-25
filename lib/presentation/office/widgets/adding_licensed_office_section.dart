import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/domain/office/office_bloc.dart';
import 'package:maktab/presentation/office/widgets/office_type_option.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_switch.dart';

class AddingLicensedOfficeSection extends StatelessWidget {
  const AddingLicensedOfficeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OfficeTypeOption(
          onTap: () => context.read<OfficeBloc>().state.createdOffice == null
              ? context.read<OfficeBloc>().add(AddLicensedOfficeEvent())
              : () {},
          leading: SizedBox(
            width: 50.h,
            height: 50.v,
            child: ElevatedButton(
              onPressed: () =>
                  context.read<OfficeBloc>().state.createdOffice == null
                      ? context.read<OfficeBloc>().add(AddLicensedOfficeEvent())
                      : () {},
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: EdgeInsets.zero,
                backgroundColor: AppColors.emeraldTeal,
              ),
              child: const Center(
                child: Icon(Icons.add, color: Colors.white),
              ),
            ),
          ),
          title: 'إضافة أعلان مباشر',
          subtitle: 'إضافة أعلان مباشر من المالك أو المسوق',
          trailing: BlocBuilder<OfficeBloc, OfficeState>(
            builder: (context, state) {
              return MaktabSwitch(
                value: state.licenseOfficeState == VisibilityStates.show,
                activeColor: AppColors.emeraldTeal,
                activeTrackColor: AppColors.mintGreen,
                onChanged: context.read<OfficeBloc>().state.createdOffice ==
                        null
                    ? (value) =>
                        context.read<OfficeBloc>().add(AddLicensedOfficeEvent())
                    : (value) {},
              );
            },
          ),
        ),

        // BlocBuilder<OfficeBloc, OfficeState>(
        //   builder: (context, state) {
        //     return state.licenseOfficeState == VisibilityStates.show
        //         ? const LicenseNumberForm().animate().fade()
        //         : const SizedBox.shrink();
        //   },
        // ),
      ],
    );
  }
}

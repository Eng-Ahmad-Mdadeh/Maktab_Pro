import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/domain/office/office_bloc.dart';
import 'package:maktab_lessor/presentation/office/widgets/office_type_option.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_switch.dart';

import 'license_number_form.dart';

class AddingLicensedOfficeSection extends StatelessWidget {
  const AddingLicensedOfficeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OfficeTypeOption(
          onTap: () =>
              context.read<OfficeBloc>().state.createdOffice == null ? context.read<OfficeBloc>().add(AddLicensedOfficeEvent()) : null,
          leading: SizedBox(
            width: 50.h,
            height: 50.v,
            child: ElevatedButton(
              onPressed: () => context.read<OfficeBloc>().state.createdOffice == null
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
                // activeColor: AppColors.mintGreen,
                // activeTrackColor: AppColors.white,
                onChanged: context.read<OfficeBloc>().state.createdOffice == null
                    ? (value) => context.read<OfficeBloc>().add(AddLicensedOfficeEvent())
                    : (value) {},
              );
            },
          ),
        ),
        SizedBox(height: 25.v),
        BlocBuilder<OfficeBloc, OfficeState>(
          builder: (context, state) {
            return state.licenseOfficeState == VisibilityStates.show
                ? const LicenseNumberForm().animate().fade()
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

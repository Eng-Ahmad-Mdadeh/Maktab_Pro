import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/domain/license/license_cubit.dart';
import 'package:maktab_lessor/presentation/profile/widgets/license_register_dialog.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_button.dart';

import '../../widgets/section_title.dart';

class LicenseOption extends StatelessWidget {
  const LicenseOption({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LicenseCubit, bool>(
      builder: (context, state) {
        return Column(
          children: [
            const SectionTitle(
              title: 'هل لديك ترخيص لممارسة الوساطة والتسويق العقاري؟',
            ),
            SizedBox(height: 10.v),
            SizedBox(
              height: 60.v,
              child: Row(
                children: [
                  MaktabButton(
                    text: 'نعم',
                    width: 100.h,
                    height: 50.v,
                    backgroundColor: state ? AppColors.emeraldGreen : AppColors.white,
                    color: state ? AppColors.white : AppColors.black,
                    padding: EdgeInsets.zero,
                    isBordered: !state,
                    onPressed: () {
                      context.read<LicenseCubit>().toggleLicenseStatus(true);
                    },
                  ),
                  SizedBox(width: 10.h),
                  MaktabButton(
                    text: 'لا',
                    width: 100.h,
                    height: 50.v,
                    backgroundColor: state ? AppColors.white : AppColors.emeraldGreen,
                    color: state ? AppColors.black : AppColors.white,
                    padding: EdgeInsets.zero,
                    isBordered: state,
                    onPressed: () {
                      context.read<LicenseCubit>().toggleLicenseStatus(false);

                      // showDialog(
                      //   context: context,
                      //   builder: (context) {
                      //     return const LicenseRegisterDialog();
                      //   },
                      // );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

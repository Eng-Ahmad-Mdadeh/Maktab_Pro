import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/domain/office/office_bloc.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_button.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class OfficeMarketerTypeOptions extends StatelessWidget {
  const OfficeMarketerTypeOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'نوع المسوق'),
        SizedBox(height: 5.v),
        BlocBuilder<OfficeBloc, OfficeState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.h),
              child: Row(
                children: [
                  Expanded(
                    child: MaktabButton(
                      text: 'حصري',
                      color: state.marketerTypeOption ==
                          MarketerTypes.exclusive
                          ? AppColors.white
                          : AppColors.black,
                      backgroundColor:
                          state.marketerTypeOption == MarketerTypes.exclusive
                              ? AppColors.lightCyan
                              : AppColors.white,
                      isBordered: true,
                      onPressed: () {
                        context.read<OfficeBloc>().add(
                              const SelectMarketerTypeEvent(
                                  MarketerTypes.exclusive),
                            );
                      },
                    ),
                  ),
                  SizedBox(width: 40.h),
                  Expanded(
                    child: MaktabButton(
                      text: 'غير حصري',
                      color: state.marketerTypeOption ==
                          MarketerTypes.notExclusive
                          ? AppColors.white
                          : AppColors.black,
                      backgroundColor:
                          state.marketerTypeOption == MarketerTypes.notExclusive
                              ? AppColors.lightCyan
                              : AppColors.white,
                      isBordered: true,
                      onPressed: () {
                        context.read<OfficeBloc>().add(
                              const SelectMarketerTypeEvent(
                                  MarketerTypes.notExclusive),
                            );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

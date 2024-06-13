import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/domain/unit/unit_bloc.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_button.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class UnitMarketerTypeOptions extends StatelessWidget {
  const UnitMarketerTypeOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'نوع المسوق'),
        SizedBox(height: 5.v),
        BlocBuilder<UnitBloc, UnitState>(
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
                        context.read<UnitBloc>().add(
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
                        context.read<UnitBloc>().add(
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

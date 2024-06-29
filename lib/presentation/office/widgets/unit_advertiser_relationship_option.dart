import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/domain/unit/unit_bloc.dart';
import 'package:maktab_lessor/presentation/office/widgets/unit_marketer_type_options.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_button.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class UnitAdvertiserRelationshipOption extends StatelessWidget {
  const UnitAdvertiserRelationshipOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'علاقة المعلن'),
        SizedBox(height: 5.v),
        BlocBuilder<UnitBloc, UnitState>(
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: MaktabButton(
                        text: 'مالك',
                        color: state.advertiserRelationshipOption ==
                            AdertiserRelationshipOptions.owner
                            ? AppColors.white
                            : AppColors.black,
                        backgroundColor: state.advertiserRelationshipOption ==
                                AdertiserRelationshipOptions.owner
                            ? AppColors.lightCyan
                            : AppColors.white,
                        isBordered: true,
                        borderRadius: BorderRadius.circular(0),
                        onPressed: () {
                          context.read<UnitBloc>().add(
                              const SelectAdertiserRelationshipEvent(
                                  AdertiserRelationshipOptions.owner));
                        },
                      ),
                    ),
                    Expanded(
                      child: MaktabButton(
                        text: 'وكيل',
                        color: state.advertiserRelationshipOption ==
                            AdertiserRelationshipOptions.agent
                            ? AppColors.white
                            : AppColors.black,
                        backgroundColor: state.advertiserRelationshipOption ==
                                AdertiserRelationshipOptions.agent
                            ? AppColors.lightCyan
                            : AppColors.white,
                        isBordered: true,
                        borderRadius: BorderRadius.circular(0),
                        onPressed: () {
                          context.read<UnitBloc>().add(
                              const SelectAdertiserRelationshipEvent(
                                  AdertiserRelationshipOptions.agent));
                        },
                      ),
                    ),
                    Expanded(
                      child: MaktabButton(
                        text: 'مسوق',
                        color: state.advertiserRelationshipOption ==
                            AdertiserRelationshipOptions.marketer
                            ? AppColors.white
                            : AppColors.black,
                        backgroundColor: state.advertiserRelationshipOption ==
                                AdertiserRelationshipOptions.marketer
                            ? AppColors.lightCyan
                            : AppColors.white,
                        isBordered: true,
                        borderRadius: BorderRadius.circular(0),
                        onPressed: () {
                          context.read<UnitBloc>().add(
                              const SelectAdertiserRelationshipEvent(
                                  AdertiserRelationshipOptions.marketer));
                        },
                      ),
                    ),
                  ],
                ),
                state.advertiserRelationshipOption ==
                        AdertiserRelationshipOptions.marketer
                    ? Column(
                        children: [
                          SizedBox(height: 20.v),
                          const UnitMarketerTypeOptions(),
                        ],
                      ).animate().fade()
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
      ],
    );
  }
}

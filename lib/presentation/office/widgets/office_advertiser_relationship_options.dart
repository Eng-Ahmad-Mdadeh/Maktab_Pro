import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/domain/office/office_bloc.dart';
import 'package:maktab/presentation/office/widgets/office_marketer_type_options.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_button.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class OfficeAdvertiserRelationshipOptions extends StatelessWidget {
  const OfficeAdvertiserRelationshipOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'علاقة المعلن'),
        SizedBox(height: 5.v),
        BlocBuilder<OfficeBloc, OfficeState>(
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: MaktabButton(
                        text: 'مالك',
                        fontSize: 17.0,
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
                          context.read<OfficeBloc>().add(
                              const SelectAdertiserRelationshipEvent(
                                  AdertiserRelationshipOptions.owner));
                        },
                      ),
                    ),
                    Expanded(
                      child: MaktabButton(
                        text: 'وكيل',
                        fontSize: 17.0,
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
                          context.read<OfficeBloc>().add(
                              const SelectAdertiserRelationshipEvent(
                                  AdertiserRelationshipOptions.agent));
                        },
                      ),
                    ),
                    Expanded(
                      child: MaktabButton(
                        text: 'مسوق',
                        fontSize: 17.0,
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
                          context.read<OfficeBloc>().add(
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
                          const OfficeMarketerTypeOptions(),
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

import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/office/office_bloc.dart';
import '../../resources/app_colors.dart';
import '../../widgets/maktab_button.dart';
import '../../widgets/section_title.dart';

class AdvertiserRelationshipOptions extends StatelessWidget {
  const AdvertiserRelationshipOptions({super.key});

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
                        text: 'مالك منشأة',
                        color: state.advertiserRelationshipOption == AdertiserRelationshipOptions.establishment_owner
                            ? AppColors.white
                            : AppColors.black,
                        backgroundColor:
                            state.advertiserRelationshipOption == AdertiserRelationshipOptions.establishment_owner
                                ? AppColors.lightCyan
                                : AppColors.white,
                        isBordered: true,
                        borderRadius: BorderRadius.circular(0),
                        onPressed: () {
                          context.read<OfficeBloc>().add(
                              const SelectAdertiserRelationshipEvent(AdertiserRelationshipOptions.establishment_owner));
                        },
                      ),
                    ),
                    Expanded(
                      child: MaktabButton(
                        text: 'وكيل مالك',
                        color: state.advertiserRelationshipOption == AdertiserRelationshipOptions.owner_agent
                            ? AppColors.white
                            : AppColors.black,
                        backgroundColor: state.advertiserRelationshipOption == AdertiserRelationshipOptions.owner_agent
                            ? AppColors.lightCyan
                            : AppColors.white,
                        isBordered: true,
                        borderRadius: BorderRadius.circular(0),
                        onPressed: () {
                          context
                              .read<OfficeBloc>()
                              .add(const SelectAdertiserRelationshipEvent(AdertiserRelationshipOptions.owner_agent));
                        },
                      ),
                    ),
                    Expanded(
                      child: MaktabButton(
                        text: 'مالك فرد',
                        color: state.advertiserRelationshipOption == AdertiserRelationshipOptions.individual_owner
                            ? AppColors.white
                            : AppColors.black,
                        backgroundColor:
                            state.advertiserRelationshipOption == AdertiserRelationshipOptions.individual_owner
                                ? AppColors.lightCyan
                                : AppColors.white,
                        isBordered: true,
                        borderRadius: BorderRadius.circular(0),
                        onPressed: () {
                          context.read<OfficeBloc>().add(
                              const SelectAdertiserRelationshipEvent(AdertiserRelationshipOptions.individual_owner));
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: MaktabButton(
                        text: 'وسيط فرد',
                        color: state.advertiserRelationshipOption == AdertiserRelationshipOptions.individual_broker
                            ? AppColors.white
                            : AppColors.black,
                        backgroundColor:
                            state.advertiserRelationshipOption == AdertiserRelationshipOptions.individual_broker
                                ? AppColors.lightCyan
                                : AppColors.white,
                        isBordered: true,
                        borderRadius: BorderRadius.circular(0),
                        onPressed: () {
                          context.read<OfficeBloc>().add(
                              const SelectAdertiserRelationshipEvent(AdertiserRelationshipOptions.individual_broker));
                        },
                      ),
                    ),
                    Expanded(
                      child: MaktabButton(
                        text: 'وسيط منشأة',
                        color: state.advertiserRelationshipOption == AdertiserRelationshipOptions.establishment_broker
                            ? AppColors.white
                            : AppColors.black,
                        backgroundColor:
                            state.advertiserRelationshipOption == AdertiserRelationshipOptions.establishment_broker
                                ? AppColors.lightCyan
                                : AppColors.white,
                        isBordered: true,
                        borderRadius: BorderRadius.circular(0),
                        onPressed: () {
                          context.read<OfficeBloc>().add(const SelectAdertiserRelationshipEvent(
                              AdertiserRelationshipOptions.establishment_broker));
                        },
                      ),
                    ),
                  ],
                ),
                // state.advertiserRelationshipOption ==
                //     AdertiserRelationshipOptions.marketer
                //     ? Column(
                //   children: [
                //     SizedBox(height: 20.v),
                //     const MarketerTypeOptions(),
                //   ],
                // ).animate().fade()
                //     : const SizedBox.shrink(),
              ],
            );
          },
        ),
      ],
    );
  }
}

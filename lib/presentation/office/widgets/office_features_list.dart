import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/domain/office/office_bloc.dart';
import 'package:maktab_lessor/presentation/office/widgets/feature_box.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class OfficeFeaturesList extends StatelessWidget {
  const OfficeFeaturesList({super.key});

  @override
  Widget build(BuildContext context) {
    final features = context.read<OfficeBloc>().state.searchData!.features;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'الميزات'),
        SizedBox(height: 10.v),
        Center(
          child: Wrap(
            children: features
                .map((e) => BlocBuilder<OfficeBloc, OfficeState>(
                      builder: (context, state) {
                        return FeatureBox(
                          feature: e,
                          isSelected: state.features.contains(e.id),
                          onTap: () => context.read<OfficeBloc>().add(
                                SelectFeatureEvent(e.id),
                              ),
                        );
                      },
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

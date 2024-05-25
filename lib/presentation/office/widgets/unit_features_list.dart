// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/feature/feature_model.dart';
import 'package:maktab/domain/unit/unit_bloc.dart';
import 'package:maktab/presentation/office/widgets/feature_box.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class UnitFeaturesList extends StatelessWidget {
  UnitFeaturesList({super.key});

  Feature? feature;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'الميزات'),
        SizedBox(height: 10.v),
        SizedBox(
          height: 120.v,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return BlocBuilder<UnitBloc, UnitState>(
                builder: (context, state) {
                  return FeatureBox(
                    feature: context
                        .read<UnitBloc>()
                        .state
                        .searchData!
                        .features[index],
                    isSelected: state.features.contains(context
                        .read<UnitBloc>()
                        .state
                        .searchData!
                        .features[index]
                        .id),
                    onTap: () {
                      context.read<UnitBloc>().add(SelectFeatureEvent(context
                          .read<UnitBloc>()
                          .state
                          .searchData!
                          .features[index]
                          .id));
                    },
                  );
                },
              );
            },
            separatorBuilder: (context, index) => SizedBox(width: 10.h),
            itemCount:
                context.read<UnitBloc>().state.searchData!.features.length,
          ),
        ),
      ],
    );
  }
}

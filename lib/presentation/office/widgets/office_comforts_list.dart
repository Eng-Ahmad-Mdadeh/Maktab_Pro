// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/comfort/comfort_model.dart';
import 'package:maktab/domain/office/office_bloc.dart';
import 'package:maktab/presentation/office/widgets/comfort_box.dart';
import 'package:maktab/presentation/widgets/page_title.dart';

class OfficeComfortsList extends StatelessWidget {
  OfficeComfortsList({super.key});

  Comfort? comfort;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageTitle(title: 'وسائل الراحة', hint: 'اختياري'),
        SizedBox(height: 10.v),
        SizedBox(
          height: 130.v,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return BlocBuilder<OfficeBloc, OfficeState>(
                builder: (context, state) {
                  return ComfortBox(
                    comfort: context
                        .read<OfficeBloc>()
                        .state
                        .searchData!
                        .comforts[index],
                    isSelected: state.comforts.contains(context
                        .read<OfficeBloc>()
                        .state
                        .searchData!
                        .comforts[index]
                        .id),
                    onTap: () {
                      context.read<OfficeBloc>().add(SelectComfortEvent(context
                          .read<OfficeBloc>()
                          .state
                          .searchData!
                          .comforts[index]
                          .id));
                    },
                  );
                },
              );
            },
            separatorBuilder: (context, index) => SizedBox(width: 10.h),
            itemCount:
                context.read<OfficeBloc>().state.searchData!.comforts.length,
          ),
        ),
      ],
    );
  }
}

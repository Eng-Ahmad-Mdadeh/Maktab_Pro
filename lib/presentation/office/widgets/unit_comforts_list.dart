
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/data/models/comfort/comfort_model.dart';
import 'package:maktab_lessor/domain/unit/unit_bloc.dart';
import 'package:maktab_lessor/presentation/office/widgets/comfort_box.dart';
import 'package:maktab_lessor/presentation/widgets/page_title.dart';

class UnitComfortsList extends StatelessWidget {
  UnitComfortsList({super.key});

  Comfort? comfort;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageTitle(title: 'وسائل الراحة (اختياري)'),
        SizedBox(height: 10.v),
        SizedBox(
          height: 130.v,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return BlocBuilder<UnitBloc, UnitState>(
                builder: (context, state) {
                  return ComfortBox(
                    comfort: context
                        .read<UnitBloc>()
                        .state
                        .searchData!
                        .comforts[index],
                    isSelected: state.comforts.contains(context
                        .read<UnitBloc>()
                        .state
                        .searchData!
                        .comforts[index]
                        .id),
                    onTap: () {
                      context.read<UnitBloc>().add(SelectComfortEvent(context
                          .read<UnitBloc>()
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
                context.read<UnitBloc>().state.searchData!.comforts.length,
          ),
        ),
      ],
    );
  }
}

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/office/office_service_model.dart';
import 'package:maktab/domain/unit/unit_bloc.dart';
import 'package:maktab/presentation/office/widgets/service_box.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class UnitServicesServicesList extends StatelessWidget {
  UnitServicesServicesList({super.key});

  OfficeService? service;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'الخدمات'),
        SizedBox(height: 10.v),
        SizedBox(
          height: 130.v,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              service =
                  context.read<UnitBloc>().state.searchData!.services[index];
              return BlocBuilder<UnitBloc, UnitState>(
                builder: (context, state) {
                  return ServiceBox(
                    service: service!,
                    isSelected: state.services.contains(service!.id),
                    onTap: () {
                      context
                          .read<UnitBloc>()
                          .add(SelectServiceEvent(service!.id!));
                    },
                  );
                },
              );
            },
            separatorBuilder: (context, index) => SizedBox(width: 10.h),
            itemCount:
                context.read<UnitBloc>().state.searchData!.services.length,
          ),
        ),
      ],
    );
  }
}

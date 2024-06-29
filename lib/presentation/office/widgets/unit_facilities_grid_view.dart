import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/data/models/facility/facility_model.dart';
import 'package:maktab_lessor/domain/unit/unit_bloc.dart';
import 'package:maktab_lessor/presentation/office/widgets/facility_box.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class UnitFacilitiesGridView extends StatelessWidget {
  const UnitFacilitiesGridView({super.key, required this.facilities});

  final List<Facility> facilities;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'مرافق مكتبك الرئيسية'),
        SizedBox(height: 10.v),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 10.v,
            crossAxisSpacing: 7.h,
            childAspectRatio: 0.8,
          ),
          itemCount: facilities.length,
          itemBuilder: (_, index) {
            return BlocBuilder<UnitBloc, UnitState>(
              builder: (context, state) {
                return FacilityBox(
                  facility: facilities[index],
                  isSelected: state.facilities.contains(facilities[index].id),
                  onTap: () => context
                      .read<UnitBloc>()
                      .add(SelectFacilityEvent(facilities[index].id)),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/data/models/facility/facility_model.dart';
import 'package:maktab_lessor/domain/office/office_bloc.dart';
import 'package:maktab_lessor/presentation/office/widgets/facility_box.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class OfficeFacilitiesGridView extends StatelessWidget {
  const OfficeFacilitiesGridView({super.key, required this.facilities});

  final List<Facility> facilities;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'المرافق الرئيسية للمكان والخدمة'),
        SizedBox(height: 10.v),
        Center(
          child: Wrap(
            children: facilities.map((e) => BlocBuilder<OfficeBloc, OfficeState>(
              builder: (context, state) {
                return FacilityBox(
                  facility: e,
                  isSelected: state.facilities.contains(e.id),
                  onTap: () => context
                      .read<OfficeBloc>()
                      .add(SelectFacilityEvent(e.id)),
                );
              },
            )).toList(),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/data/models/facility/facility_model.dart';
import 'package:maktab_lessor/domain/office/office_bloc.dart';
import 'package:maktab_lessor/presentation/office/widgets/facility_box.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class OfficeFacilitiesGridView extends StatefulWidget {
  const OfficeFacilitiesGridView({super.key, required this.facilities});

  final List<Facility> facilities;

  @override
  State<OfficeFacilitiesGridView> createState() => _OfficeFacilitiesGridViewState();
}

class _OfficeFacilitiesGridViewState extends State<OfficeFacilitiesGridView> {

  late OfficeState state;

  @override
  void initState() {
    state = context.read<OfficeBloc>().state;

    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   print(state.createdUnit?.details.first);
  //   print('@@@@@@@@@@@@@@@@@@');
  //   if ( state.createdUnit?.details!=null) {
  //
  //     if (state.createdUnit!.details.isNotEmpty && state.createdUnit!.details.any((element) => element.arName=="عدد الطاولات",)) {
  //       print('@@@@@@@@@@@@@@@@@@');
  //
  //       context.read<OfficeBloc>().add(ToggleTablesCountSelectorEvent());
  //       final adDetails = state.createdUnit!.details;
  //       context.read<OfficeBloc>().add(IncreaseTablesCountEvent(adDetails
  //           .firstWhere(
  //             (element) => element.arName == "عدد الطاولات",
  //       )
  //           .numberDetails
  //           .toInt()));
  //     }
  //   }
  //   super.didChangeDependencies();
  // }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'المرافق الرئيسية للمكان والخدمة'),
        SizedBox(height: 10.v),
        Center(
          child: Wrap(
            children: widget.facilities.map((e) => BlocBuilder<OfficeBloc, OfficeState>(
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

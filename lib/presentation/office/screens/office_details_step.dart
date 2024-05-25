import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/domain/office/office_bloc.dart';
import 'package:maktab/presentation/office/widgets/office_floor_section.dart';
import 'package:maktab/presentation/office/widgets/office_meeting_rooms_count_section.dart';
import 'package:maktab/presentation/office/widgets/office_age_section.dart';
import 'package:maktab/presentation/office/widgets/office_facilities_grid_view.dart';
import 'package:maktab/presentation/office/widgets/office_shared_work_spaces_section.dart';
import 'package:maktab/presentation/office/widgets/office_tables_count_scetion.dart';
import 'package:maktab/presentation/office/widgets/offices_count_section.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/page_title.dart';

class OfficeDetailsStep extends StatefulWidget {
  const OfficeDetailsStep({super.key});

  @override
  State<OfficeDetailsStep> createState() => _OfficeDetailsStepState();
}

class _OfficeDetailsStepState extends State<OfficeDetailsStep> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const PageTitle(title: 'تفاصيل المكتب'),
          SizedBox(height: 20.v),
          const OfficeFloorSection(),
          const OfficeAgeSection(),
          const OfficesCountSection(),
          const OfficeMeetingRoomsCountSection(),
          const OfficeTablesCountSection(),
          const OfficeSharedWorkSpacesSection(),
          SizedBox(height: 10.v),
          BlocBuilder<OfficeBloc, OfficeState>(
            builder: (context, state) {
              return state.officesCountSelectorState == ToggleStates.on &&
                          state.officesCount == 0 ||
                      state.meetingRoomsCountSelectorState == ToggleStates.on &&
                          state.meetingRoomsCount == 0 ||
                      state.tablesCountSelectorState == ToggleStates.on &&
                          state.tablesCount == 0 ||
                      state.sharedWorkSpacesSelectorState == ToggleStates.on &&
                          state.sharedWorkSpaces == 0
                  ? const BodyText(
                      text: 'الرجاء اختيار قيمة للحقول الفعالة',
                      textColor: AppColors.cherryRed,
                    )
                  : const SizedBox.shrink();
            },
          ),
          SizedBox(height: 10.v),
          OfficeFacilitiesGridView(
              facilities:
                  context.read<OfficeBloc>().state.searchData!.facilities),
        ],
      ),
    );
  }
}

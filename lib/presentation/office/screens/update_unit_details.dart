import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/data/models/office/office_model.dart';
import 'package:maktab_lessor/domain/offices/offices_cubit.dart';
import 'package:maktab_lessor/domain/unit/unit_bloc.dart';
import 'package:maktab_lessor/presentation/office/widgets/unit_age_section.dart';
import 'package:maktab_lessor/presentation/office/widgets/unit_count_section.dart';
import 'package:maktab_lessor/presentation/office/widgets/unit_floor_section.dart';
import 'package:maktab_lessor/presentation/office/widgets/unit_meeting_rooms_count_section.dart';
import 'package:maktab_lessor/presentation/office/widgets/unit_shared_work_spaces_section.dart';
import 'package:maktab_lessor/presentation/office/widgets/unit_tables_count_scetion.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_button.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_snack_bar.dart';
import 'package:maktab_lessor/presentation/widgets/page_title.dart';

class UpdateUnitDetailsScreen extends StatelessWidget {
  const UpdateUnitDetailsScreen({super.key, required this.unit});

  final Office unit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<UnitBloc>()
        ..add(InitialUnitEvent(
            unit, null, context.read<OfficesCubit>().state.searchData)),
      child: BlocConsumer<UnitBloc, UnitState>(
        listener: (context, state) {
          if (state.unitApiCallState == UnitApiCallState.noCall) {
            context.pop();
          } else if (state.unitApiCallState == UnitApiCallState.success) {
            context.read<OfficesCubit>().getOfficeById(unit.id, isUpdate: true);
            context.pop();
            MaktabSnackbar.showSuccess(context, 'تم تعديل تفاصيل الوحدة بنجاح');
          } else if (state.unitApiCallState == UnitApiCallState.failure) {
            MaktabSnackbar.showError(context, 'فشل تعديل التفاصيل');
          }
        },
        builder: (context, state) => state.isInitialized
            ? Scaffold(
                appBar: const MaktabAppBar(title: 'تعديل تفاصيل الوحدة'),
                body: SafeArea(
                  child: SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const PageTitle(title: 'تفاصيل المكتب'),
                        SizedBox(height: 20.v),
                        const UnitFloorSection(),
                        const UnitAgeSection(),
                        const UnitCountSection(),
                        const UnitMeetingRoomsCountSection(),
                        const UnitTablesCountSection(),
                        const UnitSharedWorkSpacesSection(),
                        SizedBox(height: 10.v),
                        BlocBuilder<UnitBloc, UnitState>(
                          builder: (context, state) {
                            return state.officesCountSelectorState ==
                                            ToggleStates.on &&
                                        state.officesCount == 0 ||
                                    state.meetingRoomsCountSelectorState ==
                                            ToggleStates.on &&
                                        state.meetingRoomsCount == 0
                                ? const BodyText(
                                    text: 'الرجاء اختيار قيمة للحقول الفعالة',
                                    textColor: AppColors.cherryRed,
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                        SizedBox(height: 20.v),
                        Container(
                          height: 100.v,
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.h, vertical: 20.v),
                          child: MaktabButton(
                            text: 'حفظ التغييرات',
                            isLoading: state.unitApiCallState ==
                                UnitApiCallState.loading,
                            backgroundColor: AppColors.mintTeal,
                            onPressed: () {
                              context
                                  .read<UnitBloc>()
                                  .add(UpdateUnitDetailsEvent());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

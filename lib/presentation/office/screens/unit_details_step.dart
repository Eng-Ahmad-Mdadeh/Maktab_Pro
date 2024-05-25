import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/office/office_interface_model.dart';
import 'package:maktab/data/models/office/office_type_model.dart';
import 'package:maktab/domain/offices/offices_cubit.dart';
import 'package:maktab/domain/unit/unit_bloc.dart';
import 'package:maktab/presentation/office/widgets/space_text_field.dart';
import 'package:maktab/presentation/office/widgets/unit_count_section.dart';
import 'package:maktab/presentation/office/widgets/unit_facilities_grid_view.dart';
import 'package:maktab/presentation/office/widgets/unit_floor_section.dart';
import 'package:maktab/presentation/office/widgets/unit_meeting_rooms_count_section.dart';
import 'package:maktab/presentation/office/widgets/unit_shared_work_spaces_section.dart';
import 'package:maktab/presentation/office/widgets/unit_tables_count_scetion.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/maktab_drop_down_form_field.dart';
import 'package:maktab/presentation/widgets/page_title.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

import '../widgets/unit_age_section.dart';

class UnitDetailsStep extends StatefulWidget {
  const UnitDetailsStep({super.key});

  @override
  State<UnitDetailsStep> createState() => _UnitDetailsStepState();
}

class _UnitDetailsStepState extends State<UnitDetailsStep> {
  late TextEditingController _unitSpaceController;
  late GlobalKey<FormState> _unitInfoFormKey;
  late OfficeType? type;
  late OfficeInterface? interface;

  @override
  void initState() {
    UnitState state = context.read<UnitBloc>().state;
    _unitSpaceController = TextEditingController(text: state.space);
    _unitInfoFormKey = GlobalKey<FormState>();
    type = state.searchData!.officeTypes.firstWhereOrNull(
        (type) => type.id == context.read<UnitBloc>().state.type);
    interface = state.searchData!.officeInterfaces
        .firstWhereOrNull((interface) => interface.id == state.interfaceId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
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
              return state.officesCountSelectorState == ToggleStates.on &&
                          state.officesCount == 0 ||
                      state.meetingRoomsCountSelectorState == ToggleStates.on &&
                          state.meetingRoomsCount == 0
                  ? const BodyText(
                      text: 'الرجاء اختيار قيمة للحقول الفعالة',
                      textColor: AppColors.cherryRed,
                    )
                  : const SizedBox.shrink();
            },
          ),
          SizedBox(height: 15.v),
          UnitFacilitiesGridView(
              facilities:
                  context.read<OfficesCubit>().state.searchData!.facilities),
          SizedBox(height: 20.v),
          Form(
            key: _unitInfoFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpaceTextField(
                  controller: _unitSpaceController,
                  onChanged: (value) {
                    context.read<UnitBloc>().add(SetSpaceEvent(value!.trim()));
                  },
                ),
                SizedBox(height: 20.v),
                const SectionTitle(title: 'التجهيز'),
                SizedBox(height: 5.v),
                MaktabDropDownFormField(
                  initialValue: context.read<UnitBloc>().state.equipment,
                  items: const ['مؤثث', 'غير مؤثث'],
                  validator: (value) {
                    if (value == null) {
                      return 'الرجاء اختيار التجهيز';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    context.read<UnitBloc>().add(SetEquipmentEvent(value!));
                  },
                ),
                SizedBox(height: 20.v),
                const SectionTitle(title: 'نوع المكتب'),
                SizedBox(height: 5.v),
                MaktabDropDownFormField(
                  initialValue: type != null ? type!.arName : '',
                  items: context
                      .read<OfficesCubit>()
                      .state
                      .searchData!
                      .officeTypes
                      .map((type) => type.arName)
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'الرجاء اختيار نوع المكتب';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    context.read<UnitBloc>().add(SetTypeEvent(value!));
                  },
                ),
                SizedBox(height: 20.v),
                const SectionTitle(title: 'الاتجاه'),
                SizedBox(height: 5.v),
                const BodyText(text: 'اختر اتجاه الحي في المدينة'),
                SizedBox(height: 5.v),
                MaktabDropDownFormField(
                  initialValue: interface != null ? interface!.arName : '',
                  items: context
                      .read<OfficesCubit>()
                      .state
                      .searchData!
                      .officeInterfaces
                      .map((interface) => interface.arName)
                      .toList(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'الرجاء ادخال الاتجاه';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    context
                        .read<UnitBloc>()
                        .add(SetInterfaceEvent(value!.trim()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

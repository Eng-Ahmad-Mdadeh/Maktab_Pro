import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/type_aquar/type_aquar_model.dart';
import 'package:maktab/domain/office/office_bloc.dart';
import 'package:maktab/presentation/office/widgets/office_advertiser_relationship_options.dart';
import 'package:maktab/presentation/office/widgets/space_text_field.dart';
import 'package:maktab/presentation/widgets/maktab_drop_down_form_field.dart';
import 'package:maktab/presentation/widgets/page_title.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class OfficeSecondInfoStep extends StatefulWidget {
  const OfficeSecondInfoStep({super.key});

  @override
  State<OfficeSecondInfoStep> createState() => _OfficeSecondInfoStepState();
}

class _OfficeSecondInfoStepState extends State<OfficeSecondInfoStep> {
  late TextEditingController _officeSpaceController;
  late GlobalKey<FormState> _officeInfoFormKey;
  late TypeAquar? type;

  @override
  void initState() {
    OfficeState state = context.read<OfficeBloc>().state;
    _officeSpaceController = TextEditingController(text: state.space);
    _officeInfoFormKey = GlobalKey<FormState>();
    type = state.searchData!.officeTypes.firstWhereOrNull(
        (type) => type.id == context.read<OfficeBloc>().state.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageTitle(title: 'معلومات المكتب'),
          SizedBox(height: 30.v),
          const OfficeAdvertiserRelationshipOptions(),
          SizedBox(height: 20.v),
          Form(
            key: _officeInfoFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpaceTextField(
                  controller: _officeSpaceController,
                  onChanged: (value) {
                    context
                        .read<OfficeBloc>()
                        .add(SetSpaceEvent(value!.trim()));
                  },
                ),
                SizedBox(height: 20.v),
                const SectionTitle(title: 'التجهيز'),
                SizedBox(height: 5.v),
                MaktabDropDownFormField(
                  initialValue: context.read<OfficeBloc>().state.equipment,
                  items: const ['مؤثث', 'غير مؤثث'],
                  validator: (value) {
                    if (value == null) {
                      return 'الرجاء اختيار التجهيز';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    context.read<OfficeBloc>().add(SetEquipmentEvent(value!));
                  },
                ),
                SizedBox(height: 20.v),
                const SectionTitle(title: 'نوع المكتب'),
                SizedBox(height: 5.v),
                MaktabDropDownFormField(
                  initialValue: type != null ? type!.arName : '',
                  items: context
                      .read<OfficeBloc>()
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
                    context.read<OfficeBloc>().add(SetTypeEvent(value!));
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

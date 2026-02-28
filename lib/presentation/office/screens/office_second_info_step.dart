import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/data/models/type_aquar/type_aquar_model.dart';
import 'package:maktab_lessor/data/models/verify_license_number/verify_license_number_model.dart';
import 'package:maktab_lessor/domain/office/office_bloc.dart';
import 'package:maktab_lessor/presentation/office/widgets/office_advertiser_relationship_options.dart';
import 'package:maktab_lessor/presentation/office/widgets/space_text_field.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_drop_down_form_field.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_text_form_field.dart';
import 'package:maktab_lessor/presentation/widgets/page_title.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class OfficeSecondInfoStep extends StatefulWidget {
  const OfficeSecondInfoStep({super.key});

  @override
  State<OfficeSecondInfoStep> createState() => _OfficeSecondInfoStepState();
}

class _OfficeSecondInfoStepState extends State<OfficeSecondInfoStep> {
  late TextEditingController _officeSpaceController;
  late TextEditingController _officeWidthController;
  List<TypeAquar> selectedOfficeTypes = [];

  late GlobalKey<FormState> _officeInfoFormKey;

  // late TypeAquar? type;
  late OfficeState state;

  String get selectedOfficeTypesText =>
      selectedOfficeTypes.isEmpty ? 'اختر نوع المكان/الخدمة' : selectedOfficeTypes.map((e) => e.arName).join('، ');

  @override
  void initState() {
    state = context.read<OfficeBloc>().state;
    print('999999999');
    print(state.space);
    print('999999999');
    _officeSpaceController = TextEditingController(
        text: state.verifyLicenseNumberModel?.space != null
            ? state.verifyLicenseNumberModel?.space.toString()
            : state.space);
    _officeWidthController = TextEditingController(
        text: state.verifyLicenseNumberModel?.streetWidth != null
            ? state.verifyLicenseNumberModel?.streetWidth.toString()
            : state.streetWidth);

    _officeInfoFormKey = GlobalKey<FormState>();
    // type = state.searchData!.officeTypes.firstWhereOrNull((type) => type.id == context.read<OfficeBloc>().state.type);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (state.verifyLicenseNumberModel != null) {
      context.read<OfficeBloc>().add(SetSpaceEvent(state.verifyLicenseNumberModel?.space.toString() ?? state.space));
      context
          .read<OfficeBloc>()
          .add(SetWidthEvent(state.verifyLicenseNumberModel?.streetWidth.toString() ?? state.streetWidth));
      if (state.verifyLicenseNumberModel?.typeAqar != null && state.verifyLicenseNumberModel!.typeAqar!.isNotEmpty) {
        selectedOfficeTypes.addAll(state.verifyLicenseNumberModel?.typeAqar ?? []);
        context.read<OfficeBloc>().add(
              SetMultiTypeEvent(
                selectedOfficeTypes.map((e) => e.id).toList(),
              ),
            );
      } else if (state.officeTypeIds.isNotEmpty) {
        selectedOfficeTypes =
            state.searchData!.officeTypes.where((type) => state.officeTypeIds.contains(type.id)).toList();
        context.read<OfficeBloc>().add(SetMultiTypeEvent(state.officeTypeIds.toList()));
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageTitle(title: 'معلومات المكان/الخدمة'),
          SizedBox(height: 30.v),
          // const OfficeAdvertiserRelationshipOptions(),
          SizedBox(height: 20.v),
          Form(
            key: _officeInfoFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MaktabTextFormField(
                  readOnly: state.officeType == OfficeTypes.license,
                  controller: _officeSpaceController,
                  title: 'المساحة',
                  smallTitle: '(متر مربع)',
                  hintText: 'الرجاء كتابة المساحة',
                  textInputType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'الرجاء ادخال المساحة';
                    } else if (value.trim().length > 7) {
                      return 'يجب أن يكون الرقم حقيقي';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    context.read<OfficeBloc>().add(SetSpaceEvent(value.trim()));
                  },
                ),
                SizedBox(height: 20.v),
                MaktabTextFormField(
                  readOnly: state.officeType == OfficeTypes.license,
                  controller: _officeWidthController,
                  title: 'عرض الشارع',
                  smallTitle: '(متر)',
                  hintText: 'الرجاء كتابة العرض',
                  textInputType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'الرجاء ادخال العرض';
                    } else if (value.trim().length > 7) {
                      return 'يجب أن يكون الرقم حقيقي';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    context.read<OfficeBloc>().add(SetWidthEvent(value.trim()));
                  },
                ),
                // SpaceTextField(
                //   controller: _officeSpaceController,
                //   onChanged: (value) {
                //     context.read<OfficeBloc>().add(SetSpaceEvent(value!.trim()));
                //   },
                // ),
                SizedBox(height: 20.v),
                const SectionTitle(title: 'التجهيز'),
                SizedBox(height: 5.v),
                MaktabDropDownFormField(
                  // readOnly: state.officeType == OfficeTypes.license,
                  initialValue: context.read<OfficeBloc>().state.equipment,
                  items: const ['مؤثث', 'غير مؤثث'],
                  validator: (value) {
                    if (value == null) {
                      return 'الرجاء اختيار التجهيز';
                    }
                    return null;
                  },
                  onChanged: (value) {

                    context.read<OfficeBloc>().add(SetEquipmentEvent(value));
                  },
                ),
                SizedBox(height: 20.v),
                const SectionTitle(title: 'نوع المكان/الخدمة'),
                SizedBox(height: 5.v),
                // AbsorbPointer(
                //   absorbing: state.officeType == OfficeTypes.license,
                //   child: MaktabDropDownFormField(
                //     initialValue: type != null ? type!.arName : '',
                //     items: context.read<OfficeBloc>().state.searchData!.officeTypes.map((type) => type.arName).toList(),
                //     validator: (value) {
                //       if (value == null) {
                //         return 'الرجاء اختيار نوع المكتب';
                //       }
                //       return null;
                //     },
                //     onChanged: (value) {
                //       context.read<OfficeBloc>().add(SetTypeEvent(value!));
                //     },
                //   ),
                // ),
                AbsorbPointer(
                  absorbing: state.officeType == OfficeTypes.license,
                  child: DropdownButtonFormField<TypeAquar>(
                    isExpanded: true,
                    value: null,
                    // مهم جدًا
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    hint: Text(selectedOfficeTypesText),
                    validator: (_) {
                      if (selectedOfficeTypes.isEmpty) {
                        return 'الرجاء اختيار نوع واحد على الأقل';
                      }
                      return null;
                    },
                    items: state.searchData!.officeTypes.map((type) {
                      return DropdownMenuItem<TypeAquar>(
                        value: type,
                        enabled: false, // يمنع الإغلاق التلقائي
                        child: BlocProvider.value(
                          value: context.read<OfficeBloc>(),
                          child: StatefulBuilder(
                            builder: (context, setStateItem) {
                              final isSelected = selectedOfficeTypes.contains(type);
                              return CheckboxListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                value: isSelected,
                                title: Text(type.arName),
                                controlAffinity: ListTileControlAffinity.leading,
                                onChanged: (checked) {
                                  setState(() {
                                    if (checked == true) {
                                      selectedOfficeTypes.add(type);
                                    } else {
                                      selectedOfficeTypes.remove(type);
                                    }
                                  });

                                  /// تحديث الـ Bloc
                                  context.read<OfficeBloc>().add(
                                        SetMultiTypeEvent(
                                          selectedOfficeTypes.map((e) => e.id).toList(),
                                        ),
                                      );

                                  setStateItem(() {});
                                },
                              );
                            },
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (_) {}, // مطلوب لكن غير مستخدم
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

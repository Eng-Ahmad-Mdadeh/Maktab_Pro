import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/office/office_model.dart';
import 'package:maktab/data/models/type_aquar/type_aquar_model.dart';
import 'package:maktab/domain/offices/offices_cubit.dart';
import 'package:maktab/domain/unit/unit_bloc.dart';
import 'package:maktab/presentation/office/widgets/space_text_field.dart';
import 'package:maktab/presentation/office/widgets/unit_advertiser_relationship_option.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab/presentation/widgets/maktab_button.dart';
import 'package:maktab/presentation/widgets/maktab_drop_down_form_field.dart';
import 'package:maktab/presentation/widgets/maktab_snack_bar.dart';
import 'package:maktab/presentation/widgets/maktab_text_form_field.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class UpdateUnitInfoScreen extends StatefulWidget {
  const UpdateUnitInfoScreen(
      {super.key, required this.office, required this.unit});

  final Office office;
  final Office unit;

  @override
  State<UpdateUnitInfoScreen> createState() => _UpdateUnitInfoScreenState();
}

class _UpdateUnitInfoScreenState extends State<UpdateUnitInfoScreen> {
  late TextEditingController _unitNameController;
  late TextEditingController _unitSpaceController;
  late TypeAquar? type;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _unitNameController = TextEditingController(text: widget.unit.title);
    _unitSpaceController =
        TextEditingController(text: widget.unit.space.toString());
    type = context
        .read<OfficesCubit>()
        .state
        .searchData!
        .officeTypes
        .firstWhereOrNull((type) => type.id.toString() == widget.unit.typeAqarId);
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<UnitBloc>()
        ..add(InitialUnitEvent(widget.unit, widget.office,
            context.read<OfficesCubit>().state.searchData)),
      child: BlocConsumer<UnitBloc, UnitState>(
        listener: (context, state) {
          if (state.unitApiCallState == UnitApiCallState.noCall) {
            context.pop();
          } else if (state.unitApiCallState == UnitApiCallState.success) {
            context
                .read<OfficesCubit>()
                .getOfficeById(widget.unit.id, isUpdate: true);
            context.read<OfficesCubit>().getMyOffices();
            context.pop();
            MaktabSnackbar.showSuccess(
                context, 'تم تعديل معلومات الوحدة بنجاح');
          } else if (state.unitApiCallState == UnitApiCallState.failure) {
            MaktabSnackbar.showError(context, 'فشل تعديل المعلومات');
          }
        },
        builder: (context, state) => state.isInitialized
            ? Scaffold(
                appBar: const MaktabAppBar(title: 'تعديل معلومات الوحدة'),
                body: SafeArea(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MaktabTextFormField(
                                    controller: _unitNameController,
                                    title: 'اسم الوحدة*',
                                    hintText:
                                        'أدخل اسم وحدتك الذي سيظهر للضيوف',
                                    textInputType: TextInputType.name,
                                    validator: (value) {
                                      if (value!.trim().isEmpty) {
                                        return 'الرجاء ادخال اسم الوحدة';
                                      } else if (value.trim().length < 4) {
                                        return 'الاسم يجب على الاقل ان يكون مؤلف من 4 محارف';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      context
                                          .read<UnitBloc>()
                                          .add(SetUnitNameEvent(value.trim()));
                                    },
                                  ),
                                  SizedBox(height: 20.v),
                                  const UnitAdvertiserRelationshipOption(),
                                  SizedBox(height: 20.v),
                                  SpaceTextField(
                                    controller: _unitSpaceController,
                                    onChanged: (value) {
                                      context
                                          .read<UnitBloc>()
                                          .add(SetSpaceEvent(value!.trim()));
                                    },
                                  ),
                                  SizedBox(height: 20.v),
                                  const SectionTitle(title: 'التجهيز'),
                                  SizedBox(height: 5.v),
                                  MaktabDropDownFormField(
                                    initialValue: widget.unit.furnisher,
                                    items: const ['مؤثث', 'غير مؤثث'],
                                    validator: (value) {
                                      if (value == null) {
                                        return 'الرجاء اختيار التجهيز';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      context
                                          .read<UnitBloc>()
                                          .add(SetEquipmentEvent(value!));
                                    },
                                  ),
                                  SizedBox(height: 20.v),
                                  const SectionTitle(title: 'نوع المكتب'),
                                  SizedBox(height: 5.v),
                                  MaktabDropDownFormField(
                                    initialValue:
                                        type != null ? type!.arName : '',
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
                                      context
                                          .read<UnitBloc>()
                                          .add(SetTypeEvent(value!));
                                    },
                                  ),
                                  SizedBox(height: 20.h),
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
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          context
                                              .read<UnitBloc>()
                                              .add(UpdateUnitInfoEvent());
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
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

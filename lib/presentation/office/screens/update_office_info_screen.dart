import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/office/office_model.dart';
import 'package:maktab/domain/office/office_bloc.dart';
import 'package:maktab/domain/offices/offices_cubit.dart';
import 'package:maktab/presentation/offices/widgets/office_info_item.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab/presentation/widgets/maktab_button.dart';
import 'package:maktab/presentation/widgets/maktab_drop_down_form_field.dart';
import 'package:maktab/presentation/widgets/maktab_snack_bar.dart';
import 'package:maktab/presentation/widgets/maktab_text_form_field.dart';

class UpdateOfficeInfoScreen extends StatefulWidget {
  const UpdateOfficeInfoScreen({super.key, required this.office});

  final Office office;

  @override
  State<UpdateOfficeInfoScreen> createState() => _UpdateOfficeInfoScreenState();
}

class _UpdateOfficeInfoScreenState extends State<UpdateOfficeInfoScreen> {
  late TextEditingController _officeNameController;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _officeNameController = TextEditingController(text: widget.office.title);
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<OfficeBloc>()
        ..add(InitialOfficeEvent(
            widget.office, context.read<OfficesCubit>().state.searchData)),
      child: BlocConsumer<OfficeBloc, OfficeState>(
        listener: (context, state) {
          if (state.officeApiCallState == OfficeApiCallState.success) {
            context.read<OfficesCubit>().getMyOffices();
            context.pop();
            MaktabSnackbar.showSuccess(context, 'تم تعديل المعلومات بنجاح');
          } else if (state.officeApiCallState == OfficeApiCallState.failure) {
            MaktabSnackbar.showError(context, 'فشل تعديل المعلومات');
          }
        },
        builder: (context, state) => Scaffold(
          appBar: const MaktabAppBar(title: 'تعديل معلومات المكتب'),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                OfficeInfoItem(
                                  title: 'الاسم',
                                  valueWidget: MaktabTextFormField(
                                    controller: _officeNameController,
                                    textStyle:
                                        Theme.of(context).textTheme.bodyLarge,
                                    textInputType: TextInputType.name,
                                    validator: (value) {
                                      if (value!.trim().isEmpty) {
                                        return 'الرجاء ادخال اسم المكتب';
                                      } else if (value.trim().length < 4) {
                                        return 'الاسم يجب على الاقل ان يكون مؤلف من 4 محارف';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      context
                                          .read<OfficeBloc>()
                                          .add(SetOfficeNameEvent(value!));
                                    },
                                  ),
                                ),
                                OfficeInfoItem(
                                  title: 'نوع المكتب',
                                  valueWidget: MaktabDropDownFormField(
                                    initialValue: context
                                        .read<OfficesCubit>()
                                        .state
                                        .searchData!
                                        .officeCategories
                                        .firstWhereOrNull((category) =>
                                            category.id ==
                                            widget.office.categoryAqar!.id)!
                                        .arName,
                                    items: context
                                        .read<OfficesCubit>()
                                        .state
                                        .searchData!
                                        .officeCategories
                                        .map((category) => category.arName)
                                        .toList(),
                                    onChanged: (value) {},
                                    onSaved: (value) {
                                      context.read<OfficeBloc>().add(
                                          SelectCategoryEvent(context
                                              .read<OfficesCubit>()
                                              .state
                                              .searchData!
                                              .officeCategories
                                              .firstWhere((category) =>
                                                  category.arName == value)
                                              .id));
                                    },
                                  ),
                                ),
                                Container(
                                  height: 100.v,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.h, vertical: 20.v),
                                  child: MaktabButton(
                                    text: 'حفظ التغييرات',
                                    isLoading: state.officeApiCallState ==
                                        OfficeApiCallState.loading,
                                    backgroundColor: AppColors.mintTeal,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        context.read<OfficeBloc>().add(
                                            UpdateOfficeNameAndCategoryEvent());
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

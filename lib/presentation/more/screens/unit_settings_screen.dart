// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/domain/user/user_bloc.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/loading_widget.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_button.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_radio_list_tile.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_snack_bar.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_text_form_field.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';


class UnitSettingsScreen extends StatefulWidget {
  const UnitSettingsScreen({super.key});

  @override
  State<UnitSettingsScreen> createState() => _UnitSettingsScreenState();
}

class _UnitSettingsScreenState extends State<UnitSettingsScreen> {
  // late TextEditingController insurancePriceController;
  // late TextEditingController conditionController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // UserBloc userBloc = context.read<UserBloc>();
    // insurancePriceController = TextEditingController(
    //     text: userBloc.state.unitSettings != null ? userBloc.state.unitSettings!.price.toString() : '');
    // conditionController = TextEditingController(
    //     text: userBloc.state.unitSettings != null ? userBloc.state.unitSettings!.text : '');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    context.read<UserBloc>().add(GetUnitSettingsEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MaktabAppBar(title: 'إعدادات الوحدة'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 20.v),
                  child: Form(
                    key: _formKey,
                    child: BlocConsumer<UserBloc, UserState>(
                      listener: (context, state) {
                        // if (state.getUnitSettingsApiCallState == UserApiCallState.loading) {
                        //   LoadingDialog.show(context);
                        // } else if (state.getUnitSettingsApiCallState == UserApiCallState.success) {
                        //   LoadingDialog.hide(context);
                        // } else if (state.getUnitSettingsApiCallState == UserApiCallState.failure) {
                        //   LoadingDialog.hide(context);
                        //   MaktabSnackbar.showError(context, state.message);
                        // } else if (state.getUnitSettingsApiCallState == UserApiCallState.noCall) {
                        //   MaktabSnackbar.showWarning(context, 'لا يوجد اي تغيير');
                        // }
                      },
                      builder: (context, state) {
                        if (state.getUnitSettingsApiCallState == UserApiCallState.loading)
                          return const LoadingWidget(0);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SectionTitle(
                              title: 'هل تطلب تأمين مسترد من المستأجرين عند الوصول؟',
                              textAlign: TextAlign.start,
                              textColor: AppColors.lightBlack,
                            ),
                            SizedBox(height: 10.v),
                            Column(
                              children: [
                                MaktabRadioListTile(
                                  title: 'لا لا أطلب',
                                  value: false,
                                  groupValue: state.isInsuranceRequired,
                                  onChanged: (value) {
                                    context.read<UserBloc>().add(ToggleAssuranceRequiredEvent(value!));
                                  },
                                ),
                                MaktabRadioListTile(
                                  title: 'نعم أطلب',
                                  value: true,
                                  groupValue: state.isInsuranceRequired,
                                  onChanged: (value) {
                                    context.read<UserBloc>().add(ToggleAssuranceRequiredEvent(value!));
                                  },
                                ),
                                SizedBox(height: 20.v),
                                if (state.isInsuranceRequired) ...{
                                  MaktabTextFormField(
                                    // controller: insurancePriceController,
                                    initialValue: state.unitSettings?.price.toString() ?? '',
                                    title: 'مبلغ التأمين المسترد',
                                    textInputType: TextInputType.number,
                                    suffix: Padding(
                                      padding: EdgeInsets.only(left: 10.h),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: BodyText(text: 'ريال'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    validator: (value) {
                                      if (value!.trim().isEmpty) {
                                        return 'الرجاء ادخال المبلغ';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      context.read<UserBloc>().add(SetInsurancePriceEvent(value!));
                                    },
                                  ),
                                  SizedBox(height: 20.v),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 10.v, horizontal: 10.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.adaptSize),
                                      color: AppColors.lightCyan.withOpacity(0.3),
                                    ),
                                    child: const BodyText(
                                      text:
                                          "مبلغ التأمين يدفعه المستأجرين عند الوصول و يسترجع عند المغادرة بعد التأكد من سلامة الممتلكات",
                                      textColor: AppColors.forestTeal,
                                    ),
                                  ),
                                  SizedBox(height: 20.v),
                                },
                              ],
                            ),
                            MaktabTextFormField(
                              // controller: conditionController,
                              initialValue: state.unitSettings?.text ?? '',
                              title: 'هل لديك شروط أخرى للحجز',
                              minLines: 7,
                              maxLines: null,
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'حقل مطلوب';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                context.read<UserBloc>().add(SetConditionsEvent(value!));
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {
                  if (state.updateUnitSettingsApiCallState == UserApiCallState.success) {
                    MaktabSnackbar.showSuccess(context, 'تم الحفظ بنجاح');
                    context.pop();
                  } else if (state.updateUnitSettingsApiCallState == UserApiCallState.failure) {
                    MaktabSnackbar.showError(context, state.message);
                  } else if (state.updateUnitSettingsApiCallState == UserApiCallState.noCall) {
                    MaktabSnackbar.showWarning(context, 'لا يوجد اي تغيير');
                    context.pop();
                  }
                },
                builder: (context, state) => MaktabButton(
                  onPressed: /*(state.isInsuranceRequired != state.unitSettings!.isInsuranceRequired ||
                      state.insurancePrice != state.unitSettings!.price.toString() ||
                      state.conditions != state.unitSettings!.text) ? null : */
                      () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      context.read<UserBloc>().add(SetUnitSettingsEvent());
                    }
                  },
                  isLoading: state.updateUnitSettingsApiCallState == UserApiCallState.loading,
                  fontSize: 19.0,
                  // backgroundColor: (state.isInsuranceRequired != state.unitSettings!.isInsuranceRequired ||
                  //     state.insurancePrice != state.unitSettings!.price.toString() ||
                  //     state.conditions != state.unitSettings!.text) ? AppColors.softAsh : AppColors.mintGreen,
                  text: 'حفظ التغييرات',
                ),
              ),
              SizedBox(
                height: 10.0.v,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

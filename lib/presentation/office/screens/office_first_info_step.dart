import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/core/router/app_routes.dart';
import 'package:maktab/domain/office/office_bloc.dart';
import 'package:maktab/domain/user/user_bloc.dart';
import 'package:maktab/presentation/office/widgets/office_category_box.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/loading_dialog.dart';
import 'package:maktab/presentation/widgets/maktab_snack_bar.dart';
import 'package:maktab/presentation/widgets/maktab_text_form_field.dart';
import 'package:maktab/presentation/widgets/page_title.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class OfficeFirstInfoStep extends StatefulWidget {
  const OfficeFirstInfoStep({super.key});

  @override
  State<OfficeFirstInfoStep> createState() => _OfficeFirstInfoStepState();
}

class _OfficeFirstInfoStepState extends State<OfficeFirstInfoStep> {
  late TextEditingController _officeNameController;
  late GlobalKey<FormState> _officeNameFormKey;

  @override
  void initState() {
    OfficeState state = context.read<OfficeBloc>().state;
    _officeNameController = TextEditingController(text: state.name);
    _officeNameFormKey = GlobalKey<FormState>();
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
          Form(
            key: _officeNameFormKey,
            child: MaktabTextFormField(
              controller: _officeNameController,
              title: 'اسم مكتبك',
              hintText: 'أدخل اسم مكتبك الذي سيظهر للضيوف',
              textInputType: TextInputType.name,
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return 'الرجاء ادخال اسم المكتب';
                } else if (value.trim().length < 4) {
                  return 'الاسم يجب على الاقل ان يكون مؤلف من 4 محارف';
                }
                return null;
              },
              onChanged: (value) {
                context
                    .read<OfficeBloc>()
                    .add(SetOfficeNameEvent(value!.trim()));
              },
            ),
          ),
          SizedBox(height: 20.v),
          const SectionTitle(title: 'تصنيف مكتبك'),
          SizedBox(height: 10.v),
          const BodyText(text: 'حدد التصميم المناسب'),
          SizedBox(height: 15.v),
          BlocBuilder<OfficeBloc, OfficeState>(
            builder: (context, state) {
              return GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10.v,
                  crossAxisSpacing: 8.h,
                ),
                itemCount: state.searchData!.officeCategories.length,
                itemBuilder: (context, index) {
                  return OfficeCategoryBox(
                    officeCategory: state.searchData!.officeCategories[index],
                    isSelected: context.read<OfficeBloc>().state.categoryId ==
                        state.searchData!.officeCategories[index].id,
                    onTap: () {
                      context.read<OfficeBloc>().add(SelectCategoryEvent(
                          state.searchData!.officeCategories[index].id));
                    },
                  );
                },
              );
            },
          ),
          SizedBox(height: 15.v),
          BlocBuilder<OfficeBloc, OfficeState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: state.acceptingUserAgreement,
                        activeColor: AppColors.mintTeal,
                        checkColor: AppColors.white,
                        onChanged: (value) => context
                            .read<OfficeBloc>()
                            .add(ToggleAccepingUserAgreementEvent()),
                      ),
                      Flexible(
                        child: BlocListener<UserBloc, UserState>(
                          listener: (context, state) {
                            if (state.userAgreementApiCallState ==
                                UserApiCallState.loading) {
                              LoadingDialog.show(context);
                            } else if (state.userAgreementApiCallState ==
                                UserApiCallState.success) {
                              LoadingDialog.hide(context);
                              context.pushNamed(AppRoutes.userAgreementScreen);
                            } else if (state.userAgreementApiCallState ==
                                UserApiCallState.failure) {
                              LoadingDialog.hide(context);
                              MaktabSnackbar.showError(context, state.message);
                            }
                          },
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'هل انت موافق على ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        color: AppColors.slateGray,
                                      ),
                                ),
                                TextSpan(
                                  text: 'إتفاقية الاستخدام',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        color: AppColors.mintTeal,
                                      ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context
                                          .read<UserBloc>()
                                          .add(GetUserAgreementEvent());
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (!state.acceptingUserAgreement)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.h),
                      child: const BodyText(
                        text: 'الرجاء الموافقة على الشروط',
                        textColor: AppColors.cherryRed,
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

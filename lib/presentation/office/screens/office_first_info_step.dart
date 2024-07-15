import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/core/router/app_routes.dart';
import 'package:maktab_lessor/domain/office/office_bloc.dart';
import 'package:maktab_lessor/domain/user/user_bloc.dart';
import 'package:maktab_lessor/presentation/office/widgets/office_category_box.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/loading_dialog.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_snack_bar.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_text_form_field.dart';
import 'package:maktab_lessor/presentation/widgets/page_title.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

import '../../widgets/maktab_rich_text.dart';

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
          const PageTitle(title: 'معلومات المكان/الخدمة'),
          SizedBox(height: 30.v),
          Form(
            key: _officeNameFormKey,
            child: MaktabTextFormField(
              controller: _officeNameController,
              title: 'أضف عنواناً لإعلانك',
              hintText: 'أدخل اسم المكان/الخدمة الذي سيظهر للضيوف',
              textInputType: TextInputType.name,
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return 'الرجاء ادخال اسم المكان/الخدمة';
                } else if (value.trim().length < 4) {
                  return 'الاسم يجب على الاقل ان يكون مؤلف من 4 محارف';
                }
                return null;
              },
              onChanged: (value) {
                context
                    .read<OfficeBloc>()
                    .add(SetOfficeNameEvent(value.trim()));
              },
            ),
          ),
          SizedBox(height: 20.v),
          const SectionTitle(title: 'تصنيف المكان/الخدمة'),
          SizedBox(height: 10.v),
          const BodyText(text: 'حدد التصنيف المناسب'),
          SizedBox(height: 15.v),
          BlocBuilder<OfficeBloc, OfficeState>(
            builder: (context, state) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10.v,
                  crossAxisSpacing: 8.h,
                  childAspectRatio: 5/4
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
                        side: const BorderSide(
                            color: AppColors.gray
                        ),
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
                          child: MaktabRichText(
                            texts: [
                              MaktabRichTextModel(
                                text: 'هل انت موافق على ',
                                color: AppColors.slateGray,
                              ),
                              MaktabRichTextModel(
                                text: 'إتفاقية الاستخدام',
                                color: AppColors.mintTeal,
                                onTap: () {
                                  context
                                      .read<UserBloc>()
                                      .add(GetUserAgreementEvent());
                                }
                              ),
                            ],
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

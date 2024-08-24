// ignore_for_file: library_private_types_in_public_api
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/extension/email_validation_extension.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/data/models/user/user_model.dart';
import 'package:maktab_lessor/domain/profile/profile_bloc.dart';
import 'package:maktab_lessor/presentation/profile/widgets/license_option.dart';
import 'package:maktab_lessor/presentation/profile/widgets/license_text_fields.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_button.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_text_form_field.dart';
import 'package:maktab_lessor/presentation/widgets/phone_text_field.dart';

import '../../resources/app_assets.dart';
import '../../resources/app_colors.dart';
import '../../widgets/body_text.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/maktab_image_view.dart';
import '../../widgets/page_title.dart';
import '../../widgets/section_title.dart';

class AccountInformationForm extends StatefulWidget {
  const AccountInformationForm({super.key});

  @override
  _AccountInformationFormState createState() => _AccountInformationFormState();
}

class _AccountInformationFormState extends State<AccountInformationForm> {
  late TextEditingController userNameController;
  late TextEditingController companyNameController;

  late TextEditingController officeNameController;

  late TextEditingController emailController;

  late TextEditingController cityController;

  late TextEditingController neighborhoodController;

  late TextEditingController identityNumberController;

  late TextEditingController commercialRecordController;

  late TextEditingController phoneController;
  late TextEditingController aboutController;

  late TextEditingController licenseLinkController;
  late TextEditingController licenseNumberController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    User? user = BlocProvider.of<ProfileBloc>(context).state.user;
    userNameController = TextEditingController(text: user?.userName ?? '');
    companyNameController = TextEditingController(text: user?.companyName ?? '');
    officeNameController = TextEditingController(text: user?.officeName ?? '');
    emailController = TextEditingController(text: user?.email ?? '');
    cityController = TextEditingController(text: user?.city ?? '');
    neighborhoodController = TextEditingController(text: user?.neighborhood ?? '');
    identityNumberController = TextEditingController(text: user?.idNumber ?? '');
    commercialRecordController = TextEditingController(text: user?.commercialRecord ?? '');
    phoneController = TextEditingController(text: user?.phone ?? '');
    aboutController = TextEditingController(text: user?.about ?? '');
    licenseLinkController = TextEditingController(text: user?.licenseLink ?? '');
    licenseNumberController = TextEditingController(text: user?.licenseNumber ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(child: BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MaktabTextFormField(
                title: 'اسم المستخدم',
                controller: userNameController,
                textInputType: TextInputType.name,
                hintText: 'أدخل اسم المستخدم',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'الرجاء ادخال اسم المستخدم';
                  }
                  return null;
                },
              ),
              //شركة
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.v),
                  if (state.selectedAccountTypeIndex == 1)
                    MaktabTextFormField(
                      title: 'الشركة',
                      controller: companyNameController,
                      textInputType: TextInputType.name,
                      hintText: 'أدخل اسم الشركة',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'الرجاء ادخال اسم الشركة';
                        }
                        return null;
                      },
                    ),
                ],
              ),
              //مكتب
              if (state.selectedAccountTypeIndex == 5)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.v),
                    MaktabTextFormField(
                      title: 'المكتب',
                      controller: officeNameController,
                      textInputType: TextInputType.name,
                      hintText: 'أدخل اسم المكتب',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'الرجاء ادخال اسم المكتب';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              SizedBox(height: 20.v),
              MaktabTextFormField(
                title: 'الايميل',
                controller: emailController,
                textInputType: TextInputType.emailAddress,
                hintText: 'أدخل الايميل',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'الرجاء ادخال الايميل';
                  }
                  if (!value.isValidEmail) {
                    return 'الرجاء ادخال ايميل صالح';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.v),
              MaktabTextFormField(
                title: 'المدينة',
                controller: cityController,
                textInputType: TextInputType.text,
                hintText: 'أدخل المدينة',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'الرجاء ادخال اسم المدينة';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.v),
              MaktabTextFormField(
                title: 'الحي',
                controller: neighborhoodController,
                textInputType: TextInputType.text,
                hintText: 'أدخل الحي',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'الرجاء ادخال اسم الحي';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.v),
              MaktabTextFormField(
                title: 'رقم الهوية / الإقامة',
                controller: identityNumberController,
                textInputType: TextInputType.number,
                hintText: 'أدخل رقم الهوية / الإقامة',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  LengthLimitingTextInputFormatter(10),
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'الرجاء ادخال رقم الهوية / الاقامة';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.v),
              if (state.selectedAccountTypeIndex == 5 || state.selectedAccountTypeIndex == 1)
              MaktabTextFormField(
                title: 'رقم السجل التجاري',
                controller: commercialRecordController,
                textInputType: TextInputType.number,
                hintText: 'أدخل رقم رقم السجل التجاري',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  LengthLimitingTextInputFormatter(5),
                ],
                validator: (value) {
                  if (value!.length < 5) {
                    return 'الرجاء ادخال رقم من خمس محارف';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.v),
              PhoneTextfield(
                controller: phoneController,
                textFieldFontSize: 15,
                titleSize: 17.0,
                hintSize: 15,
                countryCodeSize: 35,
              ),
              SizedBox(height: 20.v),
              MaktabTextFormField(
                title: 'نبذة',
                controller: aboutController,
                textInputType: TextInputType.text,
                maxLines: 3,
                hintText: 'نبذة',
              ),
              SizedBox(height: 25.v),
              const LicenseOption(),
              LicenseTextFields(
                licenseLinkController: licenseLinkController,
                licenseNumberController: licenseNumberController,
              ),
              SizedBox(height: 25.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaktabButton(
                    text: 'حفظ واستمرار',
                    width: SizeHelper.width * 0.4,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        log("selected:${aboutController.text}");
                        context.read<ProfileBloc>().add(UpdateProfileEvent(
                            state.user!.id.toString(),
                            userNameController.text,
                            companyNameController.text,
                            officeNameController.text,
                            emailController.text,
                            cityController.text,
                            neighborhoodController.text,
                            identityNumberController.text,
                            state.selectedAccountTypeIndex == 5 || state.selectedAccountTypeIndex == 1 ? commercialRecordController.text:null,
                            phoneController.text,
                            aboutController.text,
                            state.selectedAccountTypeIndex,
                            state.pickedImage,
                            licenseNumberController.text,
                            licenseLinkController.text));
                      }
                    },
                  ),
                  state.profileState == ProfileStates.loading
                      ? const LoadingWidget(0)
                      : Column(
                    children: [
                      MaktabButton(
                        text: "حذف الحساب",
                        backgroundColor: AppColors.cherryRed,
                        width: SizeHelper.width * 0.4,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const PageTitle(
                                title: "تأكيد الحذف",
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  MaktabImageView(
                                    imagePath: AppAssets.deleteContract,
                                    color: AppColors.cherryRed,
                                    width: 100.adaptSize,
                                  ),
                                  const SectionTitle(title: "هل تريد تأكيد حذف حسابك"),
                                  SizedBox(
                                    height: 10.v,
                                  ),
                                  const BodyText(
                                    text: "ملاحظة: سيتم حذف حسابك بعد الموفقة على طلب الحذف",
                                    overflow: TextOverflow.visible,
                                  ),
                                ],
                              ),
                              actionsAlignment: MainAxisAlignment.center,
                              actions: [
                                MaktabButton(
                                  text: "لا",
                                  width: SizeHelper.width * 0.3,
                                  onPressed: context.pop,
                                ),
                                MaktabButton(
                                  text: "نعم",
                                  width: SizeHelper.width * 0.3,
                                  backgroundColor: AppColors.cherryRed,
                                  onPressed: () {
                                    context.read<ProfileBloc>().add(DeleteProfileEvent());
                                    context.pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              if (state.user != null)
                if (state.user!.requestDeleteAccount)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 14.v),
                      child: const BodyText(
                        text: "تم ارسال طلب حذف حسابك",
                        textColor: AppColors.cherryRed,
                      ),
                    ),
                  ),
            ],
          ),
        );
      },
    ));
  }
}

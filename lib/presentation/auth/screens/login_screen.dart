import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/core/router/app_routes.dart';
import 'package:maktab_lessor/domain/auth/auth_bloc.dart';
import 'package:maktab_lessor/presentation/auth/widgets/message_option_card.dart';
import 'package:maktab_lessor/presentation/auth/widgets/option_button.dart';
import 'package:maktab_lessor/presentation/widgets/loading_dialog.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_snack_bar.dart';
import 'package:maktab_lessor/presentation/widgets/phone_text_field.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_button.dart';
import 'package:maktab_lessor/presentation/widgets/page_title.dart';

import '../../resources/app_assets.dart';
import '../../widgets/section_title.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MaktabAppBar(title: 'تسجيل الدخول'),
      body: SafeArea(
        child: Container(
          width: SizeHelper.width,
          padding: EdgeInsets.symmetric(horizontal: 25.h),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(AppAssets.pattren), fit: BoxFit.cover, opacity: .2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30.v),
              const PageTitle(
                title: "الرجاء ادخال رقم الموبايل",
                fontSize: 19.0,
              ),
              SizedBox(height: 20.v),
              const SectionTitle(
                title: "سيصلك رمز التحقق لتسجيل الدخول الى حسابك أو قم بانشاء حساب جديد.",
                textColor: AppColors.stormyGray,
                overflow: TextOverflow.visible,
                fontSize: 15.0,
              ),
              SizedBox(height: 40.v),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.loginState == LoginStates.success) {
                    LoadingDialog.hide(context);
                    MaktabSnackbar.showSuccess(context, state.message);
                    context.pushNamed(AppRoutes.verifyCodeScreen, extra: _phoneController.text);
                  } else if (state.loginState == LoginStates.failure) {
                    LoadingDialog.hide(context);
                    MaktabSnackbar.showError(context, state.message);
                  } else if (state.loginState == LoginStates.loading) {
                    LoadingDialog.show(context);
                  }
                },
                builder: (context, state) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        PhoneTextfield(
                          controller: _phoneController,
                          onChanged: (value) {
                            if (value.length == 9) {
                              if (_formKey.currentState!.validate()) {
                                if (state.option != MessageOptionStetes.show) {
                                  context.read<AuthBloc>().add(ToggleMessageOptionsEvent());
                                }
                                FocusManager.instance.primaryFocus!.unfocus();
                              }
                            }
                          },
                        ),
                        SizedBox(height: 40.v),
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: MaktabButton(
                                onPressed: () {
                                  FocusManager.instance.primaryFocus!.unfocus();
                                },
                                backgroundColor: AppColors.lightCyan,
                                color: AppColors.white,
                                text: 'متابعة',
                                fontSize: 21.0,
                              ),
                            ),
                            Visibility(
                              visible: state.option == MessageOptionStetes.show ? true : false,
                              child: MessageOptionsCard(
                                title: "يرجى ادخال طريقة ارسال رمز التحقق",
                                onClose: () {
                                  if (state.option != MessageOptionStetes.hide) {
                                    context.read<AuthBloc>().add(ToggleMessageOptionsEvent());
                                  }
                                },
                                buttons: [
                                  OptionButton(
                                    text: 'WhatsApp',
                                    icon: Icons.phone,
                                    color: AppColors.emeraldGreen,
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        context
                                            .read<AuthBloc>()
                                            .add(LoginEvent(_phoneController.text, 'whatsapp'));
                                        if (state.option != MessageOptionStetes.show) {
                                          context.read<AuthBloc>().add(ToggleMessageOptionsEvent());
                                        }
                                        FocusManager.instance.primaryFocus!.unfocus();
                                      }
                                    },
                                  ),
                                  OptionButton(
                                    text: 'رسالة نصية',
                                    icon: Icons.message,
                                    color: AppColors.mintGreen,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        context
                                            .read<AuthBloc>()
                                            .add(LoginEvent(_phoneController.text, 'sms'));
                                        if (state.option != MessageOptionStetes.show) {
                                          context.read<AuthBloc>().add(ToggleMessageOptionsEvent());
                                        }
                                        FocusManager.instance.primaryFocus!.unfocus();
                                      }
                                    },
                                  ),
                                ],
                              ).animate().fade(),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

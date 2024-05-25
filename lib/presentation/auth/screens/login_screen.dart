// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/core/router/app_routes.dart';
import 'package:maktab/domain/auth/auth_bloc.dart';
import 'package:maktab/presentation/auth/widgets/message_option_card.dart';
import 'package:maktab/presentation/auth/widgets/option_button.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/loading_dialog.dart';
import 'package:maktab/presentation/widgets/maktab_snack_bar.dart';
import 'package:maktab/presentation/widgets/phone_text_field.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab/presentation/widgets/maktab_button.dart';
import 'package:maktab/presentation/widgets/page_title.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MaktabAppBar(title: 'تسجيل الدخول'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: SizeHelper.width,
            padding: EdgeInsets.symmetric(horizontal: 25.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.v),
                const PageTitle(title: 'أدخل رقم الجوال'),
                SizedBox(height: 20.v),
                const BodyText(
                  text:
                      'سيصلك رمز التحقق لتسجيل الدخول الى حسابك أو قم بانشاء حساب جديد.',
                ),
                SizedBox(height: 40.v),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      PhoneTextfield(controller: _phoneController),
                      SizedBox(height: 40.v),
                      MaktabButton(
                        onPressed: () {
                          context
                              .read<AuthBloc>()
                              .add(ToggleMessageOptionsEvent());
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        backgroundColor: AppColors.lightCyan,
                        color: AppColors.white,
                        text: 'متابعة',
                      ),
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state.loginState == LoginStates.success) {
                            LoadingDialog.hide(context);
                            MaktabSnackbar.showSuccess(context, state.message);
                            context.pushNamed(AppRoutes.verifyCodeScreen);
                          } else if (state.loginState == LoginStates.failure) {
                            LoadingDialog.hide(context);
                            MaktabSnackbar.showError(context, state.message);
                          } else if (state.loginState == LoginStates.loading) {
                            LoadingDialog.show(context);
                          }
                        },
                        builder: (context, state) {
                          return Visibility(
                            visible: state.option == MessageOptionStetes.show
                                ? true
                                : false,
                            child: MessageOptionsCard(
                              buttons: [
                                OptionButton(
                                  text: 'WhatsApp',
                                  icon: Icons.phone,
                                  color: AppColors.emeraldGreen,
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<AuthBloc>().add(LoginEvent(
                                          _phoneController.text, 'whatsapp'));
                                    }
                                  },
                                ),
                                OptionButton(
                                  text: 'رسالة نصية',
                                  icon: Icons.message,
                                  color: AppColors.royalBlue,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {}
                                  },
                                ),
                              ],
                            ).animate().fade(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

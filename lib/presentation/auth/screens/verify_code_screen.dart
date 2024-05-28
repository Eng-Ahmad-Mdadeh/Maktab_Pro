// ignore_for_file: invalid_use_of_visible_for_testing_member, depend_on_referenced_packages, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/core/router/app_routes.dart';
import 'package:maktab/core/services/service_locator.dart';
import 'package:maktab/domain/auth/auth_bloc.dart';
import 'package:maktab/domain/home/home_bloc.dart';
import 'package:maktab/domain/offices/offices_cubit.dart';
import 'package:maktab/domain/receiving_method/receiving_method_bloc.dart';
import 'package:maktab/presentation/auth/widgets/code_text_field.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/loading_dialog.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab/presentation/widgets/maktab_button.dart';
import 'package:maktab/presentation/widgets/maktab_snack_bar.dart';
import 'package:maktab/presentation/widgets/page_title.dart';

import '../../../domain/profile/profile_bloc.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final TextEditingController _codeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //Timer? timer;
  int remainingSeconds = 120;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().startTimer();
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        print(state);
        if (state.loginState == LoginStates.failure) {
          MaktabSnackbar.showError(context, state.message);
        } else if (state.loginState == LoginStates.reLoading) {
          LoadingDialog.show(context);
        } else if (state.loginState == LoginStates.reSuccess) {
          LoadingDialog.hide(context);
          MaktabSnackbar.showSuccess(context, state.message);
        } else if (state.loginState == LoginStates.reFailed) {
          LoadingDialog.hide(context);
          MaktabSnackbar.showError(context, state.message);
        }
        if (state.codeState == CodeStates.loading) {
          LoadingDialog.show(context);
        } else if (state.codeState == CodeStates.success) {
          LoadingDialog.hide(context);
          MaktabSnackbar.showSuccess(context, state.message);
          context.read<AuthBloc>().add(CheckProfileEvent());
        } else if (state.codeState == CodeStates.failure) {
          LoadingDialog.hide(context);
          MaktabSnackbar.showError(context, state.message);
        }
        if (state.profileCompleteness == ProfileCompleteness.unComplete) {
          Navigator.popUntil(context, (route) => route.isFirst);
          context.pushReplacementNamed(AppRoutes.homeScreen);
          locator<ProfileBloc>().add(GetUserTypes());
          context.pushNamed(AppRoutes.editProfileScreen, extra: true);
        } else if (state.profileCompleteness == ProfileCompleteness.complete) {
          Navigator.popUntil(context, (route) => route.isFirst);
          context.pushReplacementNamed(AppRoutes.homeScreen);
          context
              .read<ReceivingMethodBloc>()
              .add(GetReceivingMoneyMethodEvent());
          context.read<OfficesCubit>().getIncompleteUnits();
          await context.read<OfficesCubit>().stream.firstWhere((state) =>
              state.incompleteUnitsApiCallState != OfficesApiCallState.loading);
          context.read<HomeBloc>().add(GetStatisticsEvent());
          await context.read<HomeBloc>().stream.firstWhere(
              (state) => state.homeApiCallState != HomeApiCallState.loading);

        } else if (state.profileCompleteness == ProfileCompleteness.unknown) {
          Navigator.popUntil(context, (route) => route.isFirst);
          context.pushReplacementNamed(AppRoutes.splashScreen);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: const MaktabAppBar(title: 'التحقق من رقم الموبايل'),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: SizeHelper.width,
                padding: EdgeInsets.symmetric(horizontal: 25.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.v),
                    const PageTitle(title: 'أدخل رقم رمز التحقق'),
                    SizedBox(height: 20.v),
                    const BodyText(
                      text:
                          'الرجاء إدخال رمز التحقق المكون من 4 أرقام المرسل إليك.',
                    ),
                    SizedBox(height: 40.v),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CodeTextField(controller: _codeController),
                          SizedBox(height: 40.v),
                          MaktabButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                      CheckCodeEvent(
                                        _codeController.text,
                                        context.read<AuthBloc>().state.phone,
                                      ),
                                    );
                              }
                            },
                            backgroundColor: AppColors.lightCyan,
                            color: AppColors.white,
                            text: 'التحقق',
                          ),
                          SizedBox(height: 30.v),
                          BodyText(
                            text: state.duration ~/ 60 > 0
                                ? "سيتم اعادة ارسال الكود بعد \n${state.duration ~/ 60}:${state.duration % 60} دقيقة"
                                : "سيتم اعادة ارسال الكود بعد \n${state.duration ~/ 60}:${state.duration % 60} ثانية",
                            textAlign: TextAlign.center,
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
      },
    );
  }
}

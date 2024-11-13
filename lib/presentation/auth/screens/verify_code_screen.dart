import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/core/router/app_routes.dart';
import 'package:maktab_lessor/core/services/service_locator.dart';
import 'package:maktab_lessor/domain/auth/auth_bloc.dart';
import 'package:maktab_lessor/domain/home/home_bloc.dart';
import 'package:maktab_lessor/domain/offices/offices_cubit.dart';
import 'package:maktab_lessor/domain/receiving_method/receiving_method_bloc.dart';
import 'package:maktab_lessor/presentation/auth/widgets/code_text_field.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/loading_dialog.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_snack_bar.dart';

import '../../../domain/notification/notification_bloc.dart';
import '../../../domain/profile/profile_bloc.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/retry_widget.dart';
import '../../widgets/section_title.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final TextEditingController _codeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late Timer _resendCodeTimer;
  int _timerDurationInSeconds = 120; // 2 minutes
  late StreamController<int> _timerController;

  @override
  void initState() {
    startResendCodeTimer();
    super.initState();
  }

  String _formatTime(int time) {
    return time < 10 ? '0$time' : '$time';
  }

  void startResendCodeTimer() {
    _timerController = StreamController<int>();
    _resendCodeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerDurationInSeconds > 0) {
        _timerDurationInSeconds--;
        _timerController.add(_timerDurationInSeconds);
      } else {
        timer.cancel();
        _timerDurationInSeconds = 120;
      }
    });
  }

  @override
  void dispose() {
    _resendCodeTimer.cancel();
    _timerController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
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

          context.read<ReceivingMethodBloc>().add(GetReceivingMoneyMethodEvent());
          context.read<OfficesCubit>().getIncompleteOffices();
          context.read<NotificationsBloc>().add(GetNotificationsEvent());

          await context
              .read<OfficesCubit>()
              .stream
              .firstWhere((state) => state.incompleteUnitsApiCallState != OfficesApiCallState.loading)
              .then((e) {
            if (context.mounted) {
              context.read<HomeBloc>().add(GetStatisticsEvent());
              context.read<HomeBloc>().stream.firstWhere((state) => state.homeApiCallState != HomeApiCallState.loading).then((e) {
                // context.pushReplacement(AppRoutes.homeScreen);
              });
            }
          });
        } else if (state.codeState == CodeStates.failure) {
          LoadingDialog.hide(context);
          MaktabSnackbar.showError(context, state.message);
        }
        if (state.profileCompleteness == ProfileCompleteness.unComplete) {
          if(context.mounted) {
            Navigator.popUntil(context, (route) => route.isFirst);
            context.pushReplacementNamed(AppRoutes.homeScreen);
            locator<ProfileBloc>().add(GetUserTypes());
            context.pushNamed(AppRoutes.editProfileScreen, extra: true);
          }

        } else if (state.profileCompleteness == ProfileCompleteness.complete) {
          if(context.mounted) {
            context.read<ReceivingMethodBloc>().add(GetReceivingMoneyMethodEvent());
            context.read<OfficesCubit>().getIncompleteUnits();
            context
                .read<OfficesCubit>()
                .stream
                .firstWhere((state) => state.incompleteUnitsApiCallState != OfficesApiCallState.loading)
                .then((e) {
              if (context.mounted) {
                context.read<HomeBloc>().add(GetStatisticsEvent());
                context.read<HomeBloc>().stream.firstWhere((state) => state.homeApiCallState != HomeApiCallState.loading).then((e) {
                  if (context.mounted) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    context.read<NotificationsBloc>().add(GetNotificationsEvent());
                    context.pushReplacementNamed(AppRoutes.homeScreen);
                  }
                });
              }
            });
          }

        } else if (state.profileCompleteness == ProfileCompleteness.unknown) {
          if (context.mounted) {
            Navigator.popUntil(context, (route) => route.isFirst);
            context.pushReplacementNamed(AppRoutes.splashScreen);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: const MaktabAppBar(
            title: 'التحقق من رقم الموبايل',
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: SizeHelper.width,
                padding: EdgeInsets.symmetric(horizontal: 25.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 100.v),
                    SectionTitle(
                      title: "يرجى ادخال رمز التحقق المرسل على هاتفك",
                      textColor: AppColors.black.withOpacity(.5),
                      overflow: TextOverflow.visible,
                      fontSize: 19,
                    ),
                    SectionTitle(
                      title: '0${state.phone}',
                      fontSize: 26,
                    ),
                    SizedBox(height: 40.v),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0.h),
                            child: CodeTextField(
                              controller: _codeController,
                              onCompleted: (value) {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                        CheckCodeEvent(
                                          _codeController.text,
                                          state.phone,
                                        ),
                                      );
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 40.v,
                          ),
                          StreamBuilder<int>(
                            stream: _timerController.stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                int minutes = snapshot.data! ~/ 60;
                                int seconds = snapshot.data! % 60;
                                bool isYellow = snapshot.data! < 60;

                                return state.codeState == CodeStates.loading
                                    ? const LoadingWidget(0)
                                    : Column(
                                        children: [
                                          if ((snapshot.data ?? 0) <= 0)
                                            RetryWidget(
                                              showText: false,
                                              iconColor: AppColors.black,
                                              onReload: () {
                                                if (_timerDurationInSeconds == 120) {
                                                  context.read<AuthBloc>().add(LoginEvent(
                                                        state.phone,
                                                      ));
                                                  startResendCodeTimer();
                                                }
                                              },
                                            )
                                          else
                                            SectionTitle(
                                              title: isYellow
                                                  ? '${_formatTime(minutes)}:${_formatTime(seconds)}'
                                                  : '${_formatTime(minutes)}:${_formatTime(seconds)}',
                                              textColor: isYellow ? AppColors.cherryRed : AppColors.mintGreen,
                                              fontSize: 26.0,
                                            ),
                                          InkWell(
                                            onTap: snapshot.data == 0
                                                ? () {
                                                    if (_timerDurationInSeconds == 120) {
                                                      context.read<AuthBloc>().add(LoginEvent(
                                                            state.phone,
                                                          ));
                                                      startResendCodeTimer();
                                                    }
                                                  }
                                                : null,
                                            child: SectionTitle(
                                              title: "ارسال رمز جديد",
                                              textAlign: TextAlign.right,
                                              textColor: snapshot.data == 0 ? AppColors.mintGreen : AppColors.softAsh,
                                              fontSize: 19.0,
                                            ),
                                          ),
                                        ],
                                      );
                              } else {
                                return const SizedBox();
                              }
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
      },
    );
  }
}

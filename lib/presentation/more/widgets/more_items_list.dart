import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/router/app_routes.dart';
import 'package:maktab/domain/offices/offices_cubit.dart';
import 'package:maktab/domain/user/user_bloc.dart';
import 'package:maktab/presentation/more/widgets/more_list_tile.dart';
import 'package:maktab/presentation/widgets/loading_dialog.dart';
import 'package:maktab/presentation/widgets/maktab_snack_bar.dart';

import '../../../domain/evaluation/evaluation_bloc.dart';

class MoreItemsList extends StatelessWidget {
  const MoreItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MoreListTile(
          title: 'الملف الشخصي',
          icon: FontAwesomeIcons.user,
          onTap: () => context.pushNamed(AppRoutes.editProfileScreen, extra: false),
        ),
        MoreListTile(
          title: 'التقويم',
          icon: FontAwesomeIcons.calendar,
          onTap: () => context.pushNamed(AppRoutes.calendarScreen),
        ),
        MoreListTile(
          title: 'المعاملات المالية',
          icon: FontAwesomeIcons.fileInvoiceDollar,
          onTap: () => context.pushNamed(AppRoutes.financialTransactionScreen),
        ),
        MoreListTile(
          title: 'العقود',
          icon: FontAwesomeIcons.fileInvoiceDollar,
          onTap: () => context.pushNamed(AppRoutes.contractsMenuScreen),
        ),
        MoreListTile(
          title: 'الفواتير',
          icon: FontAwesomeIcons.fileInvoice,
          onTap: () => context.pushNamed(AppRoutes.invoicesAndStatementsScreen),
        ),
        MoreListTile(
          title: 'الأسعار',
          icon: FontAwesomeIcons.sackDollar,
          onTap: () => context.pushNamed(AppRoutes.pricesScreen),
        ),
        MoreListTile(
          title: 'إعدادات الوحدة',
          icon: FontAwesomeIcons.gear,
          onTap: () => context.pushNamed(AppRoutes.unitSettingsScreen),
        ),
        BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state.userAgreementApiCallState == UserApiCallState.loading) {
              LoadingDialog.show(context);
            } else if (state.userAgreementApiCallState == UserApiCallState.success) {
              LoadingDialog.hide(context);
              context.pushNamed(AppRoutes.userAgreementScreen);
            } else if (state.userAgreementApiCallState == UserApiCallState.failure) {
              LoadingDialog.hide(context);
              MaktabSnackbar.showError(context, state.message);
            }
          },
          child: MoreListTile(
              title: 'اتفاقية الإستخدام ',
              icon: FontAwesomeIcons.fileCircleCheck,
              onTap: () {
                context.read<UserBloc>().add(GetUserAgreementEvent());
              }),
        ),
        MoreListTile(
          title: 'التقيمات',
          icon: FontAwesomeIcons.sackDollar,
          onTap: () {
            context.read<EvaluationBloc>().add(GetEvaluationsEvent());
            return context.pushNamed(AppRoutes.evaluationScreen);
          },
        ),
        BlocListener<OfficesCubit, OfficesState>(
          listener: (context, state) {
            if (state.complaintsApiCallState == OfficesApiCallState.loading) {
              LoadingDialog.show(context);
            } else if (state.complaintsApiCallState == OfficesApiCallState.update) {
              LoadingDialog.hide(context);
            } else if (state.complaintsApiCallState == OfficesApiCallState.success) {
              LoadingDialog.hide(context);
              context.pushNamed(AppRoutes.complaintsScreen);
            } else if (state.complaintsApiCallState == OfficesApiCallState.failure) {
              LoadingDialog.hide(context);
              MaktabSnackbar.showError(context, 'حدث خطأ ما');
            }
          },
          child: MoreListTile(
            title: 'الشكاوي',
            icon: FontAwesomeIcons.fileWaveform,
            onTap: () => context.read<OfficesCubit>().getComplaints(),
          ),
        ),
        MoreListTile(
          title: 'تواصل معنا',
          icon: FontAwesomeIcons.faceLaugh,
          onTap: () => context.pushNamed(AppRoutes.contactUsScreen),
        ),
      ],
    );
  }
}

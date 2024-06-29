import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/core/services/service_locator.dart';
import 'package:maktab_lessor/domain/national_access/national_access_bloc.dart';
import 'package:maktab_lessor/presentation/resources/app_assets.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/loading_dialog.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_image_view.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_snack_bar.dart';

class VerifyNationalAccessScreen extends StatefulWidget {
  const VerifyNationalAccessScreen({super.key});

  @override
  State<VerifyNationalAccessScreen> createState() => _VerifyNationalAccessScreenState();
}

class _VerifyNationalAccessScreenState extends State<VerifyNationalAccessScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator.get<NationalAccessBloc>(),
      child: BlocListener<NationalAccessBloc, NationalAccessState>(
        listener: (context, state) {
          if (state.verifyState == NationalAccessApiState.loading) {
            LoadingDialog.show(context);
          } else if (state.verifyState == NationalAccessApiState.success) {
            LoadingDialog.hide(context);
            context.pop();
            MaktabSnackbar.showSuccess(context, state.message);
          } else if (state.verifyState == NationalAccessApiState.failure) {
            LoadingDialog.hide(context);
            MaktabSnackbar.showError(context, state.message);
          }
        },
        child: Scaffold(
            appBar: const MaktabAppBar(title: 'توثيق الحساب بالنفاذ الوطني'),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaktabImageView(
                    imagePath: AppAssets.soonJpg,
                    width: 300.h,
                    height: 300.v,
                  ),
                  const BodyText(
                    text: "قريباً...",
                  ),
                ],
              ),
            )

            /*SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.v, vertical: 25.v),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle(title: 'نوع الحساب'),
                  SizedBox(height: 20.v),
                  BlocBuilder<NationalAccessBloc, NationalAccessState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          AccountTypeOptions(type: state.accountType),
                          SizedBox(height: 20.v),
                          AccountTypeNumberForm(type: state.accountType),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),*/
            ),
      ),
    );
  }
}

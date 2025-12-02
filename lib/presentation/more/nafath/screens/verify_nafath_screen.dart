import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/core/services/service_locator.dart';
import 'package:maktab_lessor/domain/nafath/request_status/request_status_bloc.dart';
import 'package:maktab_lessor/domain/nafath/request_status/request_status_event.dart';
import 'package:maktab_lessor/domain/nafath/request_status/request_status_state.dart';
import 'package:maktab_lessor/domain/profile/profile_bloc.dart';

import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/loading_widget.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_button.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_snack_bar.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';


class VerifyNafathScreen extends StatelessWidget {
  final String verify;

  const VerifyNafathScreen({super.key, required this.verify});

  @override
  Widget build(BuildContext context) {
    return  BodyVerifyNafathScreen(verify: verify);
  }
}

class BodyVerifyNafathScreen extends StatefulWidget {
  final String verify;

  const BodyVerifyNafathScreen({super.key, required this.verify});

  @override
  State<BodyVerifyNafathScreen> createState() => _BodyVerifyNafathScreenState();
}

class _BodyVerifyNafathScreenState extends State<BodyVerifyNafathScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<RequestStatusBloc, RequestStatusState>(
        listener: (context, state) {
          if (state is LoadingRequestStatusState) {
            showDialog(context: context, builder: (context) => const PopScope(canPop: false, child: LoadingWidget(0)));
          } else if (state is SuccessRequestStatusState) {
            context.pop();
            MaktabSnackbar.showSuccess(context, state.nafathModel!.message!);
            locator<ProfileBloc>().add(GetProfileEvent());

            if (state.nafathModel?.status == "COMPLETED") {
              context.pop();
              context.pop();
            } else if (state.nafathModel?.status == "WAITING") {
              context.pop();
              context.pop();
            } else if (state.nafathModel?.status == "EXPIRED") {
              context.pop();
            } else if (state.nafathModel?.status == "REJECTED") {
              context.pop();
            }
          } else if (state is FailureRequestStatusState) {
            context.pop();

            MaktabSnackbar.showError(context, state.message);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              BodyText(
                text: "نفاذ",
                fontSize: 45.fSize,
                fontWeight: FontWeight.bold,
                textColor: AppColors.mintTeal,
              ),
              BodyText(
                text: "النفاذ الوطني الموحد",
                fontSize: 25.fSize,
                textColor: AppColors.black2,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(height: 25.v),
              const Divider(color: AppColors.gray),
              SizedBox(height: 70.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: SectionTitle(
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.visible,
                  title: "الرجاء فتح تطبيق نفاذ وتأكيد الطلب بإختيار الرقم الظاهر",
                  fontSize: 20.fSize,
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 20.h),
                padding: EdgeInsets.only(top: 25.h),
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: AppColors.emeraldGreen,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: BodyText(
                 text:  widget.verify,
                  fontSize: 80.fSize,
                  textColor: AppColors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 40.v),
                child: MaktabButton(
                  height: 55.v,
                  borderRadius: BorderRadius.circular(5),
                  text: "تحقق",
                  isBordered: true,
                  color: AppColors.emeraldGreen,
                  borderColor: AppColors.emeraldGreen,
                  backgroundColor: AppColors.white,
                  width: SizeHelper.width,
                  onPressed: () {
                    context.read<RequestStatusBloc>().add(GetRequestStatusEvent());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

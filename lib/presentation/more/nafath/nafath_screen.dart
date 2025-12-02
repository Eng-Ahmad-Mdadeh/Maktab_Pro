import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/core/router/app_routes.dart';
import 'package:maktab_lessor/domain/nafath/send_request/send_request_bloc.dart';
import 'package:maktab_lessor/domain/nafath/send_request/send_request_event.dart';
import 'package:maktab_lessor/domain/nafath/send_request/send_request_state.dart';

import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/loading_widget.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_button.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_snack_bar.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_text_form_field.dart';
import 'package:maktab_lessor/presentation/widgets/page_title.dart';

class NafathScreen extends StatelessWidget {
  const NafathScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BodyNafathScreen();
  }
}

class BodyNafathScreen extends StatefulWidget {
  const BodyNafathScreen({super.key});

  @override
  State<BodyNafathScreen> createState() => _BodyNafathScreenState();
}

class _BodyNafathScreenState extends State<BodyNafathScreen> {
  TextEditingController idNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
      ),
      body: BlocListener<SendRequestBloc, SendRequestState>(
        listener: (context, state) {
          if (state is LoadingSendRequestState) {
            showDialog(context: context, builder: (context) => const PopScope(canPop: false, child: LoadingWidget(0)));
          } else if (state is SuccessSendRequestState) {
            context.pop();
            if (state.nafathModel?.message != null && state.nafathModel?.random == null) {
              MaktabSnackbar.showSuccess(context, state.nafathModel!.message!);
            } else if (state.nafathModel?.message != null && state.nafathModel?.random != null) {
              context.pushNamed(AppRoutes.verifyNafazScreen, extra: state.nafathModel?.random);
              MaktabSnackbar.showSuccess(context, state.nafathModel!.message!);
            }
          } else if (state is FailureSendRequestState) {
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
              PageTitle(
                title: "الدخول عبر تطبيق نفاذ",
                fontSize: 25.fSize,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 30.v),
                child: MaktabTextFormField(
                  title: "رقم الهوية",
                  controller: idNumberController,
                  textInputType: TextInputType.name,
                  hintText: "رقم الهوية",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "الرجاء إدخال رقم هوية صالح";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 40.v),
                child: MaktabButton(
                  height: 55.v,
                  borderRadius: BorderRadius.circular(5),
                  text: "تأكيد",
                  backgroundColor: AppColors.emeraldGreen,
                  width: SizeHelper.width,
                  onPressed: () {
                    final bloc = BlocProvider.of<SendRequestBloc>(context);
                    if (idNumberController.text != "" && !bloc.isClosed) {
                      bloc.add(GetSendRequestEvent(idNumberController.text));
                    }
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

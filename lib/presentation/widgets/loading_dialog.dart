
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/resources/app_assets.dart';

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) {
        if (context.mounted) {
          FocusScope.of(context).requestFocus(FocusNode());
        }
      });

  static void hide(BuildContext context) => Navigator.pop(context);

  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        //  alignment: AlignmentDirectional.center,
        color: Colors.transparent,
        padding: const EdgeInsets.all(5.0),
        child: Lottie.asset(
          AppAssets.loadingImage,
          alignment: AlignmentDirectional.center,
          height: 2.v,
          width: 2.v,
        ),
      ),
    );
  }
}

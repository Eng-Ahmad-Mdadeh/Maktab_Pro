import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/core/services/service_locator.dart';
import 'package:maktab_lessor/domain/profile/profile_bloc.dart';
import 'package:maktab_lessor/presentation/profile/widgets/account_information_form.dart';
import 'package:maktab_lessor/presentation/profile/widgets/account_type_options.dart';
import 'package:maktab_lessor/presentation/profile/widgets/upload_profile_image_box.dart';
import 'package:maktab_lessor/presentation/widgets/loading_dialog.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_snack_bar.dart';

class EditProfileScreen extends StatefulWidget {
  final bool fromHome;

  const EditProfileScreen({super.key, required this.fromHome});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    ProfileBloc bloc = BlocProvider.of<ProfileBloc>(context);
    if (context.read<ProfileBloc>().state.userTypes == null) {
      context.read<ProfileBloc>().add(GetUserTypes());
      log("here");
    }

    if (context.read<ProfileBloc>().state.userTypes == null) {
      context.read<ProfileBloc>().add(GetUserTypes());
    }
    if (bloc.state.user != null) {
      bloc.add(SelectAccountTypeEvent(
          index: bloc.getUserTypeAccountInd(bloc.state.user!)));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("Extra :${widget.fromHome}");
    return Scaffold(
      appBar: MaktabAppBar(
        title: widget.fromHome ? 'أكمل الملف الشخصي' : 'تعديل الملف الشخصي',
        leading: widget.fromHome ? const SizedBox() : null,
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (widget.fromHome) {
            MaktabSnackbar.showWarning(context, "الرجاء اكمال الملف الشخصي");
            return false;
          }
          return true;
        },
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state.profileState == ProfileStates.updated) {
              LoadingDialog.hide(context);
              MaktabSnackbar.showSuccess(context, state.message);
              locator<ProfileBloc>().add(GetProfileEvent());
              context.pop();
            } else if (state.profileState == ProfileStates.failToUpdate) {
              LoadingDialog.hide(context);
              MaktabSnackbar.showError(context, state.message);
            } else if (state.profileState == ProfileStates.loadingForEdit) {
              LoadingDialog.show(context);
            }
            if(state.profileState == ProfileStates.deleted){
              LoadingDialog.hide(context);
              MaktabSnackbar.showError(context, state.message);
            }
            // else if (state.bigImage == true) {
            //   MaktabSnackbar.showError(context, 'حجم الصورة كبير');
            // }
          },
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const UploadProfileImageBox(),
                    SizedBox(height: 25.v),
                    const AccountTypeOptions(),
                    SizedBox(height: 25.v),
                    const AccountInformationForm(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

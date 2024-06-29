import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/core/router/app_routes.dart';
import 'package:maktab_lessor/domain/profile/profile_bloc.dart';
import 'package:maktab_lessor/presentation/resources/app_assets.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/loading_dialog.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_image_view.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_snack_bar.dart';
import 'package:maktab_lessor/presentation/widgets/shimmer_effect.dart';

class MoreHeader extends StatelessWidget {
  const MoreHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.logOutStates == LogOutStates.loading) {
          LoadingDialog.show(context);
        } else if (state.logOutStates == LogOutStates.success) {
          LoadingDialog.hide(context);
          Navigator.popUntil(context, (route) => route.isFirst);
          context.pushReplacementNamed(AppRoutes.introScreen);
        } else if (state.logOutStates == LogOutStates.failure) {
          LoadingDialog.hide(context);
          MaktabSnackbar.showError(context, state.message);
        }
      },
      builder: (context, state) {
        return ShimmerEffect(
          isLoading: state.profileState == ProfileStates.loading,
          child: Container(
            color: AppColors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.v, horizontal: 25.h),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30.adaptSize,
                          backgroundColor: AppColors.white,
                          child: MaktabImageView(
                            imagePath:
                                state.profileState == ProfileStates.success
                                    ? (state.user?.image??'').isNotEmpty
                                        ? state.user!.image!
                                        : AppAssets.profile
                                    : AppAssets.profile,
                            height: 70.h,
                            width: 70.v,
                          ),
                        ),
                        SizedBox(width: 20.h),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BodyText(
                                  text: state.profileState ==
                                          ProfileStates.success
                                      ? state.user!.userName.toString()
                                      : '',
                                  textColor: AppColors.lightBlack,
                                ),
                                SizedBox(height: 5.v),
                                BodyText(
                                  text: state.profileState ==
                                          ProfileStates.success
                                      ? state.user!.phone
                                      : '',
                                  textColor: AppColors.lightBlack,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        context.read<ProfileBloc>().add(LogOutEvent()),
                    icon: Icon(
                      Icons.logout,
                      color: AppColors.cherryRed,
                      size: 35.adaptSize,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

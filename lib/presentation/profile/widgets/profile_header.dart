import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/domain/profile/profile_bloc.dart';
import 'package:maktab_lessor/presentation/resources/app_assets.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_image_view.dart';
import 'package:maktab_lessor/presentation/widgets/shimmer_effect.dart';

import '../../widgets/section_title.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return ShimmerEffect(
          isLoading: state.profileState == ProfileStates.loading,
          child: Container(
            width: SizeHelper.width,
            padding: EdgeInsets.symmetric(vertical: 20.v),
            color: AppColors.lightBlack,
            child: Column(
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: AppColors.white,
                      child: MaktabImageView(
                        imagePath: state.profileState == ProfileStates.success
                            ? (state.user?.image??'').isNotEmpty
                                ? state.user!.image!
                                : AppAssets.profile
                            : AppAssets.profile,
                        height: 70.adaptSize,
                        width: 70.adaptSize,
                        fit: BoxFit.cover,
                        radius: BorderRadius.circular(35),
                      ),
                    ),
                    SizedBox(height: 6.v),
                    SectionTitle(
                      title:
                      state.profileState == ProfileStates.success
                          ? state.user!.userName.toString()
                          : '',textColor: AppColors.white

                    ),
                    SizedBox(height: 15.v),
                    SectionTitle(
                      title:
                      state.profileState == ProfileStates.success
                          ? state.user!.email.toString()
                          : '',textColor: AppColors.white

                    ),
                    SizedBox(height: 5.v),
                    SectionTitle(
                      title:
                      state.profileState == ProfileStates.success
                          ? state.user!.phone.toString()
                          : '',textColor: AppColors.white

                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

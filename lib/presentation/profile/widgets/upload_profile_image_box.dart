import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/domain/profile/profile_bloc.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_image_view.dart';

class UploadProfileImageBox extends StatefulWidget {
  const UploadProfileImageBox({super.key});

  @override
  State<UploadProfileImageBox> createState() => _UploadProfileImageBoxState();
}

class _UploadProfileImageBoxState extends State<UploadProfileImageBox> {
  String pickedImage = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return SizedBox(
          width: SizeHelper.width,
          child: Column(
            children: [
              InkWell(
                splashColor: Colors.transparent,
                onTap: () async {
                  context
                      .read<ProfileBloc>()
                      .add(PickImageEvent(imagePath: pickedImage));
                },
                child: DottedBorder(
                  borderType: BorderType.Circle,
                  dashPattern: const [4, 1],
                  color: AppColors.slateGray,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: (state.user?.image == null ||
                                state.user?.image == '') &&
                            state.pickedImage == ''
                        ? CircleAvatar(
                            radius: 60,
                            backgroundColor: AppColors.white,
                            child: Center(
                              child: Text(
                                'إضافة صورة',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      color: AppColors.slateGray,
                                    ),
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: 60,
                            backgroundColor: AppColors.white,
                            child: MaktabImageView(
                              radius: BorderRadius.circular(60),
                              height: 200.adaptSize,
                              width: 200.adaptSize,
                              imagePath: state.pickedImage != '' ? state.pickedImage : (state.user?.image??''),
                              fit: BoxFit.fill,
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(height: 20.v),
              Text(
                'رفع صورة الشعار',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: AppColors.slateGray,
                    ),
              ),
              SizedBox(height: 10.v),
              Text(
                'صورة الشعار لا تتجاوز 1MB',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: AppColors.cherryRed,
                    ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/domain/unit/unit_bloc.dart';
import 'package:maktab/presentation/office/widgets/delete_media_icon_button.delete.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/file_selector_box.dart';
import 'package:maktab/presentation/widgets/maktab_icon_item.dart';
import 'package:maktab/presentation/widgets/maktab_image_view.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class UnitMainImageSection extends StatelessWidget {
  const UnitMainImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'صور العرض الرئيسية'),
        SizedBox(height: 10.v),
        BlocBuilder<UnitBloc, UnitState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BodyText(
                  text: 'مطلوب صورة',
                  textColor: state.isMainImageSelected
                      ? AppColors.slateGray
                      : AppColors.cherryRed,
                ),
                SizedBox(height: 10.v),
                FileSelectorBox(
                  title: 'أضف الصور',
                  height: 200.v,
                  width: SizeHelper.width,
                  icon: Icons.photo_camera_back_outlined,
                  fileWidget: state.mainImage.isNotEmpty ||
                          state.selectedMainImage.isNotEmpty
                      ? Stack(
                          children: [
                            MaktabImageView(
                              imagePath: state.selectedMainImage.isNotEmpty
                                  ? state.selectedMainImage
                                  : state.mainImage,
                              width: SizeHelper.width,
                              height: 200.v,
                              radius: BorderRadius.circular(15.fSize),
                            ),
                            DeleteMediaIconButton(onTap: () {
                              context
                                  .read<UnitBloc>()
                                  .add(DeleteOfficeMainImageEvent());
                            }),
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.fSize),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.h, vertical: 10.v),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.lightBlack, width: 2),
                                  ),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
                                    child: const MaktabIconItem(
                                      title: 'تعديل صورة العرض الرئيسية',
                                      color: AppColors.cherryRed,
                                      icon: Icons.photo_camera_back_outlined,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : null,
                  onTap: () async {
                    context.read<UnitBloc>().add(PickOfficeMainImageEvent());
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

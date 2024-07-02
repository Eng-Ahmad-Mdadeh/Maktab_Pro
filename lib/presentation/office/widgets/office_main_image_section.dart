import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/domain/office/office_bloc.dart';
import 'package:maktab_lessor/presentation/office/widgets/delete_media_icon_button.delete.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/file_selector_box.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_icon_item.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_image_view.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class OfficeMainImageSection extends StatelessWidget {
  const OfficeMainImageSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'صور العرض الرئيسية'),
        SizedBox(height: 10.v),
        BlocBuilder<OfficeBloc, OfficeState>(
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
                  fileWidget: state.selectedMainImage.isNotEmpty
                      ? Stack(
                          children: [
                            MaktabImageView(
                              imagePath: state.selectedMainImage,
                              width: SizeHelper.width,
                              radius: BorderRadius.circular(15.fSize),
                            ),
                            DeleteMediaIconButton(onTap: () {
                              context
                                  .read<OfficeBloc>()
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
                    context.read<OfficeBloc>().add(PickOfficeMainImageEvent());
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

import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/office/widgets/delete_media_icon_button.delete.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/file_selector_box.dart';
import 'package:maktab/presentation/widgets/maktab_image_view.dart';

class OfficeImageSelector extends StatelessWidget {
  const OfficeImageSelector({
    super.key,
    this.height,
    this.width,
    required this.image,
    this.imageNumber,
    required this.selectImageOnTap,
    required this.clearImageOnTap,
  });

  final double? height;
  final double? width;
  final String image;
  final int? imageNumber;
  final Function() selectImageOnTap;
  final Function() clearImageOnTap;

  @override
  Widget build(BuildContext context) {
    return FileSelectorBox(
      title: 'أضف الصور',
      height: height ?? 200.v,
      width: width ?? SizeHelper.width,
      icon: Icons.photo_camera_back_outlined,
      fileWidget: image.isNotEmpty
          ? Stack(
              children: [
                MaktabImageView(
                  imagePath: image,
                  width: width ?? SizeHelper.width,
                  height: height ?? 200.v,
                  radius: BorderRadius.circular(15.fSize),
                  fit: BoxFit.cover,
                ),
                DeleteMediaIconButton(onTap: clearImageOnTap),
                Positioned(
                  left: 0,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.h, vertical: 7.v),
                    decoration: BoxDecoration(
                      color: AppColors.smokeGray,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.fSize),
                        bottomRight: Radius.circular(15.fSize),
                      ),
                    ),
                    child: BodyText(
                      text: imageNumber.toString(),
                      textColor: AppColors.white,
                    ),
                  ),
                ),
              ],
            )
          : null,
      onTap: selectImageOnTap,
    );
  }
}

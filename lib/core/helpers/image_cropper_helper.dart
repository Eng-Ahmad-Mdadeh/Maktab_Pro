import 'dart:developer';
import 'package:image_cropper/image_cropper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

class ImageCropperHelper {
  static final ImageCropper _imageCropper = ImageCropper();

  static ImageCropper get imageCropper => _imageCropper;

  static Future<String?> cropImage({required String selectedImage}) async {
    try {
      CroppedFile? croppedFile = await imageCropper.cropImage(
        sourcePath: selectedImage,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'قص وحفظ المحدد',
            toolbarColor: AppColors.softAsh,
            toolbarWidgetColor: AppColors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            cropFrameColor: AppColors.lightCyan,
            showCropGrid: false,
            lockAspectRatio: false,
            hideBottomControls: true,
          ),
        ],
      );
      return croppedFile!.path;
    } catch (e) {
      log('Error cropping image: $e');
      return null;
    }
  }
}

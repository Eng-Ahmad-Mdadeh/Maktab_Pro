// import 'dart:developer';
//
// import 'package:image_picker/image_picker.dart';
//
// class ImagePickerHelper {
//   final ImagePicker picker = ImagePicker();
//   List<XFile> selectedImages = [];
//   XFile? selectedImage;
//   XFile? selectedVideo;
//   List<String> imagePaths = [];
//
//   Future<List<String>> pickImages() async {
//     selectedImages = await picker.pickMultiImage();
//     for (XFile file in selectedImages) {
//       imagePaths.add(file.path);
//     }
//     return imagePaths;
//   }
//
//   Future<String> pickImage({int? maxFileSizeInBytes }) async {
//     try {
//       selectedImage = await picker.pickImage(source: ImageSource.gallery);
//       if (selectedImage != null) {
//         if(maxFileSizeInBytes!=null){
//           var imagePath = await selectedImage!.readAsBytes();
//
//           var fileSize = imagePath.length; // Get the file size in bytes
//           log('${fileSize} BYTE');
//           if (fileSize <= maxFileSizeInBytes) {
//             return selectedImage!.path;
//           } else {
//             return 'حجم الصورة اكبر من $maxFileSizeInBytesميغا ';
//           }
//         }
//         return selectedImage!.path;
//       }
//     } catch (e) {
//       return '';
//     }
//     return '';
//   }
//
//   Future<String> pickVideo({Duration? maxDuration}) async {
//     try {
//       selectedVideo = await picker.pickVideo(
//         source: ImageSource.gallery,
//         maxDuration: maxDuration,
//       );
//       if (selectedVideo != null) {
//         return selectedVideo!.path;
//       }
//     } catch (e) {
//       return '';
//     }
//     return '';
//   }
// }

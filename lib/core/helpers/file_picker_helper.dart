import 'dart:developer';
import 'package:file_picker/file_picker.dart';

class FilePickerHelper {
  Future<String?> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
      );
      if (result != null) {
        var fileSize = result.files.single.size;
        log('$fileSize BYTE');
        if (fileSize <= 3000000) {
          return result.files.single.path!;
        } else {
          return null;
        }
      }
    } catch (e) {
      return null;
    }
    return '';
  }

  Future<String?> pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        withData: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
      );
      if (result != null) {
        var fileSize = result.files.single.bytes!.length;
        log('$fileSize BYTE');
        if (fileSize <= 2000000) {
          return result.files.single.path!;
        } else {
          return '';
        }
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<String> pickVideo() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
      );
      if (result != null) {
        return result.files.single.path!;
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }
}

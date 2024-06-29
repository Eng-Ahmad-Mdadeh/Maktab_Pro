import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_image_view.dart';

import '../../../../../../../../../core/helpers/size_helper.dart';
import '../../../../../../../../resources/app_colors.dart';

class ContractImageWidget extends StatelessWidget {
  final Function(String) onImageSelected;
  final String? selectedPath;

  const ContractImageWidget({
    super.key,
    required this.onImageSelected,
    this.selectedPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeHelper.width,
      height: 200.0.v,
      margin: EdgeInsets.all(14.0.adaptSize),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(5.0.adaptSize),
        border: Border.all(
          color: AppColors.mintGreen,
        ),
      ),
      child: IconButton(
        icon: selectedPath == null
            ? const Icon(Icons.image)
            : MaktabImageView(
                imagePath: selectedPath!,
              ),
        iconSize: 70.0.adaptSize,
        color: AppColors.mintGreen,
        onPressed: () async {
          final FilePicker picker = FilePicker.platform;
          final file = await picker.pickFiles(allowMultiple: false);
          if (file != null) {
            onImageSelected(file.paths.first!);
          }
        },
      ),
    );
  }
}

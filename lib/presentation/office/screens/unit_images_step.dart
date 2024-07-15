import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/domain/unit/unit_bloc.dart';
import 'package:maktab_lessor/presentation/office/widgets/offices_sub_images_section.dart';
import 'package:maktab_lessor/presentation/office/widgets/unit_main_image_section.dart';
import 'package:maktab_lessor/presentation/office/widgets/unit_video_section.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_snack_bar.dart';
import 'package:maktab_lessor/presentation/widgets/page_title.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class UnitImagesStep extends StatefulWidget {
  const UnitImagesStep({super.key});

  @override
  State<UnitImagesStep> createState() => _UnitImagesStepState();
}

class _UnitImagesStepState extends State<UnitImagesStep> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocListener<UnitBloc, UnitState>(
        listener: (context, state) {
          if (state.imagesErrorMessage.isNotEmpty) {
            MaktabSnackbar.showError(context, state.imagesErrorMessage);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageTitle(title: 'صور المكتب'),
            SizedBox(height: 30.v),
            const SectionTitle(
              title: 'حتى تعرض مكتبك بنجاح',
              textColor: AppColors.smokeGray,
            ),
            SizedBox(height: 15.v),
            const BodyText(text: 'أضف ما لا يقل عن 4 صور واضحة و جذابة للوحدة'),
            SizedBox(height: 15.v),
            const BodyText(text: 'يمنع وضع شعار أو كلمات على الصورة'),
            SizedBox(height: 20.v),
            const UnitVideoSection(),
            SizedBox(height: 20.v),
            const UnitMainImageSection(),
            SizedBox(height: 20.v),
            const UnitSubImagesSection(),
          ],
        ),
      ),
    );
  }
}

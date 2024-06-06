import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/office/office_file.dart';
import 'package:maktab/domain/unit/unit_bloc.dart';
import 'package:maktab/presentation/office/widgets/office_image_selector.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

import '../../resources/app_colors.dart';

class UnitSubImagesSection extends StatelessWidget {
  const UnitSubImagesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'صور المكتب'),
        SizedBox(height: 10.v),
        BlocBuilder<UnitBloc, UnitState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BodyText(
                  text: 'مطلوب أربع صور على الأقل',
                  textColor: state.selectedImagesCount < 4 &&
                          state.selectedImagesCount > -1
                      ? AppColors.cherryRed
                      : AppColors.slateGray,
                ),
                SizedBox(height: 10.v),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.v,
                  childAspectRatio: 1.5,
                  children: [
                    OfficeImageSelector(
                      image: '',
                      selectImageOnTap: () {
                        context.read<UnitBloc>().add(PickOfficeImageEvent());
                      },
                      clearImageOnTap: () {},
                    ),
                    ...state.selectedImagesMap.keys
                        .mapIndexed(
                          (index, key) => OfficeImageSelector(
                            key: key,
                            image: OfficeFile.isLocal(
                                    state.selectedImagesMap[key]!,
                                    state.createdUnit!.files)
                                ? state.selectedImagesMap[key]!
                                : 'https://maktab.sa/${state.selectedImagesMap[key]!}',
                            imageNumber: index + 1,
                            selectImageOnTap: () {},
                            clearImageOnTap: () {
                              context
                                  .read<UnitBloc>()
                                  .add(DeleteOfficeImageEvent(key));
                            },
                          ),
                        )
                        .toList(),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

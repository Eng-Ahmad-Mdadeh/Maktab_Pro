import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/domain/unit/unit_bloc.dart';
import 'package:maktab_lessor/presentation/office/widgets/office_image_selector.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

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
                            image: state.selectedImagesMap[key]!,
                            imageNumber: index + 1,
                            selectImageOnTap: () {},
                            clearImageOnTap: () {
                              context
                                  .read<UnitBloc>()
                                  .add(DeleteOfficeImageEvent(key));
                            },
                          ),
                        )
                        ,
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

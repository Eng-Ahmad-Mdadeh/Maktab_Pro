import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/domain/offices/offices_cubit.dart';
import 'package:maktab/domain/unit/unit_bloc.dart';
import 'package:maktab/presentation/office/widgets/delete_media_icon_button.delete.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/file_selector_box.dart';
import 'package:maktab/presentation/widgets/maktab_video_player.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class UnitVideoSection extends StatelessWidget {
  const UnitVideoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'فيديو'),
        SizedBox(height: 10.v),
        const BodyText(text: 'عدد الثواني المسموح بها 30 ثانية'),
        SizedBox(height: 10.v),
        BlocBuilder<UnitBloc, UnitState>(
          builder: (context, state) {
            return FileSelectorBox(
              title: 'أضف فيديو',
              height: 200.v,
              icon: Icons.video_call,
              fileWidget: context
                          .read<UnitBloc>()
                          .state
                          .selectedVideo
                          .isNotEmpty ||
                      state.videoPath.isNotEmpty
                  ? Stack(
                      children: [
                        MaktabVideoPlayer(
                          videoFile: state.selectedVideo,
                          videoLink: context
                                      .read<OfficesCubit>()
                                      .state
                                      .selectedOffice!
                                      .files
                                      .firstWhereOrNull(
                                          (file) => file.typeFile == 'video') !=
                                  null
                              ? context
                                  .read<OfficesCubit>()
                                  .state
                                  .selectedOffice!
                                  .files
                                  .firstWhereOrNull(
                                      (file) => file.typeFile == 'video')!
                                  .path
                              : '',
                        ),
                        DeleteMediaIconButton(onTap: () {
                          context
                              .read<UnitBloc>()
                              .add(DeleteOfficeVideoEvent());
                        }),
                      ],
                    )
                  : null,
              onTap: () {
                context.read<UnitBloc>().add(PickOfficeVideoEvent());
              },
            );
          },
        ),
      ],
    );
  }
}

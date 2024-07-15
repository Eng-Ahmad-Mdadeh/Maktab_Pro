import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/domain/office/office_bloc.dart';
import 'package:maktab_lessor/presentation/office/widgets/delete_media_icon_button.delete.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/file_selector_box.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_video_player.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class OfficeVideoSection extends StatelessWidget {
  const OfficeVideoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'فيديو'),
        SizedBox(height: 10.v),
        const BodyText(text: 'عدد الثواني المسموح بها 30 ثانية'),
        SizedBox(height: 10.v),
        BlocBuilder<OfficeBloc, OfficeState>(
          builder: (context, state) {
            return FileSelectorBox(
              title: 'أضف فيديو',
              height: 200.v,
              icon: Icons.video_call,
              fileWidget: context
                      .read<OfficeBloc>()
                      .state
                      .selectedVideo
                      .isNotEmpty
                  ? Stack(
                      children: [
                        MaktabVideoPlayer(
                            videoFile:
                                context.read<OfficeBloc>().state.selectedVideo),
                        DeleteMediaIconButton(onTap: () {
                          context
                              .read<OfficeBloc>()
                              .add(DeleteOfficeVideoEvent());
                        }),
                      ],
                    )
                  : null,
              onTap: () {
                context.read<OfficeBloc>().add(PickOfficeVideoEvent());
              },
            );
          },
        ),
      ],
    );
  }
}

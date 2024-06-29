import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/domain/office/office_bloc.dart';
import 'package:maktab_lessor/presentation/office/widgets/additional_service_form.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_button.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class OfficeAddtitionalServicesSection extends StatefulWidget {
  const OfficeAddtitionalServicesSection({super.key});

  @override
  State<OfficeAddtitionalServicesSection> createState() =>
      _OfficeAddtitionalServicesSectionState();
}

class _OfficeAddtitionalServicesSectionState
    extends State<OfficeAddtitionalServicesSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'خدمات إضافية',
          textFontWeight: FontWeight.w500,
        ),
        SizedBox(height: 20.v),
        BlocBuilder<OfficeBloc, OfficeState>(
          builder: (context, state) {
            return Column(
              children: [
                ...state.additionalServiceKeys.keys.mapIndexed(
                  (index, key) => AdditionalServiceForm(key: key),
                ),
              ],
            );
          },
        ),
        SizedBox(height: 20.v),
        MaktabButton(
          width: 80.h,
          height: 60.v,
          backgroundColor: AppColors.mintTeal,
          icon: Icon(
            FontAwesomeIcons.plus,
            color: AppColors.white,
            size: 25.fSize,
          ),
          onPressed: () {
            context.read<OfficeBloc>().add(AddAddtionalServiceEvent());
          },
        ),
      ],
    );
  }
}

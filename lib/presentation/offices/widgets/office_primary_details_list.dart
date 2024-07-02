// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/offices/widgets/office_details_box.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class OfficePrimaryDetailsList extends StatelessWidget {
  const OfficePrimaryDetailsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'المعلومات الأساسية'),
        SizedBox(height: 15.v),
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const OfficeDetailsBox(),
            SizedBox(height: 15.v),
            const OfficeDetailsBox(),
            SizedBox(height: 15.v),
            const OfficeDetailsBox(),
          ],
        ),
      ],
    );
  }
}

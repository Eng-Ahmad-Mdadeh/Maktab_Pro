import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_google_map.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_map_search_text_form_field.dart';
import 'package:maktab_lessor/presentation/widgets/page_title.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class OfficeAddressStep extends StatefulWidget {
  const OfficeAddressStep({super.key});

  @override
  State<OfficeAddressStep> createState() => _OfficeAddressStepState();
}

class _OfficeAddressStepState extends State<OfficeAddressStep> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageTitle(title: 'عنوان المكان والخدمة'),
          SizedBox(height: 30.v),
          const SectionTitle(
            title: 'يرجى تحديد موقع المكان والخدمة',
            textFontWeight: FontWeight.w500,
          ),
          SizedBox(height: 20.v),
          const MaktabMapSearchTextField(),
          SizedBox(height: 20.v),
          const MaktabGoogleMap(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/widgets/maktab_google_map.dart';
import 'package:maktab/presentation/widgets/maktab_map_search_text_form_field.dart';
import 'package:maktab/presentation/widgets/page_title.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

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
          const PageTitle(title: 'عنوان المكتب'),
          SizedBox(height: 30.v),
          const SectionTitle(
            title: 'يرجى تحديد موقع المكتب',
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

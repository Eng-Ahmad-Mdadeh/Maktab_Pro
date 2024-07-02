import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/offices/widgets/office_info_card.dart';
import 'package:maktab_lessor/presentation/offices/widgets/office_primary_details_list.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class OfficeScreen extends StatefulWidget {
  const OfficeScreen({super.key});

  @override
  State<OfficeScreen> createState() => _OfficeScreenState();
}

class _OfficeScreenState extends State<OfficeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MaktabAppBar(title: '22334495'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                  title: 'قم باستكمال البيانات المطلوبة ليتم عرض عقارك'),
              SizedBox(height: 20.v),
              const OfficeInfoCard(),
              SizedBox(height: 20.v),
              const OfficePrimaryDetailsList(),
            ],
          ),
        ),
      ),
    );
  }
}

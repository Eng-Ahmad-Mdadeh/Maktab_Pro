// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/widgets/page_title.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class StatementHeader extends StatelessWidget {
  const StatementHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageTitle(title: 'كشف حساب شهر ديسمبر 2023'),
          SizedBox(height: 5.v),
          const SectionTitle(title: 'من 1 ديسمبر 2023 الى 2 ديسمبر 2024'),
        ],
      ),
    );
  }
}

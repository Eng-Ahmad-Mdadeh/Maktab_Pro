// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';

import 'body_text.dart';
import 'section_title.dart';

class CountryCode extends StatelessWidget {
  const CountryCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SectionTitle(
            title:
            '966+',
            textAlign: TextAlign.center,
            fontSize: 26.0,
          ),
          SizedBox(width: 10.h),
          BodyText(
            text:
            '🇸🇦',fontSize: 40.fSize
          ),
        ],
      ),
    );
  }
}

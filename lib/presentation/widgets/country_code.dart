
import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';

import 'body_text.dart';
import 'section_title.dart';

class CountryCode extends StatelessWidget {
  final double? size;
  const CountryCode({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SectionTitle(
            title: '966+',
            textAlign: TextAlign.center,
            fontSize: size == null ? 19.0 : (size!/2),
          ),
          SizedBox(width: 10.h),
          BodyText(
            text: '🇸🇦',
            fontSize: size ?? 38.0,
          ),
        ],
      ),
    );
  }
}

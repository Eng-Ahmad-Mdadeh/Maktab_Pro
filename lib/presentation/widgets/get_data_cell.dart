
import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';

DataCell getDataCell({required String text, required Color textColor}) {
  return DataCell(
    Padding(
      padding: EdgeInsets.symmetric(vertical: 10.v),
      child: BodyText(
        text: text,
        textColor: textColor,
      ),
    ),
  );
}

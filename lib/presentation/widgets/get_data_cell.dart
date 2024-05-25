// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/widgets/body_text.dart';

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

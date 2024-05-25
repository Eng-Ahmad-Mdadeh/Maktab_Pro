// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';

class ColoredCircle extends StatelessWidget {
  const ColoredCircle({
    super.key,
    required this.color,
    this.width,
    this.height,
  });

  final Color color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 20.h,
      height: height ?? 20.v,
      decoration: ShapeDecoration(
        color: color,
        shape: const CircleBorder(),
      ),
    );
  }
}

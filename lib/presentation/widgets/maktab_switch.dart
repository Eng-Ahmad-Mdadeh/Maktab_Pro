
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/app_colors.dart';

class MaktabSwitch extends StatelessWidget {
  const MaktabSwitch({
    super.key,
    required this.value,
    this.activeColor,
    this.activeTrackColor,
    this.trackColor,
    this.inActiveThumbColor,
    this.theme,
    required this.onChanged,
  });

  final bool value;
  final Color? activeColor;
  final Color? activeTrackColor;
  final Color? trackColor;
  final Color? inActiveThumbColor;
  final ThemeData? theme;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    if(Platform.isIOS){
      return Theme(
        data: theme != null ? theme! : Theme.of(context),
        child: CupertinoSwitch(
          value: value,
          onChanged: onChanged,
          activeColor: activeColor ?? AppColors.emeraldGreen,
        ),
      );
    }
    return Theme(
      data: theme != null ? theme! : Theme.of(context),
      child: Switch.adaptive(
        value: value,
        activeColor: activeColor ?? AppColors.emeraldGreen,
        activeTrackColor: activeTrackColor ?? AppColors.white,
        trackColor: WidgetStatePropertyAll(trackColor),
        inactiveThumbColor: inActiveThumbColor,
        trackOutlineColor: WidgetStatePropertyAll(trackColor),
        trackOutlineWidth: const WidgetStatePropertyAll(0),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onChanged: onChanged,
      ),
    );
  }
}

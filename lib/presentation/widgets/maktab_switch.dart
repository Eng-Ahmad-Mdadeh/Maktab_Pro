// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';

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
    return Theme(
      data: theme != null ? theme! : Theme.of(context),
      child: Switch.adaptive(
        value: value,
        activeColor: activeColor,
        activeTrackColor: activeTrackColor,
        trackColor: MaterialStatePropertyAll(trackColor),
        inactiveThumbColor: inActiveThumbColor,
        trackOutlineColor: MaterialStatePropertyAll(trackColor),
        trackOutlineWidth: const MaterialStatePropertyAll(0),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onChanged: onChanged,
      ),
    );
  }
}

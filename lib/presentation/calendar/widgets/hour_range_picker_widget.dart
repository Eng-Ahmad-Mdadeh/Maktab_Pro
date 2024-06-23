import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';
import '../../widgets/body_text.dart';

class HourRangePickerWidget extends StatefulWidget {
  final int? startHour;
  final int? endHour;
  final Iterable<int> blockedHours;
  final Function(int?, int?) onHourRangeChanged;

  const HourRangePickerWidget({
    super.key,
    required this.startHour,
    required this.endHour,
    required this.onHourRangeChanged,
    required this.blockedHours,
  });

  @override
  State<HourRangePickerWidget> createState() => _EmbeddedHourRangePickerState();
}

class _EmbeddedHourRangePickerState extends State<HourRangePickerWidget> {
  int? _dragStart;
  int? _dragEnd;

  void _onHourTapped(int hour) {
    setState(() {
      if (_dragStart == null || (_dragStart != null && _dragEnd != null)) {
        _dragStart = hour;
        _dragEnd = null;
        widget.onHourRangeChanged(_dragStart, _dragEnd);
      } else {
        _dragEnd = hour;
        if (_dragStart! > _dragEnd!) {
          final temp = _dragStart;
          _dragStart = _dragEnd;
          _dragEnd = temp;
        }
        widget.onHourRangeChanged(_dragStart, _dragEnd);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
        childAspectRatio: 3 / 1,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 24,
      itemBuilder: (context, index) {
        final isSelected = (widget.startHour != null && index == widget.startHour!) ||
            (widget.startHour != null && widget.endHour != null && index >= widget.startHour! && index <= widget.endHour!);
        return GestureDetector(
          onTap: () => _onHourTapped(index),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: widget.blockedHours.contains(index)
                  ? isSelected
                  ? AppColors.mintGreen.withOpacity(.5)
                  : AppColors.gray
                  : isSelected
                  ? AppColors.mintGreen
                  : AppColors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  blurRadius: 9,
                  spreadRadius: 1,
                )
              ]
              // border: Border.all(
              //   color: widget.blockedHours.contains(index)
              //       ? AppColors.gray
              //       : isSelected
              //       ? AppColors.mintGreen
              //       : AppColors.softAsh,
              //   width: 2,
              // ),
            ),
            child: BodyText(
              text: '${index.toString().padLeft(2, '0')}:00',
              textColor: widget.blockedHours.contains(index)
                  ? AppColors.white
                  : isSelected
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

extension DateTimeExtension on DateTimeRange {
  bool isRangeOutRange(DateTime startDate, DateTime endDate) {
    return start.isBefore(startDate) && end.isBefore(startDate) ||
        start.isAfter(endDate) && end.isAfter(endDate);
  }
}

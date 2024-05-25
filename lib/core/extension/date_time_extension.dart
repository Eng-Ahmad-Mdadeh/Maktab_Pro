import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

extension DateTimeExtension on DateTime {
  bool isInRangeWithSameMoment(DateTime? startDate, DateTime? endDate) {
    return isAfter(startDate!) && isBefore(endDate!) ||
        isAtSameMomentAs(startDate) ||
        isAtSameMomentAs(endDate!);
  }

  bool isInRangeWithSameDay(DateTime? startDate, DateTime? endDate) {
    return isAfter(startDate!) && isBefore(endDate!) ||
        isSameDay(this, startDate) ||
        isSameDay(this, endDate!);
  }

  bool isAtSameHourAsNow() {
    return isAtSameMomentAs(DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
    ).toLocal());
  }

  String dayFormatWithLocale(String locale) {
    final dateFormat = DateFormat('EEEE, d MMM, yyyy', locale);
    return dateFormat.format(this);
  }

  String hourFormatWithLocale(String locale) {
    final hourFormat = DateFormat('HH:mm, EEEE, d MMM, yyyy', locale);
    return hourFormat.format(this);
  }

  List<int> get remainingHours {
    final selectedDate = this;
    final now = DateTime.now();
    if (selectedDate.isAfter(now) || isSameDay(selectedDate, now)) {
      return isSameDay(selectedDate, now)
          ? List.generate(23 - now.hour, (hour) => hour + now.hour + 1)
          : List.generate(24, (hour) => hour);
    } else {
      return [];
    }
  }
}

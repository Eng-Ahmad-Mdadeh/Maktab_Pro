import 'package:equatable/equatable.dart';

enum CalendarFormatOptions { hour, day, month, year }

class TypeRes extends Equatable {
  final int? id;
  final String? arName;
  final String? enName;

  const TypeRes({
    this.id,
    this.arName,
    this.enName,
  });

  factory TypeRes.fromJson(Map<String, dynamic> json) {
    return TypeRes(
      id: (json["id"] as num).toInt(),
      arName: json["ar_name"],
      enName: json["en_name"],
    );
  }

  @override
  String toString() {
    return 'TypeRes{id: $id, arName: $arName, enName: $enName}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["ar_name"] = arName;
    data["en_name"] = enName;
    return data;
  }

  @override
  List<Object?> get props => [
    id,
    arName,
    enName,
  ];

  static CalendarFormatOptions? getCalenderFormat(String arName) {
    switch (arName) {
      case 'ساعة':
        return CalendarFormatOptions.hour;
      case 'يومي':
        return CalendarFormatOptions.day;
      case 'شهري':
        return CalendarFormatOptions.month;
      case 'سنوي':
        return CalendarFormatOptions.year;
      default:
        return null;
    }
  }

  static String? getCalenderText(CalendarFormatOptions option) {
    switch (option) {
      case CalendarFormatOptions.hour:
        return 'ساعة';
      case CalendarFormatOptions.day:
        return 'يومي';
      case CalendarFormatOptions.month:
        return 'شهري';
      case CalendarFormatOptions.year:
        return 'سنوي';
      default:
        return null;
    }
  }
}

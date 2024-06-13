import 'package:equatable/equatable.dart';

class DatesSelectionEntity extends Equatable {
  final DateTime? startDate;
  final DateTime? endDate;
  final int? startTime;
  final int? endTime;

  const DatesSelectionEntity({
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
  });

  @override
  List<Object?> get props => [startDate, endDate, startTime, endTime];

  DatesSelectionEntity copyWith({
    DateTime? startDate,
    DateTime? endDate,
    int? startTime,
    int? endTime,
  }) {
    return DatesSelectionEntity(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
}
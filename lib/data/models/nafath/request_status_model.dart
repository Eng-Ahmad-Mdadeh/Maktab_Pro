import 'package:equatable/equatable.dart';

class RequestStatusModel extends Equatable {
  const RequestStatusModel({
    required this.status,
    required this.message,
  });

  final String? status;
  final String? message;

  factory RequestStatusModel.fromJson(Map<String, dynamic> json) {
    return RequestStatusModel(
      status: json["status"],
      message: json["message"],
    );
  }

  @override
  List<Object?> get props => [
        status,
        message,
      ];
}

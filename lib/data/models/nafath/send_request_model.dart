import 'package:equatable/equatable.dart';

class SendRequestModel extends Equatable {
  const SendRequestModel({
    required this.transId,
    required this.random,
    required this.message,
  });

  final String? transId;
  final String? random;
  final String? message;

  factory SendRequestModel.fromJson(Map<String, dynamic> json) {
    return SendRequestModel(
      transId: json["transId"],
      random: json["random"],
      message: json["message"],
    );
  }

  @override
  List<Object?> get props => [
        transId,
        random,
    message,
      ];

  SendRequestModel copyWith({
    String? transId,
    String? random,
    String? message,
  }) {
    return SendRequestModel(
      transId: transId ?? this.transId,
      random: random ?? this.random,
      message: message ?? this.message,
    );
  }
}

import 'package:equatable/equatable.dart';

class OfficeService extends Equatable {
  final int? id;
  final String? arName;
  final String? enName;
  final num? price;
  final int? status;
  final bool? req;

  const OfficeService({
    required this.id,
    required this.arName,
    required this.enName,
    required this.price,
    required this.status,
    required this.req,
  });

  factory OfficeService.fromJson(Map<String, dynamic> json) => OfficeService(
        id: json["id"],
        arName: json["ar_name"],
        enName: json["en_name"],
        price: num.parse(json["price"].toString()),
        status: int.parse(json["status"].toString()),
        req: json["status"] == '1',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ar_name": arName,
        "en_name": enName,
        "price": price,
        "status": status,
      };

  @override
  List<Object?> get props => [
        id,
        arName,
        enName,
        price,
        status,
      ];

  OfficeService copyWith({
    int? id,
    String? arName,
    String? enName,
    num? price,
    int? status,
    bool? req,
  }) {
    return OfficeService(
      id: id ?? this.id,
      arName: arName ?? this.arName,
      enName: enName ?? this.enName,
      price: price ?? this.price,
      status: status ?? this.status,
      req: req ?? this.req,
    );
  }
}

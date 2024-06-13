class Calendar {
  int? id;
  DateTime startDate;
  DateTime endDate;
  int adsId;
  int adsPriceId;
  String? orderId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Calendar({
    this.id,
    required this.startDate,
    required this.endDate,
    required this.adsId,
    required this.adsPriceId,
    this.orderId,
    this.createdAt,
    this.updatedAt,
  });

  factory Calendar.fromJson(Map<String, dynamic> json) => Calendar(
        id: json["id"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        adsId: int.parse(json["ads_id"]??'-1'),
        adsPriceId: int.parse(json["ads_price_id"]??'-1'),
        orderId: json["order_id"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "ads_id": adsId,
        "ads_price_id": adsPriceId,
        "order_id": orderId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };

  static List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 1; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }
}

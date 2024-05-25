class AdsRoom {
  int id;
  String adsId;
  String arName;
  String enName;
  String status;

  AdsRoom({
    required this.id,
    required this.adsId,
    required this.arName,
    required this.enName,
    required this.status,
  });

  factory AdsRoom.fromJson(Map<String, dynamic> json) => AdsRoom(
        id: json["id"],
        adsId: json["ads_id"],
        arName: json["ar_name"],
        enName: json["en_name"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ads_id": adsId,
        "ar_name": arName,
        "en_name": enName,
        "status": status,
      };
}

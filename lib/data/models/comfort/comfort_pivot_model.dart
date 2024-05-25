class ComfortPivot {
  int adsId;
  int comfortId;
  int id;

  ComfortPivot({
    required this.adsId,
    required this.comfortId,
    required this.id,
  });

  factory ComfortPivot.fromJson(Map<String, dynamic> json) => ComfortPivot(
        adsId: int.parse(json["ads_id"].toString()),
        comfortId: int.parse(json["comfort_id"].toString()),
        id: int.parse(json["id"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "ads_id": adsId,
        "comfort_id": comfortId,
        "id": id,
      };
}

class Favourite {
  int id;
  int adsId;
  int userOrdinaryId;
  int userBusinessId;

  Favourite({
    required this.id,
    required this.adsId,
    required this.userOrdinaryId,
    required this.userBusinessId,
  });

  factory Favourite.fromJson(Map<String, dynamic> json) => Favourite(
        id: json["id"],
        adsId: json["ads_id"],
        userOrdinaryId: json["user_ordinary_id"],
        userBusinessId: json["user_b_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ads_id": adsId,
        "user_ordinary_id": userOrdinaryId,
        "user_b_id": userBusinessId,
      };
}

class FeatureaOffice {
  int id;
  int boolfeatureaId;

  FeatureaOffice({
    required this.id,
    required this.boolfeatureaId,
  });

  factory FeatureaOffice.fromJson(Map<String, dynamic> json) => FeatureaOffice(
        id: json["id"],
        boolfeatureaId: int.parse(json["boolfeaturea_id"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "boolfeaturea_id": boolfeatureaId,
      };
}

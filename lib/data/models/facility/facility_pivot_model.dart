class FacilityPivot {
  int officeId;
  int facilityId;
  int id;

  FacilityPivot({
    required this.officeId,
    required this.facilityId,
    required this.id,
  });

  factory FacilityPivot.fromJson(Map<String, dynamic> json) => FacilityPivot(
        officeId: int.parse(json["ads_id"].toString()),
        facilityId: int.parse(json["facility_id"].toString()),
        id: int.parse(json["id"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "ads_id": officeId,
        "facility_id": facilityId,
        "id": id,
      };
}

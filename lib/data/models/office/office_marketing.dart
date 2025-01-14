class OfficeMarketing {
  int id;
  String fileEstateDeed;
  String fileBuildingLicense;
  String? fileCivilDefense;
  String isAccept;

  OfficeMarketing({
    required this.id,
    required this.fileEstateDeed,
    required this.fileBuildingLicense,
    this.fileCivilDefense,
    required this.isAccept,
  });

  factory OfficeMarketing.fromJson(Map<String, dynamic> json) =>
      OfficeMarketing(
        id: json["id"],
        fileEstateDeed: json["file_estate_deed"],
        fileBuildingLicense: json["file_building_license"],
        fileCivilDefense: json["file_civil_defense"],
        isAccept: json["is_accept"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file_estate_deed": fileEstateDeed,
        "file_building_license": fileBuildingLicense,
        "file_civil_defense": fileCivilDefense,
        "is_accept": isAccept,
      };
}

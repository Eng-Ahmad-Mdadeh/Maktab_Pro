class OfficeDetail {
  int id;
  String arName;
  String enName;
  int status;
  int numberDetails;
  int officeId;

  OfficeDetail({
    required this.id,
    required this.arName,
    required this.enName,
    required this.status,
    required this.numberDetails,
    required this.officeId,
  });

  factory OfficeDetail.fromJson(Map<String, dynamic> json) => OfficeDetail(
        id: json["id"],
        arName: json["ar_name"],
        enName: json["en_name"],
        status: int.parse(json["status"].toString()),
        numberDetails: int.parse(json["number_details"].toString()),
        officeId: int.parse(json["ads_id"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ar_name": arName,
        "en_name": enName,
        "status": status,
        "number_details": numberDetails,
        "ads_id": officeId,
      };
}

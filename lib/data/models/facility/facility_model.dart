class Facility {
  int id;
  int status;
  String icon;
  String arName;
  String enName;
  //FacilityPivot pivot;

  Facility({
    required this.id,
    required this.status,
    required this.icon,
    required this.arName,
    required this.enName,
    //required this.pivot,
  });

  factory Facility.fromJson(Map<String, dynamic> json) => Facility(
        id: json["id"],
        status: int.parse(json["status"].toString()),
        icon: 'https://maktab.sa/${json["icon"]}',
        arName: json["ar_name"],
        enName: json["en_name"],
        //pivot: FacilityPivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "icon": icon,
        "ar_name": arName,
        "en_name": enName,
        //"pivot": pivot,
      };
}

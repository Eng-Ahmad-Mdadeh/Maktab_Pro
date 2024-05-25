class OfficeCategory {
  int id;
  String status;
  String arName;
  String enName;
  String icon;
  String numSort;

  OfficeCategory({
    required this.id,
    required this.status,
    required this.arName,
    required this.enName,
    required this.icon,
    required this.numSort,
  });

  factory OfficeCategory.fromJson(Map<String, dynamic> json) => OfficeCategory(
        id: json["id"],
        status: json["status"],
        arName: json["ar_name"],
        enName: json["en_name"],
        icon: 'https://maktab.sa/${json["icon"]}',
        numSort: json["num_sort"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "ar_name": arName,
        "en_name": enName,
        "icon": icon,
        "num_sort": numSort,
      };
}

class RoomDetails {
  int? id;
  String? arName;
  String? enName;
  List<dynamic>? adsRooms;

  RoomDetails({this.id, this.arName, this.enName, this.adsRooms});

  RoomDetails.fromJson(Map<String, dynamic> json) {
    if(json["id"] is num) {
      id = (json["id"] as num).toInt();
    }
    if(json["ar_name"] is String) {
      arName = json["ar_name"];
    }
    if(json["en_name"] is String) {
      enName = json["en_name"];
    }
    if(json["ads_rooms"] is List) {
      adsRooms = json["ads_rooms"] ?? [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["ar_name"] = arName;
    data["en_name"] = enName;
    if(adsRooms != null) {
      data["ads_rooms"] = adsRooms;
    }
    return data;
  }
}
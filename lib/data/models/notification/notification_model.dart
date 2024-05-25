class Notification {
  int id;
  String arTitle;
  String enTitle;
  String arBody;
  String enBody;
  int receiverAdmin;
  int receiverBusiness;
  int receiverOrdinary;

  Notification({
    required this.id,
    required this.arTitle,
    required this.enTitle,
    required this.arBody,
    required this.enBody,
    required this.receiverAdmin,
    required this.receiverBusiness,
    required this.receiverOrdinary,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"],
        arTitle: json["ar_title"],
        enTitle: json["en_title"],
        arBody: json["ar_body"],
        enBody: json["en_body"],
        receiverAdmin: json["receiver_admin"],
        receiverBusiness: json["receiver_business"],
        receiverOrdinary: json["receiver_ordinary"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ar_title": arTitle,
        "en_title": enTitle,
        "ar_body": arBody,
        "en_body": enBody,
        "receiver_admin": receiverAdmin,
        "receiver_business": receiverBusiness,
        "receiver_ordinary": receiverOrdinary,
      };
}

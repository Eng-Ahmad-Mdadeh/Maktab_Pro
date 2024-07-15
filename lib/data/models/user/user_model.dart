import 'package:maktab_lessor/data/models/user/user_type.dart';

class User {
  int id;
  String? userName;
  String? companyName;
  String phone;
  String? email;
  String? officeName;
  String? about;
  String? licenseLink;
  String? licenseNumber;
  bool requestDeleteAccount;
  String? city;
  String? neighborhood;
  String? commercialRecord;
  String? membershipValidity;
  String? idNumber;
  String? image;
  UserType? type;
  String? membership;
  bool isNafath;

  User({
    required this.id,
    required this.userName,
    required this.companyName,
    required this.phone,
    required this.email,
    required this.officeName,
    required this.about,
    required this.requestDeleteAccount,
    required this.licenseLink,
    required this.licenseNumber,
    required this.city,
    required this.neighborhood,
    required this.commercialRecord,
    required this.membershipValidity,
    required this.idNumber,
    required this.image,
    required this.type,
    required this.membership,
    required this.isNafath,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        userName: json["username"] ?? '',
        companyName: json["company_name"] ?? '',
        phone: json["phone"].toString().replaceRange(0, 3, ''),
        email: json["email"] ?? '',
        officeName: json["office_name"] ?? '',
    requestDeleteAccount: json["request_delete_account"] == '1',
        about: json["about"] ?? '',
        licenseLink: json["licenseLink"] ?? '',
        licenseNumber: json["license_number"] ?? '',
        city: json["city"] ?? '',
        neighborhood: json["neighborhood"] ?? '',
        commercialRecord: json["commercial_record"] ?? '',
        membershipValidity: json["membership_validity"] ?? '',
        idNumber: json["IdNumber"] ?? '',
        image: json["image"] != null
            ? 'https://maktab.sa/${json["image"]["name"]}'
            : '',
        type: json["type"] != null ? UserType.fromJson(json["type"]) : null,
        membership: json["membership"] ?? '',
        isNafath: json["is_nafath"] != null
            ? int.parse(json["is_nafath"].toString()) == 1
                ? true
                : false
            : false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": userName,
        "company_name": companyName,
        "phone": phone,
        "email": email,
        "office_name": officeName,
        "about": about,
        "licenseLink": licenseLink,
        "request_delete_account": requestDeleteAccount ? '1' : '0',
        "license_number": licenseNumber,
        "city": city,
        "neighborhood": neighborhood,
        "commercial_record": commercialRecord,
        "membership_validity": membershipValidity,
        "IdNumber": idNumber,
        "image": image,
        "type": type!.toJson(),
        "membership": membership,
        "is_nafath": isNafath,
      };
}

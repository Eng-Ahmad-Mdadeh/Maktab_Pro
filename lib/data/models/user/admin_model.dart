class Admin {
  String firstName;
  String lastName;
  String email;
  String mobileNumber;
  String registerNumber;
  String specialNumber;
  String taxNumber;
  String city;
  String neighborhood;
  String street;
  String buildingNumber;
  String postalCode;
  String marginalNumber;

  Admin({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNumber,
    required this.registerNumber,
    required this.specialNumber,
    required this.taxNumber,
    required this.city,
    required this.neighborhood,
    required this.street,
    required this.buildingNumber,
    required this.postalCode,
    required this.marginalNumber,
  });

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        mobileNumber: json["mobile_number"],
        registerNumber: json["register_number"],
        specialNumber: json["special_number"],
        taxNumber: json["tax_number"],
        city: json["city"],
        neighborhood: json["neighborhood"],
        street: json["street"],
        buildingNumber: json["building_number"],
        postalCode: json["postal_code"],
        marginalNumber: json["marginal_number"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "mobile_number": mobileNumber,
        "register_number": registerNumber,
        "special_number": specialNumber,
        "tax_number": taxNumber,
        "city": city,
        "neighborhood": neighborhood,
        "street": street,
        "building_number": buildingNumber,
        "postal_code": postalCode,
        "marginal_number": marginalNumber,
      };
}

class OfficeLocation {
  int id;
  num lat;
  num lng;
  num zoom;
  String address;
  String city;
  String neighborhood;
  String street;

  OfficeLocation({
    required this.id,
    required this.lat,
    required this.lng,
    required this.zoom,
    required this.address,
    required this.city,
    required this.neighborhood,
    required this.street,
  });

  factory OfficeLocation.fromJson(Map<String, dynamic> json) => OfficeLocation(
        id: json["id"],
        lat: num.parse(json["lat"].toString()),
        lng: num.parse(json["lng"].toString()),
        zoom: num.parse(json["zoom"].toString()),
        address: json["address"] ?? '',
        city: json["city"] ?? '',
        neighborhood: json["neighborhood"] ?? '',
        street: json["street"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
        "zoom": zoom,
        "address": address,
        "city": city,
        "neighborhood": neighborhood,
        "street": street,
      };
}

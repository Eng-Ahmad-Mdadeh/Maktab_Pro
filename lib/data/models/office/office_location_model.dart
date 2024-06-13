import 'package:equatable/equatable.dart';

class OfficeLocation extends Equatable{
   final double lat;
   final double lng;
   final double zoom;
   final String address;
   final String city;
   final String neighborhood;
   final String street;

  const OfficeLocation({
    required this.lat,
    required this.lng,
    required this.zoom,
    required this.address,
    required this.city,
    required this.neighborhood,
    required this.street,
  });

  factory OfficeLocation.fromJson(Map<String, dynamic> json) {
    return OfficeLocation(
        lat: double.parse(json["lat"].toString()),
        lng: double.parse(json["lng"].toString()),
        zoom: double.parse(json["zoom"].toString()),
        address: json["address"] ?? '',
        city: json["city"] ?? '',
        neighborhood: json["neighborhood"] ?? '',
        street: json["street"] ?? '',
      );
  }

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
        "zoom": zoom,
        "address": address,
        "city": city,
        "neighborhood": neighborhood,
        "street": street,
      };

  @override
  List<Object?> get props => [
    lat,
    lng,
    zoom,
    address,
    city,
    neighborhood,
    street,
  ];
}

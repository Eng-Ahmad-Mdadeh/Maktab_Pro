class MapPlace {
  late String street;
  late String neighborhood;
  late String city;

  MapPlace({
    required this.street,
    required this.neighborhood,
    required this.city,
  });

  MapPlace.fromJsonList(List<dynamic> json) {
    street = '';
    neighborhood = '';
    city = '';
    for (var result in json) {
      List<dynamic> addressComponents = result["address_components"];
      if (addressComponents.isNotEmpty) {
        for (var component in addressComponents) {
          List<dynamic> componentTypes = component["types"];
          String longName = component["long_name"];
          if (componentTypes.contains("locality")) {
            city = longName;
          } else if (componentTypes.contains("neighborhood")) {
            neighborhood = longName;
          } else if (componentTypes.contains("route")) {
            street = longName;
          }
        }
      }
    }
  }
}

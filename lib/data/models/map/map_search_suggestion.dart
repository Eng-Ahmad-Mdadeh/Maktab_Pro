class MapSearchSuggestion {
  final String placeId;
  final String description;

  MapSearchSuggestion({required this.placeId, required this.description});

  factory MapSearchSuggestion.fromJson(Map<String, dynamic> json) =>
      MapSearchSuggestion(
        placeId: json["place_id"],
        description: json["description"],
      );
}

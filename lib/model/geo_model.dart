class GeoModel {
  final String lat;
  final String lng;
  GeoModel({
    required this.lat,
    required this.lng,
  });

  factory GeoModel.from(Map<String, dynamic> json) {
    return GeoModel(
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}

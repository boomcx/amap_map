import 'dart:convert';

class LatLng {
  final double latitude;
  final double longitude;

  const LatLng(this.latitude, this.longitude);

  Map<String, Object> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  String toJsonString() => jsonEncode(toJson());

  LatLng.fromJson(Map<String, dynamic> json)
      : latitude = json['latitude'] as double,
        longitude = json['longitude'] as double;

  LatLng copyWith({
    double latitude,
    double longitude,
  }) {
    return LatLng(
      latitude ?? this.latitude,
      longitude ?? this.longitude,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LatLng &&
          runtimeType == other.runtimeType &&
          latitude == other.latitude &&
          longitude == other.longitude;

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;

  @override
  String toString() {
    return 'LatLng{lat: $latitude, lng: $longitude}';
  }
}

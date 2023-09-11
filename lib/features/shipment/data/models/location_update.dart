import 'package:handover/features/shipment/data/models/location_proximity.dart';
import 'package:latlong2/latlong.dart';

class LocationUpdate {
  final LatLng current;
  final LocationProximity proximity;

  LocationUpdate({
    required this.current,
    this.proximity = LocationProximity.farFromPickup,
  });

  Map<String, dynamic> toJson() {
    return {
      "current": {"lat": current.latitude, "long": current.longitude},
      "proximity": proximity.name
    };
  }

  factory LocationUpdate.fromJson(json) {
    return LocationUpdate(
        current: LatLng(json["current"]["lat"], json["current"]["long"]),
        proximity: LocationProximity.values
            .firstWhere((element) => element.name == json["proximity"]));
  }
}

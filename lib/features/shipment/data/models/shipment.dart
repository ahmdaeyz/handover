import 'package:equatable/equatable.dart';
import 'package:handover/core/presentation/utils/formatters.dart';
import 'package:handover/features/shipment/data/models/driver.dart';
import 'package:handover/features/shipment/data/models/location_proximity.dart';
import 'package:handover/features/shipment/data/models/shipment_status.dart';
import 'package:latlong2/latlong.dart';

class Shipment extends Equatable {
  final int id;
  final LatLng pickupLocation;
  final LatLng deliveryLocation;
  final ShipmentStatus status;
  final int? rating;
  final DateTime? pickupTime;
  final DateTime? deliveryTime;
  final double? total;
  final List<LocationProximity>? trackingHistory;
  final Driver driver;

  const Shipment({
    required this.id,
    required this.pickupLocation,
    required this.deliveryLocation,
    required this.status,
    required this.driver,
    this.rating,
    this.pickupTime,
    this.deliveryTime,
    this.total,
    this.trackingHistory,
  });

  int get completedTrackingSteps =>
      trackingHistory
          ?.where((element) =>
              element != LocationProximity.withinFiveKmFromPickup &&
              element != LocationProximity.farFromDelivery)
          .length ??
      0;

  @override
  List<Object?> get props => [
        id,
        pickupLocation,
        deliveryLocation,
        status,
        trackingHistory,
        pickupTime,
        deliveryTime,
        total,
        rating,
        driver
      ];

  String get pickupTimeFormatted => timeFormatter.format(pickupTime!);

  String get deliveryTimeFormatted => timeFormatter.format(deliveryTime!);

  String get totalFormatted => totalFormatter.format(total);

  Shipment copyWith(
      {ShipmentStatus? status,
      int? rating,
      DateTime? pickupTime,
      DateTime? deliveryTime,
      double? total,
      List<LocationProximity>? trackingHistory}) {
    return Shipment(
        id: id,
        driver: driver,
        pickupLocation: pickupLocation,
        deliveryLocation: deliveryLocation,
        status: status ?? this.status,
        rating: rating ?? this.rating,
        pickupTime: pickupTime ?? this.pickupTime,
        deliveryTime: deliveryTime ?? this.deliveryTime,
        total: total ?? this.total,
        trackingHistory: trackingHistory ??
            (this.trackingHistory != null ? [...?this.trackingHistory] : null));
  }
}

import 'package:handover/features/tracking/data/models/location_proximity.dart';
import 'package:handover/generated/l10n.dart';

class NotificationData {
  final LocationProximity proximity;

  const NotificationData({required this.proximity});

  String? get title {
    return S.current.shipmentStatusUpdate;
  }

  String? get subtitle {
    switch (proximity) {
      case LocationProximity.atPickup:
        return S.current.shipmentIsBeingPickup;
      case LocationProximity.atDelivery:
        return S.current.shipmentIsDelivered;
      case LocationProximity.withinFiveKmFromPickup:
        return S.current.carrierIsNearPickup;
      case LocationProximity.withingFiveKmFromDelivery:
        return S.current.carrierIsNearDelivery;
      default:
        return null;
    }
  }
}

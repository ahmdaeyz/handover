import 'package:handover/features/shipment/data/models/location_update.dart';
import 'package:handover/features/shipment/data/models/notification_data.dart';
import 'package:handover/features/shipment/data/models/shipment.dart';
import 'package:handover/features/shipment/data/services/shipments_service.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ShipmentsDataSource)
class ShipmentsDataSourceImpl implements ShipmentsDataSource {
  final ShipmentsService _service;

  ShipmentsDataSourceImpl(this._service);

  @override
  Stream<Future<LocationUpdate>> driverLocationUpdates(int shipmentId) =>
      _service.trackDriver(shipmentId);

  @override
  Shipment getShipment(int id) => _service.getShipment(id);

  @override
  Stream<Shipment> shipmentUpdates(int id) => _service.getShipmentUpdates(id);

  @override
  Stream<NotificationData> getPushNotifications(int shipmentId) =>
      _service.getNotificationUpdates(shipmentId);

  @override
  List<Shipment> getShipments() => _service.getShipments();
}

abstract class ShipmentsDataSource {
  Stream<Future<LocationUpdate>> driverLocationUpdates(int shipmentId);

  Stream<NotificationData> getPushNotifications(int shipmentId);

  Stream<Shipment> shipmentUpdates(int id);

  Shipment getShipment(int id);

  List<Shipment> getShipments();
}

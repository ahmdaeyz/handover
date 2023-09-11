import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:handover/core/data/utils/notification.dart';
import 'package:handover/features/shipment/data/data_sources/shipments_data_source.dart';
import 'package:handover/features/shipment/data/models/location_update.dart';
import 'package:handover/features/shipment/data/models/shipment.dart';
import 'package:handover/main.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ShipmentsRepository implements Disposable {
  final ShipmentsDataSource _shipmentDataSource;

  StreamSubscription? _subscription;

  ShipmentsRepository(this._shipmentDataSource);

  List<Shipment> getShipments() => _shipmentDataSource.getShipments();

  Shipment getShipment(int id) => _shipmentDataSource.getShipment(id);

  Stream<Shipment> getShipmentUpdates(int id) =>
      _shipmentDataSource.shipmentUpdates(id);

  Stream<LocationUpdate> getDriverLocationUpdates(int shipmentId) async* {
    _subscription =
        _shipmentDataSource.getPushNotifications(shipmentId).listen((event) {
      flutterLocalNotificationsPlugin.show(
          event.hashCode,
          event.title,
          event.subtitle,
          const NotificationDetails(android: androidNotificationDetails));
    });
    await for (final update
        in _shipmentDataSource.driverLocationUpdates(shipmentId)) {
      yield (await update);
    }
  }

  @override
  FutureOr onDispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}

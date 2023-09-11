import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:handover/features/shipment/data/models/driver.dart';
import 'package:handover/features/shipment/data/models/location_proximity.dart';
import 'package:handover/features/shipment/data/models/location_update.dart';
import 'package:handover/features/shipment/data/models/notification_data.dart';
import 'package:handover/features/shipment/data/models/shipment.dart';
import 'package:handover/features/shipment/data/models/shipment_status.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mt;
import 'package:rxdart/rxdart.dart';

/// How many meters in [pollDriverLocationEveryMs] the driver moves to reach target
int get driverStepLengthInMeters => 100;

/// How many milliseconds to poll the driver location update
int get pollDriverLocationEveryMs => 500;

/// This class simulates a backend service
@Singleton()
class ShipmentsService {
  /// Like a database with constant access time.
  final Map<int, Shipment> _shipments = {
    1234: Shipment(
        id: 1234,
        driver: Driver(image: "assets/sad_cat.jpg", name: "Ahmed Aboelyazeed"),
        pickupLocation: const LatLng(5, 6),
        deliveryLocation: const LatLng(5.5, 6.1),
        status: ShipmentStatus.shipped,
        total: 50,
        pickupTime: DateTime.now().subtract(Duration(days: 5)),
        deliveryTime: DateTime.now()
            .subtract(const Duration(days: 5))
            .add(const Duration(minutes: 30)),
        rating: 4),

    /// Simulation case
    3334: Shipment(
        id: 3334,
        driver: Driver(image: "assets/sad_cat.jpg", name: "Mohamed Abdullah"),
        pickupLocation: const LatLng(24.780465181078792, 46.68622777657658),
        deliveryLocation: const LatLng(24.76202145745268, 46.777123644326544),
        status: ShipmentStatus.inTransit)
  };

  /// Holds handles to streams
  final Map<int, BehaviorSubject<Shipment>> _shipmentUpdates = {};

  /// Holds handles to notifications streams
  final Map<int, StreamController<NotificationData>>
      _notificationUpdatesHandles = {};

  /// The database of drivers live locations
  final Map<int, LocationUpdate> _currentDriverUpdate = {
    3334: LocationUpdate(
      current: const LatLng(24.78126125136917, 46.754326610034056),
    )
  };

  /// A database to hold the previous distance calculated between the driver and a pickup or delivery point
  final Map<int, num> _previousDistance = {};

  /// Like a get request
  Shipment getShipment(int id) {
    return _shipments[id]!;
  }

  /// Returns the list of available shipments in the system
  List<Shipment> getShipments() {
    return _shipments.values.toList();
  }

  /// Like a socket or http stream,
  ///
  /// It returns the stream from the handle in [_shipmentUpdates]
  Stream<Shipment> getShipmentUpdates(int id) {
    final shipment = _shipments[id];
    assert(shipment != null && shipment.status == ShipmentStatus.inTransit);
    late Stream<Shipment> stream;
    final controller = _shipmentUpdates[id];
    if (controller != null) {
      stream = controller.stream;
    } else {
      final newController = BehaviorSubject.seeded(shipment!);
      _shipmentUpdates[id] = newController;
      stream = newController.stream;
    }
    return stream;
  }

  /// Like a socket or http stream,
  ///
  /// It returns the stream from the handle in [_notificationUpdatesHandles]
  Stream<NotificationData> getNotificationUpdates(int id) {
    final shipment = _shipments[id];
    assert(shipment != null && shipment.status == ShipmentStatus.inTransit);
    late Stream<NotificationData> stream;
    final controller = _notificationUpdatesHandles[id];
    if (controller != null) {
      stream = controller.stream;
    } else {
      final newController = StreamController<NotificationData>.broadcast();
      _notificationUpdatesHandles[id] = newController;
      stream = newController.stream;
    }
    return stream;
  }

  /// Like a socket or http stream,
  ///
  /// Where the simulation actually takes place.
  ///
  /// It runs periodically (every 500ms) and does the following:
  ///
  /// 1) Calculates the distance between driver and pickup point if wasn't picked yet.
  ///
  /// 2) Calculates the heading (The Angle degree the driver should adjust himself to face the end point)
  ///
  /// 3) Moves 100 meters towards the pickup or delivery point in direction of the heading.
  ///
  /// 4) If the distance (to target) resulting from the new location is larger than the previous distance it keeps trying until reaches a lower distance.
  ///
  /// 5) Trying to reach a lower distance is run in an isolate to not block the UI.
  Stream<Future<LocationUpdate>> trackDriver(int shipmentId) {
    final shipmentUpdatesController = _shipmentUpdates[shipmentId];
    final notificationUpdatesController =
        _notificationUpdatesHandles[shipmentId];
    return Stream.periodic(Duration(milliseconds: pollDriverLocationEveryMs),
        (_) async {
      final shipment = _shipments[shipmentId];
      final currentLocation = _currentDriverUpdate[shipmentId]!.current;
      if (shipment?.pickupTime == null) {
        LocationUpdate update = await _simulateReachingPickup(
            currentLocation,
            shipment,
            shipmentId,
            shipmentUpdatesController,
            notificationUpdatesController);

        return update;
      } else if (_shipments[shipmentId]?.deliveryTime == null) {
        LocationUpdate update = await _simulateReachingDelivery(
            currentLocation,
            shipment,
            shipmentId,
            shipmentUpdatesController,
            notificationUpdatesController);

        return update;
      } else {
        return _currentDriverUpdate[shipmentId]!;
      }
    });
  }

  Future<LocationUpdate> _simulateReachingDelivery(
      LatLng currentLocation,
      Shipment? shipment,
      int shipmentId,
      BehaviorSubject<Shipment>? shipmentUpdatesController,
      StreamController<NotificationData>? notificationUpdatesController) async {
    var distanceBetweenPoints = mt.SphericalUtil.computeDistanceBetween(
        mt.LatLng(currentLocation.latitude, currentLocation.longitude),
        mt.LatLng(shipment!.deliveryLocation.latitude,
            shipment.deliveryLocation.longitude));

    _previousDistance[shipmentId] ??= distanceBetweenPoints;

    final data = await compute(nextLocation, <String, dynamic>{
      "targetLat": shipment.deliveryLocation.latitude,
      "targetLong": shipment.deliveryLocation.longitude,
      "previousDistance": _previousDistance[shipmentId],
      "currentDriverLocationLat": currentLocation.latitude,
      "currentDriverLocationLong": currentLocation.longitude
    });

    var currentDriverLocation = LatLng(data["currentLat"], data["currentLong"]);
    distanceBetweenPoints = data["prevDistance"];
    _previousDistance[shipmentId] = distanceBetweenPoints;
    late LocationProximity proximity;
    if (distanceBetweenPoints <= 100) {
      proximity = _handleDistanceToDeliveryIsLessThan100Meters(
          shipmentId, shipmentUpdatesController, notificationUpdatesController);
    } else if (distanceBetweenPoints <= 5000) {
      proximity = _handleDistanceToDeliveryIsLessThan5Km(
          shipmentId, shipmentUpdatesController, notificationUpdatesController);
    } else if (distanceBetweenPoints > 5000) {
      proximity = _handleDistanceToDeliveryIsMoreThan5Km(
          shipmentId, shipmentUpdatesController);
    }

    final update =
        LocationUpdate(current: currentDriverLocation, proximity: proximity);

    _currentDriverUpdate[shipmentId] = update;
    return update;
  }

  LocationProximity _handleDistanceToDeliveryIsMoreThan5Km(
      int shipmentId, BehaviorSubject<Shipment>? shipmentUpdatesController) {
    var proximity = LocationProximity.farFromDelivery;

    /// Iff there isn't an entry already add one
    if (_shipments[shipmentId]?.trackingHistory?.lastOrNull !=
        LocationProximity.farFromDelivery) {
      final history = [...?_shipments[shipmentId]?.trackingHistory, proximity];
      _shipments[shipmentId] =
          _shipments[shipmentId]!.copyWith(trackingHistory: history);

      /// Push the change in shipment to listeners
      shipmentUpdatesController?.add(_shipments[shipmentId]!);
    }
    return proximity;
  }

  LocationProximity _handleDistanceToDeliveryIsLessThan5Km(
      int shipmentId,
      BehaviorSubject<Shipment>? shipmentUpdatesController,
      StreamController<NotificationData>? notificationUpdatesController) {
    var proximity = LocationProximity.withingFiveKmFromDelivery;
    if (_shipments[shipmentId]?.trackingHistory?.lastOrNull !=
        LocationProximity.withingFiveKmFromDelivery) {
      final history = [...?_shipments[shipmentId]?.trackingHistory, proximity];
      _shipments[shipmentId] =
          _shipments[shipmentId]!.copyWith(trackingHistory: history);
      shipmentUpdatesController?.add(_shipments[shipmentId]!);

      /// Push a notification to listeners (part of the bussiness logic)
      notificationUpdatesController
          ?.add(NotificationData(proximity: proximity));
    }
    return proximity;
  }

  LocationProximity _handleDistanceToDeliveryIsLessThan100Meters(
      int shipmentId,
      BehaviorSubject<Shipment>? shipmentUpdatesController,
      StreamController<NotificationData>? notificationUpdatesController) {
    const proximity = LocationProximity.atDelivery;
    if (_shipments[shipmentId]?.trackingHistory?.lastOrNull !=
        LocationProximity.atDelivery) {
      final history = [...?_shipments[shipmentId]?.trackingHistory, proximity];

      /// Concludes the shipping process setting total, rating and the status to shipped
      _shipments[shipmentId] = _shipments[shipmentId]!.copyWith(
          deliveryTime: DateTime.now(),
          total: 40,
          rating: 5,
          status: ShipmentStatus.shipped,
          trackingHistory: history);
      shipmentUpdatesController?.add(_shipments[shipmentId]!);
      shipmentUpdatesController?.close();
      notificationUpdatesController
          ?.add(const NotificationData(proximity: proximity));
      notificationUpdatesController?.close();
    }
    return proximity;
  }

  Future<LocationUpdate> _simulateReachingPickup(
      LatLng currentLocation,
      Shipment? shipment,
      int shipmentId,
      BehaviorSubject<Shipment>? shipmentUpdatesController,
      StreamController<NotificationData>? notificationUpdatesController) async {
    var distanceBetweenPoints = mt.SphericalUtil.computeDistanceBetween(
        mt.LatLng(currentLocation.latitude, currentLocation.longitude),
        mt.LatLng(shipment!.pickupLocation.latitude,
            shipment.pickupLocation.longitude));

    _previousDistance[shipmentId] ??= distanceBetweenPoints;

    final data = await compute(nextLocation, <String, dynamic>{
      "targetLat": shipment.pickupLocation.latitude,
      "targetLong": shipment.pickupLocation.longitude,
      "previousDistance": _previousDistance[shipmentId],
      "currentDriverLocationLat": currentLocation.latitude,
      "currentDriverLocationLong": currentLocation.longitude
    });

    var currentDriverLocation = LatLng(data["currentLat"], data["currentLong"]);
    distanceBetweenPoints = data["prevDistance"];
    _previousDistance[shipmentId] = distanceBetweenPoints;

    late LocationProximity proximity;
    if (distanceBetweenPoints <= 100) {
      proximity = _handleDistanceToPickupIsLessThan100Meters(
          shipmentId, shipmentUpdatesController, notificationUpdatesController);
    } else if (distanceBetweenPoints <= 5000) {
      proximity = _handleDistanceToPickupIsLessThan5Km(
          shipmentId, shipmentUpdatesController, notificationUpdatesController);
    } else if (distanceBetweenPoints > 5000) {
      proximity = _handleDistanceToPickupIsMoreThan5Km(
          shipmentId, shipmentUpdatesController);
    }

    final update =
        LocationUpdate(current: currentDriverLocation, proximity: proximity);
    _currentDriverUpdate[shipmentId] = update;
    return update;
  }

  LocationProximity _handleDistanceToPickupIsMoreThan5Km(
      int shipmentId, BehaviorSubject<Shipment>? shipmentUpdatesController) {
    const proximity = LocationProximity.farFromPickup;
    if (_shipments[shipmentId]?.trackingHistory?.lastOrNull !=
        LocationProximity.farFromPickup) {
      final history = [...?_shipments[shipmentId]?.trackingHistory, proximity];
      _shipments[shipmentId] =
          _shipments[shipmentId]!.copyWith(trackingHistory: history);
      shipmentUpdatesController?.add(_shipments[shipmentId]!);
    }
    return proximity;
  }

  LocationProximity _handleDistanceToPickupIsLessThan5Km(
      int shipmentId,
      BehaviorSubject<Shipment>? shipmentUpdatesController,
      StreamController<NotificationData>? notificationUpdatesController) {
    const proximity = LocationProximity.withinFiveKmFromPickup;
    if (_shipments[shipmentId]?.trackingHistory?.lastOrNull !=
        LocationProximity.withinFiveKmFromPickup) {
      final history = [...?_shipments[shipmentId]?.trackingHistory, proximity];
      _shipments[shipmentId] =
          _shipments[shipmentId]!.copyWith(trackingHistory: history);
      shipmentUpdatesController?.add(_shipments[shipmentId]!);
      notificationUpdatesController
          ?.add(const NotificationData(proximity: proximity));
    }
    return proximity;
  }

  LocationProximity _handleDistanceToPickupIsLessThan100Meters(
      int shipmentId,
      BehaviorSubject<Shipment>? shipmentUpdatesController,
      StreamController<NotificationData>? notificationUpdatesController) {
    const proximity = LocationProximity.atPickup;
    if (_shipments[shipmentId]?.trackingHistory?.lastOrNull !=
        LocationProximity.atPickup) {
      final history = [...?_shipments[shipmentId]?.trackingHistory, proximity];
      _previousDistance.remove(shipmentId);
      _shipments[shipmentId] = _shipments[shipmentId]!.copyWith(
          pickupTime: DateTime.now(), total: 40, trackingHistory: history);
      shipmentUpdatesController?.add(_shipments[shipmentId]!);
      notificationUpdatesController
          ?.add(const NotificationData(proximity: proximity));
    }
    return proximity;
  }
}

/// Loops to find a smaller distance to the target
Map<String, dynamic> nextLocation(Map<String, dynamic> params) {
  final target = mt.LatLng(params["targetLat"], params["targetLong"]);
  var distanceBetweenPoints = params["previousDistance"];
  var previousDistance = params["previousDistance"];
  var currentDriverLocation = LatLng(
      params["currentDriverLocationLat"], params["currentDriverLocationLong"]);

  while (distanceBetweenPoints >= previousDistance) {
    distanceBetweenPoints = mt.SphericalUtil.computeDistanceBetween(
        mt.LatLng(
            currentDriverLocation.latitude, currentDriverLocation.longitude),
        target);
    final heading = mt.SphericalUtil.computeHeading(
        mt.LatLng(
            currentDriverLocation.latitude, currentDriverLocation.longitude),
        target);
    final special = mt.SphericalUtil.computeOffset(
        mt.LatLng(
            currentDriverLocation.latitude, currentDriverLocation.longitude),
        driverStepLengthInMeters,
        heading);
    currentDriverLocation = LatLng(special.latitude, special.longitude);
  }
  previousDistance = distanceBetweenPoints;
  return {
    "prevDistance": previousDistance,
    "currentLat": currentDriverLocation.latitude,
    "currentLong": currentDriverLocation.longitude
  };
}

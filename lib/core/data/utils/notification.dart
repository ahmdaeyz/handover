import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const notificationChannelId = "handover_shipment_updates";
const notificationChannelName = "Shipment Updates";
const androidNotificationDetails = AndroidNotificationDetails(
    notificationChannelId, notificationChannelName,
    icon: 'ic_launcher');

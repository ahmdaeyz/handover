// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(number) => "Shipment #${number}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appName": MessageLookupByLibrary.simpleMessage("Handover"),
        "carrierIsNearDelivery": MessageLookupByLibrary.simpleMessage(
            "The carrier is near your shipment\'s delivery point"),
        "carrierIsNearPickup": MessageLookupByLibrary.simpleMessage(
            "The carrier is near your shipment\'s pickup point"),
        "delivered": MessageLookupByLibrary.simpleMessage("Delivered package"),
        "deliveryTime": MessageLookupByLibrary.simpleMessage("Delivery Time"),
        "inTransit": MessageLookupByLibrary.simpleMessage("In Transit"),
        "mapLoadingError": MessageLookupByLibrary.simpleMessage(
            "Something wrong happened while downloading parts of the map, Are you sure you have stable internet?"),
        "myShipments": MessageLookupByLibrary.simpleMessage("My Shipments"),
        "nearDelivery":
            MessageLookupByLibrary.simpleMessage("Near delivery destination"),
        "noTrackingShippedMessage": MessageLookupByLibrary.simpleMessage(
            "You can\'t track a shipped package."),
        "onTheWay": MessageLookupByLibrary.simpleMessage("On the way"),
        "pickUpTime": MessageLookupByLibrary.simpleMessage("Pickup Time"),
        "pickedUp": MessageLookupByLibrary.simpleMessage("Picked up delivery"),
        "shipmentIsBeingPickup": MessageLookupByLibrary.simpleMessage(
            "Your shipment is being picked up by the driver"),
        "shipmentIsDelivered": MessageLookupByLibrary.simpleMessage(
            "Your shipment was successfully delivered"),
        "shipmentNo": m0,
        "shipmentStatusUpdate":
            MessageLookupByLibrary.simpleMessage("Shipment Status Update"),
        "shipped": MessageLookupByLibrary.simpleMessage("Shipped"),
        "somethingIsWrong":
            MessageLookupByLibrary.simpleMessage("Something is wrong."),
        "submit": MessageLookupByLibrary.simpleMessage("Submit"),
        "total": MessageLookupByLibrary.simpleMessage("Total")
      };
}

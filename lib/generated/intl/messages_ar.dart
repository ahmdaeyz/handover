// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
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
  String get localeName => 'ar';

  static String m0(number) => "الشحنة #${number}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appName": MessageLookupByLibrary.simpleMessage("المُسلم"),
        "carrierIsNearDelivery": MessageLookupByLibrary.simpleMessage(
            "السائق بالثرب من نقطة التسليم"),
        "carrierIsNearPickup": MessageLookupByLibrary.simpleMessage(
            "السائق بالقرب من نقطة الاستلام"),
        "delivered": MessageLookupByLibrary.simpleMessage("تم التوصيل"),
        "deliveryTime": MessageLookupByLibrary.simpleMessage("وقت التسليم"),
        "inTransit": MessageLookupByLibrary.simpleMessage("جاري"),
        "mapLoadingError": MessageLookupByLibrary.simpleMessage(
            "حدث خطأ أثناء تحميل جزء من الخريطة، هل انت متأكد من اتصالك بالانترنت؟"),
        "myShipments": MessageLookupByLibrary.simpleMessage("شحناتي"),
        "nearDelivery":
            MessageLookupByLibrary.simpleMessage("بالقرب من نقطة التوصيل"),
        "noTrackingShippedMessage": MessageLookupByLibrary.simpleMessage(
            "لا يمكن تتبع شحنة موصلة بالفعل."),
        "onTheWay": MessageLookupByLibrary.simpleMessage("في الطريق"),
        "pickUpTime": MessageLookupByLibrary.simpleMessage("وقت الاستلام"),
        "pickedUp": MessageLookupByLibrary.simpleMessage("تم استلام الشحنة"),
        "shipmentIsBeingPickup":
            MessageLookupByLibrary.simpleMessage("تم استلام شحنتك"),
        "shipmentIsDelivered":
            MessageLookupByLibrary.simpleMessage("تم تسليم شحنتك بنجاح"),
        "shipmentNo": m0,
        "shipmentStatusUpdate":
            MessageLookupByLibrary.simpleMessage("تحديث بخصوص شحنتك"),
        "shipped": MessageLookupByLibrary.simpleMessage("تم التوصيل"),
        "somethingIsWrong":
            MessageLookupByLibrary.simpleMessage("هناك خطب ما."),
        "submit": MessageLookupByLibrary.simpleMessage("تقديم"),
        "total": MessageLookupByLibrary.simpleMessage("الاجمالي")
      };
}

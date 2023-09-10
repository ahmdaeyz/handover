// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Handover`
  String get appName {
    return Intl.message(
      'Handover',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Something is wrong.`
  String get somethingIsWrong {
    return Intl.message(
      'Something is wrong.',
      name: 'somethingIsWrong',
      desc: '',
      args: [],
    );
  }

  /// `Pickup Time`
  String get pickUpTime {
    return Intl.message(
      'Pickup Time',
      name: 'pickUpTime',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Time`
  String get deliveryTime {
    return Intl.message(
      'Delivery Time',
      name: 'deliveryTime',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `You can't track a shipped package.`
  String get noTrackingShippedMessage {
    return Intl.message(
      'You can\'t track a shipped package.',
      name: 'noTrackingShippedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Shipment #{number}`
  String shipmentNo(Object number) {
    return Intl.message(
      'Shipment #$number',
      name: 'shipmentNo',
      desc: '',
      args: [number],
    );
  }

  /// `My Shipments`
  String get myShipments {
    return Intl.message(
      'My Shipments',
      name: 'myShipments',
      desc: '',
      args: [],
    );
  }

  /// `Shipment Status Update`
  String get shipmentStatusUpdate {
    return Intl.message(
      'Shipment Status Update',
      name: 'shipmentStatusUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Your shipment is being picked up by the driver`
  String get shipmentIsBeingPickup {
    return Intl.message(
      'Your shipment is being picked up by the driver',
      name: 'shipmentIsBeingPickup',
      desc: '',
      args: [],
    );
  }

  /// `Your shipment was successfully delivered`
  String get shipmentIsDelivered {
    return Intl.message(
      'Your shipment was successfully delivered',
      name: 'shipmentIsDelivered',
      desc: '',
      args: [],
    );
  }

  /// `The carrier is near your shipment's pickup point`
  String get carrierIsNearPickup {
    return Intl.message(
      'The carrier is near your shipment\'s pickup point',
      name: 'carrierIsNearPickup',
      desc: '',
      args: [],
    );
  }

  /// `The carrier is near your shipment's delivery point`
  String get carrierIsNearDelivery {
    return Intl.message(
      'The carrier is near your shipment\'s delivery point',
      name: 'carrierIsNearDelivery',
      desc: '',
      args: [],
    );
  }

  /// `In Transit`
  String get inTransit {
    return Intl.message(
      'In Transit',
      name: 'inTransit',
      desc: '',
      args: [],
    );
  }

  /// `Shipped`
  String get shipped {
    return Intl.message(
      'Shipped',
      name: 'shipped',
      desc: '',
      args: [],
    );
  }

  /// `On the way`
  String get onTheWay {
    return Intl.message(
      'On the way',
      name: 'onTheWay',
      desc: '',
      args: [],
    );
  }

  /// `Picked up delivery`
  String get pickedUp {
    return Intl.message(
      'Picked up delivery',
      name: 'pickedUp',
      desc: '',
      args: [],
    );
  }

  /// `Near delivery destination`
  String get nearDelivery {
    return Intl.message(
      'Near delivery destination',
      name: 'nearDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Delivered package`
  String get delivered {
    return Intl.message(
      'Delivered package',
      name: 'delivered',
      desc: '',
      args: [],
    );
  }

  /// `Something wrong happened while downloading parts of the map, Are you sure you have stable internet?`
  String get mapLoadingError {
    return Intl.message(
      'Something wrong happened while downloading parts of the map, Are you sure you have stable internet?',
      name: 'mapLoadingError',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

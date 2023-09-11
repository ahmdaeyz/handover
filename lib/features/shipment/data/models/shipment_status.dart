import 'package:handover/generated/l10n.dart';

enum ShipmentStatus {
  inTransit,
  shipped;

  String get publicName {
    switch (this) {
      case ShipmentStatus.inTransit:
        return S.current.inTransit;
      case ShipmentStatus.shipped:
        return S.current.shipped;
    }
  }
}

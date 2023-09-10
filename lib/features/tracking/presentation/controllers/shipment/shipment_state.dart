part of 'shipment_cubit.dart';

abstract class ShipmentState extends Equatable {
  const ShipmentState();
}

class ShipmentInitial extends ShipmentState {
  @override
  List<Object> get props => [];
}

class ShipmentLoading extends ShipmentState {
  @override
  List<Object?> get props => [];
}

class ShipmentReady extends ShipmentUpdate {
  const ShipmentReady({required super.shipment});
}

class ShipmentUpdate extends ShipmentState {
  final Shipment shipment;

  const ShipmentUpdate({required this.shipment});

  @override
  List<Object?> get props => [shipment];
}

class ShipmentDelivered extends ShipmentUpdate {
  const ShipmentDelivered({required super.shipment});
}

class ShipmentError extends ShipmentState {
  @override
  List<Object?> get props => [];
}

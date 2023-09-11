part of 'shipments_cubit.dart';

abstract class ShipmentsState extends Equatable {
  const ShipmentsState();
}

class ShipmentsInitial extends ShipmentsState {
  @override
  List<Object> get props => [];
}

class ShipmentsLoading extends ShipmentsState {
  @override
  List<Object?> get props => [];
}

class ShipmentsLoaded extends ShipmentsState {
  final List<Shipment> shipments;

  const ShipmentsLoaded({required this.shipments});

  @override
  List<Object?> get props => [shipments];
}

class ShipmentsError extends ShipmentsState {
  @override
  List<Object?> get props => [];
}

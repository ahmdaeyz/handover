import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:handover/features/shipment/data/models/shipment.dart';
import 'package:handover/features/shipment/data/repositories/shipments_repository.dart';

part 'shipments_state.dart';

class ShipmentsCubit extends Cubit<ShipmentsState> {
  final ShipmentsRepository _repository;

  ShipmentsCubit(this._repository) : super(ShipmentsInitial());

  void getShipments() {
    emit(ShipmentsLoading());
    try {
      final shipments = _repository.getShipments();
      emit(ShipmentsLoaded(shipments: shipments));
    } catch (e) {
      emit(ShipmentsError());
    }
  }
}

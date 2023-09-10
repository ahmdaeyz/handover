import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:handover/features/tracking/data/models/shipment.dart';
import 'package:handover/features/tracking/data/repositories/shipments_repository.dart';
import 'package:handover/generated/l10n.dart';

part 'shipment_state.dart';

class ShipmentCubit extends Cubit<ShipmentState> {
  final ShipmentsRepository _repository;

  ShipmentCubit({required ShipmentsRepository repository})
      : _repository = repository,
        super(ShipmentInitial());
  StreamSubscription? _streamSubscription;

  Shipment? get shipment => _shipment;
  Shipment? _shipment;

  List<String> get trackingSteps => [
        S.current.onTheWay,
        S.current.pickedUp,
        S.current.nearDelivery,
        S.current.delivered
      ];

  void listenForShipmentUpdates({required int shipmentId}) {
    if (_streamSubscription != null) return;
    emit(ShipmentLoading());
    _streamSubscription =
        _repository.getShipmentUpdates(shipmentId).listen((event) {
      if (_shipment == null) {
        emit(ShipmentReady(shipment: event));
      } else {
        emit(ShipmentUpdate(shipment: event));
      }
      _shipment = event;
    }, onDone: () {
      emit(ShipmentDelivered(shipment: _shipment!));
    }, onError: (_) {
      emit(ShipmentError());
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    _streamSubscription = null;
    return super.close();
  }
}

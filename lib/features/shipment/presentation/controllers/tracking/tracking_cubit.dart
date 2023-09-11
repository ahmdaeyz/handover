import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:handover/features/shipment/data/models/location_update.dart';
import 'package:handover/features/shipment/data/repositories/shipments_repository.dart';

part 'tracking_state.dart';

class TrackingCubit extends Cubit<TrackingState> {
  final ShipmentsRepository _repository;

  TrackingCubit({required ShipmentsRepository repository})
      : _repository = repository,
        super(TrackingInitial());
  StreamSubscription? _streamSubscription;

  void startTrackingDriver({required int shipmentId}) {
    if (_streamSubscription != null) return;
    emit(TrackingLoading());
    _streamSubscription =
        _repository.getDriverLocationUpdates(shipmentId).listen((event) {
      emit(TrackingUpdate(locationUpdate: event));
    }, onError: (_) {
      emit(TrackingError());
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    _streamSubscription = null;
    return super.close();
  }
}

part of 'tracking_cubit.dart';

abstract class TrackingState extends Equatable {
  const TrackingState();
}

class TrackingInitial extends TrackingState {
  @override
  List<Object> get props => [];
}

class TrackingLoading extends TrackingState {
  @override
  List<Object?> get props => [];
}

class TrackingUpdate extends TrackingState {
  final LocationUpdate locationUpdate;

  const TrackingUpdate({required this.locationUpdate});

  @override
  List<Object?> get props => [locationUpdate];
}

class TrackingError extends TrackingState {
  @override
  List<Object?> get props => [];
}

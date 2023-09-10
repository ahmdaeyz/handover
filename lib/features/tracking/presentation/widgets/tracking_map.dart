import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:handover/core/presentation/utils/error.dart';
import 'package:handover/features/tracking/presentation/controllers/shipment/shipment_cubit.dart';
import 'package:handover/features/tracking/presentation/controllers/tracking/tracking_cubit.dart';
import 'package:handover/features/tracking/presentation/widgets/animated_static_point.dart';
import 'package:handover/features/tracking/presentation/widgets/driver_point.dart';
import 'package:handover/generated/l10n.dart';

class TrackingMap extends StatefulWidget {
  final int shipmentId;

  const TrackingMap({
    Key? key,
    required this.shipmentId,
  }) : super(key: key);

  @override
  State<TrackingMap> createState() => _TrackingMapState();
}

class _TrackingMapState extends State<TrackingMap>
    with TickerProviderStateMixin {
  late final AnimatedMapController _controller =
      AnimatedMapController(vsync: this);

  AnimatedMarker? pickupMarker;

  AnimatedMarker? destinationMarker;

  AnimatedMarker? driverMarker;

  @override
  void initState() {
    super.initState();

    final shipment = context.read<ShipmentCubit>().shipment;
    destinationMarker = AnimatedMarker(
      point: shipment!.deliveryLocation,
      width: 80,
      height: 80,
      builder: (context, animation) => const AnimatedStaticPoint(
        color: Colors.cyan,
      ),
    );

    pickupMarker = AnimatedMarker(
      point: shipment.pickupLocation,
      width: 80,
      height: 80,
      builder: (context, animation) => const AnimatedStaticPoint(
        color: Colors.blueAccent,
      ),
    );

    context
        .read<TrackingCubit>()
        .startTrackingDriver(shipmentId: widget.shipmentId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TrackingCubit, TrackingState>(
      listenWhen: (previous, current) =>
          previous is TrackingLoading && current is TrackingUpdate,
      listener: (context, state) {
        /// First Tracking update after loading
        if (state is TrackingUpdate) {
          final shipment = context.read<ShipmentCubit>().shipment;

          Future.delayed(const Duration(milliseconds: 200), () {
            _controller.centerOnPoints(
                [shipment!.pickupLocation, shipment.deliveryLocation]);
          });
        }
      },
      child: BlocConsumer<TrackingCubit, TrackingState>(
        listener: (context, state) {
          if (state is TrackingUpdate) {
            driverMarker = AnimatedMarker(
              point: state.locationUpdate.current,
              width: 80,
              height: 80,
              builder: (context, animation) => const DriverPoint(),
            );
          }
        },
        buildWhen: (previous, current) =>
            current is TrackingLoading || current is TrackingUpdate,
        builder: (context, state) {
          if (state is TrackingLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TrackingUpdate) {
            return FlutterMap(
              mapController: _controller.mapController,
              options: MapOptions(
                zoom: 10,
              ),
              nonRotatedChildren: const [
                RichAttributionWidget(
                  attributions: [
                    TextSourceAttribution(
                      'OpenStreetMap contributors',
                    ),
                  ],
                ),
              ],
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  errorTileCallback: (_, __, ___) {
                    showErrorMessage(
                        context: context,
                        message: S.of(context).mapLoadingError);
                  },
                ),
                AnimatedMarkerLayer(
                  markers: [
                    if (pickupMarker != null) pickupMarker!,
                    if (driverMarker != null) driverMarker!,
                    if (destinationMarker != null) destinationMarker!
                  ],
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handover/core/application/di/injection_container.dart';
import 'package:handover/features/tracking/data/data_sources/shipments_data_source.dart';
import 'package:handover/features/tracking/data/models/shipment_status.dart';
import 'package:handover/features/tracking/data/repositories/shipments_repository.dart';
import 'package:handover/features/tracking/data/services/shipments_service.dart';
import 'package:handover/features/tracking/presentation/controllers/shipment/shipment_cubit.dart';
import 'package:handover/features/tracking/presentation/controllers/tracking/tracking_cubit.dart';
import 'package:handover/features/tracking/presentation/widgets/shipment_card.dart';
import 'package:handover/features/tracking/presentation/widgets/tracking_map.dart';
import 'package:handover/generated/l10n.dart';

class TrackShipmentPage extends StatefulWidget {
  final int shipmentId;

  const TrackShipmentPage({Key? key, required this.shipmentId})
      : super(key: key);

  @override
  State<TrackShipmentPage> createState() => _TrackShipmentPageState();
}

class _TrackShipmentPageState extends State<TrackShipmentPage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late final repository =
      ShipmentsRepository(ShipmentsDataSourceImpl(ShipmentsService()));

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (_) => ShipmentCubit(repository: getIt())
            ..listenForShipmentUpdates(shipmentId: widget.shipmentId),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => TrackingCubit(repository: getIt()),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  final shipment = context.read<ShipmentCubit>().shipment;

                  Navigator.of(context)
                      .pop(shipment?.status == ShipmentStatus.shipped);
                },
                icon: Icon(Icons.arrow_back),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: BlocBuilder<ShipmentCubit, ShipmentState>(
              buildWhen: (previous, current) =>
                  current is ShipmentError ||
                  current is ShipmentReady ||
                  current is ShipmentLoading,
              builder: (context, state) {
                if (state is ShipmentError) {
                  return Center(
                    child: Text(S.of(context).somethingIsWrong),
                  );
                } else if (state is ShipmentLoading ||
                    state is ShipmentInitial) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Stack(
                  children: [
                    SizedBox(
                      height: 1.sh,
                      width: 1.sw,
                    ),
                    SizedBox(
                      height: 0.6.sh,
                      child: TrackingMap(
                        shipmentId: widget.shipmentId,
                      ),
                    ),
                    const PositionedDirectional(
                      bottom: 0,
                      start: 0,
                      end: 0,
                      child: ShipmentCard(),
                    ),
                  ],
                );
              },
            ));
      }),
    );
  }
}

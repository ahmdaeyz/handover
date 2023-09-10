import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handover/features/tracking/presentation/controllers/shipment/shipment_cubit.dart';
import 'package:handover/features/tracking/presentation/widgets/deliver_timeline.dart';
import 'package:handover/features/tracking/presentation/widgets/shipment_summary.dart';

class ShipmentBody extends StatelessWidget {
  const ShipmentBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShipmentCubit, ShipmentState>(
      builder: (context, state) {
        if (state is ShipmentDelivered) {
          return ShipmentSummary(shipment: state.shipment)
              .animate()
              .slideX(begin: -1, end: 0);
        }
        return DeliveryTimeLine(
          completedSteps:
              (state as ShipmentUpdate).shipment.completedTrackingSteps,
        );
      },
    );
  }
}

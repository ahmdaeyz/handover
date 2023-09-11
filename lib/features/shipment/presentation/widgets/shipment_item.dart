import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handover/core/presentation/utils/error.dart';
import 'package:handover/features/shipment/data/models/shipment.dart';
import 'package:handover/features/shipment/data/models/shipment_status.dart';
import 'package:handover/features/shipment/presentation/controllers/shipments/shipments_cubit.dart';
import 'package:handover/features/shipment/presentation/pages/track_shipment_page.dart';
import 'package:handover/generated/l10n.dart';

class ShipmentItem extends StatelessWidget {
  const ShipmentItem({Key? key, required this.shipment}) : super(key: key);
  final Shipment shipment;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        if (shipment.status != ShipmentStatus.shipped) {
          final shouldReload =
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TrackShipmentPage(
                        shipmentId: shipment.id,
                      )));
          if (shouldReload == true) {
            if (context.mounted) {
              context.read<ShipmentsCubit>().getShipments();
            }
          }
        } else {
          showErrorMessage(
              context: context,
              message: S.of(context).noTrackingShippedMessage);
        }
      },
      title: Text(S.of(context).shipmentNo(shipment.id),
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.w700)),
      subtitle: Text(
        shipment.status.publicName,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: shipment.status == ShipmentStatus.shipped
                ? Colors.green
                : Colors.black),
      ),
      trailing: shipment.status == ShipmentStatus.shipped
          ? null
          : const Icon(Icons.arrow_forward_ios),
    );
  }
}

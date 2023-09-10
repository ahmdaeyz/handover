import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handover/features/tracking/presentation/controllers/shipments/shipments_cubit.dart';
import 'package:handover/features/tracking/presentation/widgets/shipment_item.dart';
import 'package:handover/generated/l10n.dart';

class ShipmentsPage extends StatefulWidget {
  const ShipmentsPage({Key? key}) : super(key: key);

  @override
  State<ShipmentsPage> createState() => _ShipmentsPageState();
}

class _ShipmentsPageState extends State<ShipmentsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ShipmentsCubit>().getShipments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ShipmentsCubit, ShipmentsState>(
          builder: (context, state) {
            if (state is ShipmentsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ShipmentsError) {
              return Center(child: Text(S.of(context).somethingIsWrong));
            } else if (state is ShipmentsLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).myShipments,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: state.shipments.length,
                          itemBuilder: (context, index) =>
                              ShipmentItem(shipment: state.shipments[index])),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

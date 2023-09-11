import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handover/core/application/theme/colors.dart';
import 'package:handover/features/shipment/presentation/controllers/shipment/shipment_cubit.dart';
import 'package:handover/features/shipment/presentation/widgets/shipment_body.dart';

class ShipmentCard extends StatelessWidget {
  const ShipmentCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShipmentCubit, ShipmentState>(
      buildWhen: (previous, current) =>
          current is ShipmentLoading ||
          current is ShipmentReady ||
          current is ShipmentDelivered,
      builder: (context, state) {
        if (state is ShipmentLoading) {
          return const CircularProgressIndicator();
        }
        final initialShipmentData = (state as ShipmentUpdate).shipment;
        final isShipmentDelivered = state is ShipmentDelivered;
        return Stack(
          children: [
            SizedBox(
              height: 0.68.sh,
            ),
            PositionedDirectional(
              bottom: 0,
              start: 0,
              end: 0,
              child: Container(
                height: isShipmentDelivered ? null : 0.41.sh,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 150.h / 2,
                    ),
                    Text(
                      initialShipmentData.driver.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const ShipmentBody()
                  ],
                ),
              ),
            ),
            PositionedDirectional(
              start: 0.5.sw - 150.w / 2,
              bottom: (isShipmentDelivered
                  ? 0.68.sh - 150.h * 1.07
                  : 0.41.sh - 150.h / 2.1),
              child: Container(
                height: 150.h,
                width: 150.w,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[700]!,
                          offset: const Offset(1, 3),
                          blurRadius: 8)
                    ],
                    color: Colors.cyan,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          initialShipmentData.driver.image,
                        ))),
              ),
            )
          ],
        );
      },
    );
  }
}

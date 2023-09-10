import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handover/core/application/theme/colors.dart';
import 'package:handover/features/tracking/presentation/controllers/shipment/shipment_cubit.dart';
import 'package:timelines/timelines.dart';

class DeliveryTimeLine extends StatelessWidget {
  const DeliveryTimeLine({Key? key, required this.completedSteps})
      : super(key: key);
  final int completedSteps;

  @override
  Widget build(BuildContext context) {
    final steps = context.watch<ShipmentCubit>().trackingSteps;
    return Expanded(
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: 16.w),
        child: Timeline.tileBuilder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            theme: TimelineThemeData(
              direction: Axis.vertical,
              nodePosition: -1,
              connectorTheme: const ConnectorThemeData(
                space: 30.0,
                thickness: 5.0,
              ),
            ),
            builder: TimelineTileBuilder.connected(
              connectionDirection: ConnectionDirection.before,
              itemExtentBuilder: (_, __) => 30.h,
              contentsBuilder: (context, index) {
                return Text(
                  steps[index],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        index < completedSteps ? Colors.black : secondaryColor,
                  ),
                );
              },
              indicatorBuilder: (_, index) {
                return DotIndicator(
                  size: 10.0,
                  color: index < completedSteps ? Colors.black : secondaryColor,
                );
              },
              connectorBuilder: (_, index, type) {
                return SolidLineConnector(
                  color: index < completedSteps ? Colors.black : secondaryColor,
                  thickness: 3,
                );
              },
              itemCount: steps.length,
            )),
      ),
    );
  }
}

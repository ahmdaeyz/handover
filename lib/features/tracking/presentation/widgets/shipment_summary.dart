import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handover/features/tracking/data/models/shipment.dart';
import 'package:handover/features/tracking/presentation/widgets/submit_button.dart';
import 'package:handover/features/tracking/presentation/widgets/time_summary.dart';
import 'package:handover/generated/l10n.dart';

class ShipmentSummary extends StatelessWidget {
  final Shipment shipment;

  const ShipmentSummary({Key? key, required this.shipment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context)
        .textTheme
        .titleMedium
        ?.copyWith(fontWeight: FontWeight.w800);
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            children: [
              SizedBox(
                height: 24.h,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      shipment.rating ?? 0,
                      (index) => Icon(
                            Icons.star_rate_rounded,
                            size: 45.h,
                            color: Colors.white,
                          )),
                ),
              ),
              SizedBox(
                height: 48.h,
              ),
              TimeSummary(
                  label: S.of(context).pickUpTime,
                  value: shipment.pickupTimeFormatted),
              SizedBox(
                height: 12.h,
              ),
              TimeSummary(
                  label: S.of(context).deliveryTime,
                  value: shipment.deliveryTimeFormatted),
              SizedBox(
                height: 12.h,
              ),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).total,
                      style: titleStyle,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Text(shipment.totalFormatted,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.w700))
                  ],
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
            ],
          ),
        ),
        PositionedDirectional(
          bottom: 16.h,
          end: 0,
          child: SubmitButton(onTap: () {
            Navigator.of(context).pop(true);
          }),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handover/core/application/theme/colors.dart';
import 'package:handover/features/shipment/presentation/painters/location_icon_painter.dart';

class DriverPoint extends StatelessWidget {
  const DriverPoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        size: Size(30.w, 35.h),
        painter: LocationIconPainter(
            color: secondaryColor, internalCircleColor: primaryColor));
  }
}

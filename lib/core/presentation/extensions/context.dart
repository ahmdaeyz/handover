import 'package:flutter/material.dart';
import 'package:handover/core/application/di/injection_container.dart';
import 'package:logger/logger.dart';

extension XContext on BuildContext {
  void log({Level level = Level.debug, required String? message}) {
    getIt<Logger>().log(level, message?.toString());
  }

  bool get isRtl => Directionality.of(this) == TextDirection.rtl;
}

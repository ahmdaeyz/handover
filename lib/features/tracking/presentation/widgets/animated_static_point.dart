import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedStaticPoint extends StatelessWidget {
  const AnimatedStaticPoint({Key? key, required this.color}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    final boxDecoration = BoxDecoration(color: color, shape: BoxShape.circle);
    const small = 12;
    const medium = 18;
    const large = 50;
    return Stack(
      alignment: Alignment.center,
      children: [
        Opacity(
          opacity: 0.1,
          child: Animate()
              .animate(
                  onPlay: (controller) => controller.repeat(reverse: false))
              .custom(
                builder: (_, value, __) => Container(
                  height: large.h,
                  width: large.w,
                  decoration: boxDecoration,
                ),
              )
              .scale(
                curve: Curves.easeInSine,
                duration: const Duration(milliseconds: 1000),
                begin: Offset.zero,
                end: const Offset(1, 1),
              ),
        ),
        Opacity(
            opacity: 0.5,
            child: Animate()
                .animate(
                    onPlay: (controller) => controller.repeat(reverse: false))
                .custom(
                  builder: (_, value, __) {
                    return Container(
                      height: medium.h,
                      width: medium.w,
                      decoration: boxDecoration,
                    );
                  },
                )
                .scale(
                  curve: Curves.easeInOutQuart,
                  duration: const Duration(milliseconds: 500),
                  begin: Offset.zero,
                  end: const Offset(1, 1),
                )
                .then(delay: const Duration(milliseconds: 100))),
        Container(
          height: small.h,
          width: small.w,
          decoration: boxDecoration,
        ),
      ],
    );
  }
}

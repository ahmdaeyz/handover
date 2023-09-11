import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handover/generated/l10n.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key, required this.onTap}) : super(key: key);
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context)
        .textTheme
        .titleMedium
        ?.copyWith(fontWeight: FontWeight.w800);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.h,
        width: 160.w,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(50),
              bottomStart: Radius.circular(50),
            )),
        child: Padding(
          padding:
              EdgeInsetsDirectional.symmetric(vertical: 8.h, horizontal: 24.w) +
                  EdgeInsetsDirectional.only(start: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).submit,
                style: titleStyle,
              ),
              const Icon(Icons.arrow_forward)
            ],
          ),
        ),
      ),
    );
  }
}

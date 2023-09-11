import 'package:flutter/material.dart';

class TimeSummary extends StatelessWidget {
  const TimeSummary({Key? key, required this.label, required this.value})
      : super(key: key);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context)
        .textTheme
        .titleMedium
        ?.copyWith(fontWeight: FontWeight.w800);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: titleStyle,
        ),
        Text(value, style: Theme.of(context).textTheme.labelLarge)
      ],
    );
  }
}

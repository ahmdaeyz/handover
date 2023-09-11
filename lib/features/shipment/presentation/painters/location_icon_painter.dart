import 'package:flutter/material.dart';

class LocationIconPainter extends CustomPainter {
  final Color color;
  final Color internalCircleColor;
  final path = Path();

  LocationIconPainter({required this.color, required this.internalCircleColor});

  @override
  void paint(Canvas canvas, Size size) {
    path.moveTo(0, size.height / 4);
    path.quadraticBezierTo(
      size.width / 2,
      -size.height / 2.9,
      size.width,
      size.height / 4,
    );
    path.moveTo(size.width / 2, size.height - 4);
    path.lineTo(0, size.height / 4);
    path.lineTo(size.width, size.height / 4);
    path.moveTo(size.width, size.height / 4);
    path.lineTo(size.width / 2, size.height - 4);
    path.close();
    // canvas.drawShadow(path, Colors.grey[500]!, 2.0, false);
    canvas.drawPath(path, Paint()..color = color);
    canvas.drawCircle(Offset(size.width / 2, size.height / 4), size.height / 5,
        Paint()..color = internalCircleColor);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

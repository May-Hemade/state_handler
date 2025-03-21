import 'package:flutter/material.dart';

class OfflineGame extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    if (size.width > 1.0 && size.height > 1.0) {
      print(">1.9");
    }
    var paint =
        Paint()
          ..style = PaintingStyle.fill
          ..isAntiAlias = true;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

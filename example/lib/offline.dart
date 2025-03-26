import 'dart:math';

import 'package:flutter/material.dart';

class OfflineGame extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    if (size.width > 1.0 && size.height > 1.0) {
      print(">1.9");
    }

    var randomMathX = Random().nextDouble() * size.width;
    var randomMathY = Random().nextDouble() * size.height;

    var paint =
        Paint()
          ..style = PaintingStyle.fill
          ..isAntiAlias = true;

    var backgroundPaint =
        Paint()
          ..color = Colors.blueGrey
          ..style = PaintingStyle.fill;

    var circlePaint =
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.stroke;
    canvas.drawRect(
      Rect.fromLTRB(0, 0, size.width, size.height),
      backgroundPaint,
    );
    canvas.drawCircle(
      Offset(randomMathX, randomMathY),
      size.width / 10,
      circlePaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

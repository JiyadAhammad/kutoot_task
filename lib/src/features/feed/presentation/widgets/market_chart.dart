import 'dart:math';

import 'package:flutter/material.dart';

class MarketChartPainter extends CustomPainter {
  final List<double> data;
  final int index;

  MarketChartPainter(this.data, this.index);

  @override
  void paint(Canvas canvas, Size size) {
    if (data.length < 2) return;

    final maxValue = data.reduce(max);
    final minValue = data.reduce(min);
    final range = maxValue - minValue == 0 ? 1 : maxValue - minValue;

    final candleWidth = size.width / data.length;

    final upPaint = Paint()..color = Colors.green;
    final downPaint = Paint()..color = Colors.red;

    final wickPaint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 1;

    final volumePaint = Paint()..color = Colors.blue.withOpacity(0.3);

    final path = Path();
    final fillPath = Path();

    List<Offset> points = [];

    for (int i = 0; i < data.length; i++) {
      final x = i * candleWidth;

      final y =
          size.height - ((data[i] - minValue) / range * size.height * 0.7);

      points.add(Offset(x, y));
    }

    /// 🔥 Smooth curve
    path.moveTo(points.first.dx, points.first.dy);
    fillPath.moveTo(points.first.dx, size.height);

    for (int i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];

      final mid = Offset((p0.dx + p1.dx) / 2, (p0.dy + p1.dy) / 2);

      path.quadraticBezierTo(p0.dx, p0.dy, mid.dx, mid.dy);
      fillPath.quadraticBezierTo(p0.dx, p0.dy, mid.dx, mid.dy);
    }

    path.lineTo(points.last.dx, points.last.dy);
    fillPath.lineTo(points.last.dx, points.last.dy);

    fillPath.lineTo(points.last.dx, size.height);
    fillPath.close();

    /// 🎨 Gradient fill
    final fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.green.withOpacity(0.25), Colors.transparent],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(fillPath, fillPaint);

    /// 📈 Draw smooth line
    final linePaint = Paint()
      ..color = Colors.greenAccent
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, linePaint);

    /// 🕯️ Candlesticks
    for (int i = 1; i < data.length; i++) {
      final open = data[i - 1];
      final close = data[i];

      final high = max(open, close) + Random().nextDouble() * 5;
      final low = min(open, close) - Random().nextDouble() * 5;

      final x = i * candleWidth;

      final openY =
          size.height - ((open - minValue) / range * size.height * 0.7);
      final closeY =
          size.height - ((close - minValue) / range * size.height * 0.7);

      final highY =
          size.height - ((high - minValue) / range * size.height * 0.7);
      final lowY = size.height - ((low - minValue) / range * size.height * 0.7);

      final isUp = close >= open;

      final paint = isUp ? upPaint : downPaint;

      /// Wick
      canvas.drawLine(Offset(x, highY), Offset(x, lowY), wickPaint);

      /// Body
      final rect = Rect.fromLTRB(
        x - candleWidth * 0.3,
        openY,
        x + candleWidth * 0.3,
        closeY,
      );

      canvas.drawRect(rect, paint);

      /// 📊 Volume bars (bottom)
      final volumeHeight = Random().nextDouble() * 20;

      canvas.drawRect(
        Rect.fromLTWH(
          x - candleWidth * 0.3,
          size.height - volumeHeight,
          candleWidth * 0.6,
          volumeHeight,
        ),
        volumePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant MarketChartPainter oldDelegate) {
    return oldDelegate.data != data || oldDelegate.index != index;
  }
}

import 'package:flutter/material.dart';

class EmvChipWidget extends StatelessWidget {
  const EmvChipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 35,
      decoration: BoxDecoration(
        color: const Color(0xFFFFD700).withValues(alpha: 0.8), // Gold
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: Colors.brown.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _ChipPainter(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChipPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.brown.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawLine(Offset(0, size.height * 0.3), Offset(size.width * 0.3, size.height * 0.3), paint);
    canvas.drawLine(Offset(0, size.height * 0.6), Offset(size.width * 0.3, size.height * 0.6), paint);
    canvas.drawLine(Offset(size.width, size.height * 0.3), Offset(size.width * 0.7, size.height * 0.3), paint);
    canvas.drawLine(Offset(size.width, size.height * 0.6), Offset(size.width * 0.7, size.height * 0.6), paint);
    canvas.drawOval(
      Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: size.width * 0.4, height: size.height * 0.5),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

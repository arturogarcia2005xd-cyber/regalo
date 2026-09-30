import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:lu/core/constants/app_colors.dart';

class TulipWaxSeal extends StatelessWidget {
  final double size;
  final bool isBroken;

  const TulipWaxSeal({
    super.key,
    this.size = 70.0,
    this.isBroken = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 300),
      scale: isBroken ? 1.2 : 1.0,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        opacity: isBroken ? 0.0 : 1.0,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: AppColors.starlightYellow.withOpacity(0.3),
                blurRadius: 15,
                spreadRadius: 1,
              ),
            ],
          ),
          child: CustomPaint(
            painter: _WaxSealPainter(),
            child: Center(
              child: Icon(
                Icons.local_florist_rounded, // Tulipán grabado
                size: size * 0.45,
                color: const Color(0xFF5D1212), // Color borgoña grabado en cera
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _WaxSealPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // 1. Base de cera orgánica (borde ligeramente irregular de cera derretida)
    final waxPath = Path();
    const pointsCount = 12;
    for (int i = 0; i < pointsCount; i++) {
      final angle = (i * 2 * math.pi) / pointsCount;
      // Pequeñas variaciones orgánicas en el radio
      final variation = math.sin(i * 3) * 2.5;
      final r = radius + variation;
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);

      if (i == 0) {
        waxPath.moveTo(x, y);
      } else {
        waxPath.lineTo(x, y);
      }
    }
    waxPath.close();

    // Degradado de cera roja estilo lacre tradicional
    final waxGradient = RadialGradient(
      center: const Alignment(-0.3, -0.3),
      colors: [
        const Color(0xFFD32F2F), // Rojo lacre brillante
        const Color(0xFF8E0000), // Rojo borgoña profundo
        const Color(0xFF4A0000), // Sombra de borde
      ],
      stops: const [0.3, 0.8, 1.0],
    );

    final waxPaint = Paint()
      ..shader = waxGradient.createShader(Offset.zero & size)
      ..style = PaintingStyle.fill;

    canvas.drawPath(waxPath, waxPaint);

    // 2. Anillo interno estampado
    final stampRingPaint = Paint()
      ..color = const Color(0xFF5D1212).withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawCircle(center, radius * 0.7, stampRingPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
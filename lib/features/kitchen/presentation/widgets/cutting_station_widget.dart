import 'dart:math';
import 'package:flutter/material.dart';
import '../../services/haptic_service.dart';

class CuttingStationWidget extends StatefulWidget {
  final VoidCallback onSuccess;

  const CuttingStationWidget({super.key, required this.onSuccess});

  @override
  State<CuttingStationWidget> createState() => _CuttingStationWidgetState();
}

class _CuttingStationWidgetState extends State<CuttingStationWidget> with TickerProviderStateMixin {
  int cutsLeft = 5;
  late AnimationController _shakeController;
  late AnimationController _cutLineController;
  late AnimationController _particleController;

  final List<Particle> _particles = [];
  final Random _random = Random();
  bool _isFinished = false;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _cutLineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addListener(() {
      setState(() {
        for (var p in _particles) {
          p.update();
        }
      });
    });
  }

  void _onCut() {
    if (_isFinished) return;

    HapticService.lightImpact();
    _shakeController.forward(from: 0.0);
    _cutLineController.forward(from: 0.0);

    // Generar partículas de corte
    _spawnParticles();

    setState(() {
      cutsLeft--;
    });

    if (cutsLeft <= 0) {
      _isFinished = true;
      HapticService.heavyImpact();
      Future.delayed(const Duration(milliseconds: 300), () {
        widget.onSuccess();
      });
    }
  }

  void _spawnParticles() {
    _particles.clear();
    for (int i = 0; i < 12; i++) {
      final angle = _random.nextDouble() * 2 * pi;
      final speed = _random.nextDouble() * 4 + 2;
      _particles.add(Particle(
        x: 0,
        y: 0,
        vx: cos(angle) * speed,
        vy: sin(angle) * speed,
        color: Colors.amberAccent,
      ));
    }
    _particleController.forward(from: 0.0);
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _cutLineController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedScale(
          scale: cutsLeft > 0 ? 1.0 : 1.2,
          duration: const Duration(milliseconds: 150),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.amber.withOpacity(0.5)),
            ),
            child: Text(
              _isFinished ? '¡CORTADO PERFECTO! ✨' : '🔪 Toques restantes: $cutsLeft',
              style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 30),
        GestureDetector(
          onTap: _onCut,
          child: AnimatedBuilder(
            animation: _shakeController,
            builder: (context, child) {
              final shake = sin(_shakeController.value * pi * 4) * 8.0;
              final scale = 1.0 - (_shakeController.value * 0.15);
              return Transform.translate(
                offset: Offset(shake, 0),
                child: Transform.scale(
                  scale: scale,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Sombra de tabla de cortar
                      Container(
                        width: 170,
                        height: 170,
                        decoration: BoxDecoration(
                          color: const Color(0xFF8B4513),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.amber.withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                      ),
                      // Partículas
                      CustomPaint(
                        painter: ParticlePainter(_particles, _particleController.value),
                      ),
                      // Alimento
                      _isFinished
                          ? const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('🧅', style: TextStyle(fontSize: 45)),
                          SizedBox(width: 8),
                          Text('🧅', style: TextStyle(fontSize: 45)),
                        ],
                      )
                          : const Text('🧅', style: TextStyle(fontSize: 75)),
                      // Líneas de corte animadas
                      AnimatedBuilder(
                        animation: _cutLineController,
                        builder: (context, child) {
                          return Opacity(
                            opacity: 1.0 - _cutLineController.value,
                            child: CustomPaint(
                              size: const Size(120, 120),
                              painter: CutLinePainter(_cutLineController.value),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class Particle {
  double x, y, vx, vy;
  Color color;
  Particle({required this.x, required this.y, required this.vx, required this.vy, required this.color});

  void update() {
    x += vx;
    y += vy;
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double progress;
  ParticlePainter(this.particles, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (var p in particles) {
      paint.color = p.color.withOpacity((1.0 - progress).clamp(0.0, 1.0));
      canvas.drawCircle(Offset(p.x, p.y), 4 * (1.0 - progress), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class CutLinePainter extends CustomPainter {
  final double progress;
  CutLinePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (progress == 0.0 || progress == 1.0) return;
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(size.width * 0.2, size.height * 0.2),
      Offset(size.width * 0.8, size.height * 0.8),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
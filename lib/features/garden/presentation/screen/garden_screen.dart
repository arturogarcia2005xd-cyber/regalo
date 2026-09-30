import 'dart:math' as math;
import 'package:flutter/material.dart';

class GardenScreen extends StatefulWidget {
  const GardenScreen({super.key});

  @override
  State<GardenScreen> createState() => _GardenScreenState();
}

class _GardenScreenState extends State<GardenScreen> {
  final List<Map<String, dynamic>> _bouquets = [
    {
      'title': 'Ramo de Astromelias Blancas',
      'description': 'Lirios blancos radiantes con matices de luz, capullos frescos y follaje denso.',
      'type': 'blancas',
      'color': const Color(0xFF4CAF50),
      'flowerColor': const Color(0xFFFBFBF9),
      'petalColor': const Color(0xFFEFEBE0),
      'centerColor': const Color(0xFFFFD54F),
      'dotsColor': const Color(0xFF5D4037),
    },
    {
      'title': 'Ramo de Gerberas y Lirios Rojos',
      'description': 'Tonos carmesí profundos, volumen multicapa y pétalos aterciopelados.',
      'type': 'rojas',
      'color': const Color(0xFFC2185B),
      'flowerColor': const Color(0xFFD32F2F),
      'petalColor': const Color(0xFFB71C1C),
      'centerColor': const Color(0xFF880E4F),
      'dotsColor': const Color(0xFF311B92),
    },
    {
      'title': 'Ramo de Astromelias Moteadas',
      'description': 'Naranjas incandescentes con patrones de pecas naturales y estambres detallados.',
      'type': 'moteadas',
      'color': const Color(0xFFE65100),
      'flowerColor': const Color(0xFFFF6D00),
      'petalColor': const Color(0xFFFFAB40),
      'centerColor': const Color(0xFFFFE082),
      'dotsColor': const Color(0xFF3E2723),
    },
    // --- NUEVOS RAMOS ---
    {
      'title': 'Ramo de Lirios Azules',
      'description': 'Elegantes lirios en tonos azul zafiro y celeste místico con matices plateados.',
      'type': 'lirios_azules',
      'color': const Color(0xFF1976D2),
      'flowerColor': const Color(0xFF42A5F5),
      'petalColor': const Color(0xFF1565C0),
      'centerColor': const Color(0xFFFFEE58),
      'dotsColor': const Color(0xFF0D47A1),
    },
    {
      'title': 'Ramo de Lirios Rosados',
      'description': 'Dulces lirios rosa pastel con degrades delicados y un aroma visual encantador.',
      'type': 'lirios_rosados',
      'color': const Color(0xFFEC407A),
      'flowerColor': const Color(0xFFF48FB1),
      'petalColor': const Color(0xFFC2185B),
      'centerColor': const Color(0xFFFFF59D),
      'dotsColor': const Color(0xFF880E4F),
    },
    {
      'title': 'Ramo de Rosas',
      'description': 'Clásicas rosas rojas aterciopeladas con pétalos envolventes y follaje profundo.',
      'type': 'rosas',
      'color': const Color(0xFFB71C1C),
      'flowerColor': const Color(0xFFE53935),
      'petalColor': const Color(0xFF8E0000),
      'centerColor': const Color(0xFFB71C1C),
      'dotsColor': const Color(0xFF4A0000),
    },
    {
      'title': 'Ramo de Narcisos',
      'description': 'Luminosas flores amarillas con coronas centrales doradas, llenas de sol y alegría.',
      'type': 'narcisos',
      'color': const Color(0xFFFBC02D),
      'flowerColor': const Color(0xFFFFF176),
      'petalColor': const Color(0xFFFBC02D),
      'centerColor': const Color(0xFFFF8F00),
      'dotsColor': const Color(0xFFE65100),
    },
    {
      'title': 'Ramo de Violetas',
      'description': 'Silvestres y encantadoras violetas de color púrpura intenso con diminutos centros dorados.',
      'type': 'violetas',
      'color': const Color(0xFF7B1FA2),
      'flowerColor': const Color(0xFFAB47BC),
      'petalColor': const Color(0xFF4A148C),
      'centerColor': const Color(0xFFFFEB3B),
      'dotsColor': const Color(0xFF311B92),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF9F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F0E6),
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF4A3728)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Jardín Encantado',
          style: TextStyle(
            color: Color(0xFF2C1D11),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Times New Roman',
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Selecciona un ramo de flores de alta definición',
                style: TextStyle(
                  color: Color(0xFF7A6855),
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Times New Roman',
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: _bouquets.length,
                itemBuilder: (context, index) {
                  final bouquet = _bouquets[index];
                  final Color themeColor = bouquet['color'];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: const Color(0xFFFFFDF9),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => _openAnimatedBouquetModal(context, bouquet),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                width: 90,
                                height: 90,
                                color: themeColor.withValues(alpha: 0.08),
                                child: CustomPaint(
                                  painter: RealisticBouquetPainter(
                                    config: bouquet,
                                    animationProgress: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bouquet['title'],
                                    style: TextStyle(
                                      color: themeColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Times New Roman',
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    bouquet['description'],
                                    style: const TextStyle(
                                      color: Color(0xFF555555),
                                      fontSize: 14,
                                      height: 1.3,
                                      fontFamily: 'Times New Roman',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFFC0B29A),
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openAnimatedBouquetModal(
      BuildContext context, Map<String, dynamic> bouquet) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AnimatedBouquetViewer(bouquet: bouquet),
    );
  }
}

class AnimatedBouquetViewer extends StatefulWidget {
  final Map<String, dynamic> bouquet;

  const AnimatedBouquetViewer({super.key, required this.bouquet});

  @override
  State<AnimatedBouquetViewer> createState() => _AnimatedBouquetViewerState();
}

class _AnimatedBouquetViewerState extends State<AnimatedBouquetViewer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Color(0xFFFFFDF9),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFD0C4B4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.bouquet['title'],
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: 'Times New Roman',
              color: Color(0xFF2C1D11),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            widget.bouquet['description'],
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Times New Roman',
              color: Color(0xFF7A6855),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  size: Size.infinite,
                  painter: RealisticBouquetPainter(
                    config: widget.bouquet,
                    animationProgress: _controller.value,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A3728),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cerrar',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Times New Roman',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RealisticBouquetPainter extends CustomPainter {
  final Map<String, dynamic> config;
  final double animationProgress;

  RealisticBouquetPainter({
    required this.config,
    required this.animationProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final baseCenter = Offset(size.width / 2, size.height * 0.75);

    _drawStems(canvas, baseCenter, size);
    _drawFoliage(canvas, baseCenter, size);
    _drawBuds(canvas, baseCenter, size);
    _drawRealisticFlowers(canvas, baseCenter, size);
  }

  void _drawStems(Canvas canvas, Offset base, Size size) {
    final stemPaint = Paint()
      ..color = const Color(0xFF2E5A1C)
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final stemLightPaint = Paint()
      ..color = const Color(0xFF4CAF50)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final stemX = [-30.0, -15.0, 0.0, 15.0, 30.0];
    for (var x in stemX) {
      final path = Path()
        ..moveTo(base.dx + (x * 0.2), base.dy + 60)
        ..quadraticBezierTo(
          base.dx + (x * 0.6), base.dy - 30,
          base.dx + (x * 1.5), base.dy - 120,
        );
      canvas.drawPath(path, stemPaint);
      canvas.drawPath(path, stemLightPaint);
    }
  }

  void _drawFoliage(Canvas canvas, Offset base, Size size) {
    final leafDark = Paint()..color = const Color(0xFF1B4314);
    final leafLight = Paint()..color = const Color(0xFF388E3C);

    final leaves = [
      {'angle': -0.8, 'scale': 1.2, 'x': -40.0, 'y': -80.0},
      {'angle': 0.8, 'scale': 1.2, 'x': 40.0, 'y': -80.0},
      {'angle': -1.2, 'scale': 0.9, 'x': -60.0, 'y': -50.0},
      {'angle': 1.2, 'scale': 0.9, 'x': 60.0, 'y': -50.0},
      {'angle': -0.3, 'scale': 1.1, 'x': -20.0, 'y': -110.0},
      {'angle': 0.3, 'scale': 1.1, 'x': 20.0, 'y': -110.0},
    ];

    for (var l in leaves) {
      final ox = base.dx + (l['x'] as double);
      final oy = base.dy + (l['y'] as double);
      final angle = l['angle'] as double;
      final scale = l['scale'] as double;

      canvas.save();
      canvas.translate(ox, oy);
      canvas.rotate(angle);
      canvas.scale(scale);

      final p = Path()
        ..moveTo(0, 0)
        ..quadraticBezierTo(-20, -40, 0, -80)
        ..quadraticBezierTo(20, -40, 0, 0);

      canvas.drawPath(p, leafDark);

      final p2 = Path()
        ..moveTo(0, 0)
        ..quadraticBezierTo(-10, -40, 0, -80)
        ..quadraticBezierTo(5, -40, 0, 0);
      canvas.drawPath(p2, leafLight);

      canvas.restore();
    }
  }

  void _drawBuds(Canvas canvas, Offset base, Size size) {
    final budPaint = Paint()..color = const Color(0xFF8BC34A);
    final budTip = Paint()..color = config['flowerColor'];

    final buds = [
      Offset(base.dx - 65, base.dy - 160),
      Offset(base.dx + 65, base.dy - 160),
      Offset(base.dx, base.dy - 220),
    ];

    for (int i = 0; i < buds.length; i++) {
      final b = buds[i];
      final sway = math.sin(animationProgress * math.pi * 2 + i) * 3;
      final pos = Offset(b.dx + sway, b.dy);

      final p = Path()
        ..moveTo(pos.dx, pos.dy + 15)
        ..quadraticBezierTo(pos.dx - 10, pos.dy - 5, pos.dx, pos.dy - 20)
        ..quadraticBezierTo(pos.dx + 10, pos.dy - 5, pos.dx, pos.dy + 15);

      canvas.drawPath(p, budPaint);
      canvas.drawCircle(Offset(pos.dx, pos.dy - 15), 4, budTip);
    }
  }

  void _drawRealisticFlowers(Canvas canvas, Offset base, Size size) {
    final flowers = [
      {'pos': Offset(base.dx - 50, base.dy - 110), 'scale': 0.85},
      {'pos': Offset(base.dx + 50, base.dy - 110), 'scale': 0.85},
      {'pos': Offset(base.dx - 30, base.dy - 170), 'scale': 0.9},
      {'pos': Offset(base.dx + 30, base.dy - 170), 'scale': 0.9},
      {'pos': Offset(base.dx, base.dy - 130), 'scale': 1.15},
    ];

    for (int i = 0; i < flowers.length; i++) {
      final pos = flowers[i]['pos'] as Offset;
      final scale = flowers[i]['scale'] as double;
      final sway = math.sin(animationProgress * math.pi * 2 + i) * 2.5;

      canvas.save();
      canvas.translate(pos.dx + sway, pos.dy);
      canvas.scale(scale);

      final String type = config['type'];
      if (type == 'rosas') {
        _drawSingleRose(canvas);
      } else if (type == 'narcisos') {
        _drawSingleDaffodil(canvas);
      } else if (type == 'violetas') {
        _drawSingleViolet(canvas);
      } else {
        _drawSingleLily(canvas);
      }

      canvas.restore();
    }
  }

  // Lirios (Blancas, Rojas, Moteadas, Lirios Azules, Lirios Rosados)
  void _drawSingleLily(Canvas canvas) {
    final Color primaryColor = config['flowerColor'];
    final Color darkColor = config['petalColor'];
    final Color centerColor = config['centerColor'];
    final Color dotsColor = config['dotsColor'];

    const int petals = 6;
    for (int p = 0; p < petals; p++) {
      final angle = (p * 2 * math.pi / petals);

      canvas.save();
      canvas.rotate(angle);

      final path = Path()
        ..moveTo(0, 0)
        ..quadraticBezierTo(-22, -35, 0, -70)
        ..quadraticBezierTo(22, -35, 0, 0);

      final gradient = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [darkColor, primaryColor, const Color(0xFFFFFFFF)],
        stops: const [0.0, 0.6, 1.0],
      );

      final paint = Paint()
        ..shader = gradient.createShader(const Rect.fromLTWH(-25, -70, 50, 70));

      canvas.drawPath(path, paint);

      final nervePaint = Paint()
        ..color = darkColor.withValues(alpha: 0.6)
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke;

      canvas.drawLine(const Offset(0, 0), const Offset(0, -55), nervePaint);

      if (config['type'] == 'moteadas' || config['type'] == 'blancas' || config['type'] == 'lirios_rosados') {
        final dotPaint = Paint()..color = dotsColor;
        final random = math.Random(p);
        for (int d = 0; d < 8; d++) {
          final dx = (random.nextDouble() - 0.5) * 16;
          final dy = -15 - random.nextDouble() * 30;
          canvas.drawCircle(Offset(dx, dy), 1.2, dotPaint);
        }
      }

      canvas.restore();
    }

    final pistilPaint = Paint()
      ..color = const Color(0xFF81C784)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final antherPaint = Paint()..color = centerColor;

    for (int st = 0; st < 6; st++) {
      final stAngle = (st * 2 * math.pi / 6) + 0.5;
      final px = math.cos(stAngle) * 20;
      final py = math.sin(stAngle) * 20;

      canvas.drawLine(Offset.zero, Offset(px, py), pistilPaint);
      canvas.drawCircle(Offset(px, py), 3.5, antherPaint);
    }

    canvas.drawCircle(Offset.zero, 6, Paint()..color = centerColor);
  }

  // Rosas
  void _drawSingleRose(Canvas canvas) {
    final Color primaryColor = config['flowerColor'];
    final Color darkColor = config['petalColor'];

    // Capas de pétalos envolventes
    for (int ring = 4; ring >= 1; ring--) {
      final double radius = ring * 10.0;
      final int petalsInRing = ring * 3;

      for (int i = 0; i < petalsInRing; i++) {
        final double angle = (i * 2 * math.pi / petalsInRing) + (ring * 0.4);
        final dx = math.cos(angle) * (radius * 0.6);
        final dy = math.sin(angle) * (radius * 0.6);

        final p = Path()
          ..addOval(Rect.fromCenter(
            center: Offset(dx, dy),
            width: radius * 1.3,
            height: radius * 1.5,
          ));

        final paint = Paint()
          ..color = Color.lerp(darkColor, primaryColor, ring / 4.0)!
          ..style = PaintingStyle.fill;

        canvas.drawPath(p, paint);
      }
    }

    // Centro capullo cerrado
    canvas.drawCircle(Offset.zero, 8, Paint()..color = darkColor);
    canvas.drawCircle(const Offset(-2, -2), 4, Paint()..color = primaryColor);
  }

  // Narcisos
  void _drawSingleDaffodil(Canvas canvas) {
    final Color petalColor = config['flowerColor'];
    final Color cupColor = config['centerColor'];

    // 6 pétalos de estrella
    for (int p = 0; p < 6; p++) {
      final angle = (p * 2 * math.pi / 6);
      canvas.save();
      canvas.rotate(angle);

      final path = Path()
        ..moveTo(0, 0)
        ..quadraticBezierTo(-20, -30, 0, -55)
        ..quadraticBezierTo(20, -30, 0, 0);

      canvas.drawPath(path, Paint()..color = petalColor);
      canvas.restore();
    }

    // Corona/Trompeta central
    canvas.drawCircle(Offset.zero, 18, Paint()..color = cupColor);
    canvas.drawCircle(Offset.zero, 14, Paint()..color = const Color(0xFFFFB300));
    canvas.drawCircle(Offset.zero, 6, Paint()..color = const Color(0xFFFFF59D));
  }

  // Violetas
  void _drawSingleViolet(Canvas canvas) {
    final Color mainColor = config['flowerColor'];
    final Color darkColor = config['petalColor'];

    // 5 pétalos redondeados asimétricos
    const int petals = 5;
    for (int p = 0; p < petals; p++) {
      final angle = (p * 2 * math.pi / petals);
      final double radius = (p == 3 || p == 4) ? 28.0 : 22.0;

      final dx = math.cos(angle) * 12;
      final dy = math.sin(angle) * 12;

      final path = Path()
        ..addOval(Rect.fromCenter(
          center: Offset(dx, dy),
          width: radius * 1.2,
          height: radius * 1.4,
        ));

      canvas.drawPath(path, Paint()..color = (p % 2 == 0) ? mainColor : darkColor);
    }

    // Ojo central amarillo
    canvas.drawCircle(Offset.zero, 4, Paint()..color = config['centerColor']);
  }

  @override
  bool shouldRepaint(covariant RealisticBouquetPainter oldDelegate) => true;
}
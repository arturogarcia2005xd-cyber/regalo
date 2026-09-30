import 'dart:math';
import 'package:flutter/material.dart';

// Imports del proyecto
import 'package:lu/features/kitchen/config/game_config.dart';
import 'package:lu/features/kitchen/logic/kitchen_game_controller.dart';
import 'package:lu/features/kitchen/models/recipe_step_model.dart';
import 'package:lu/features/kitchen/presentation/widgets/cutting_station_widget.dart';
import 'package:lu/features/kitchen/presentation/widgets/frying_station_widget.dart';
import 'package:lu/features/kitchen/presentation/widgets/order_ticket_widget.dart';
import 'package:lu/features/kitchen/presentation/widgets/oven_station_widget.dart';
import 'package:lu/features/kitchen/presentation/widgets/plating_station_widget.dart';
import 'package:lu/features/kitchen/presentation/screens/game_over_screen.dart';

class KitchenGameScreen extends StatefulWidget {
  const KitchenGameScreen({super.key});

  @override
  State<KitchenGameScreen> createState() => _KitchenGameScreenState();
}

class _KitchenGameScreenState extends State<KitchenGameScreen> with SingleTickerProviderStateMixin {
  late final KitchenGameController controller;
  late AnimationController _steamController;

  @override
  void initState() {
    super.initState();
    controller = KitchenGameController();
    controller.addListener(_onControllerUpdate);
    controller.startGame();

    // Animación continua para el vapor de la cocina
    _steamController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  void _onControllerUpdate() {
    if (controller.isGameOver) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => GameOverScreen(score: controller.score)),
      );
    } else {
      setState(() {});
    }
  }

  @override
  void dispose() {
    controller.removeListener(_onControllerUpdate);
    controller.dispose();
    _steamController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final order = controller.selectedOrder;

    return Scaffold(
      body: Stack(
        children: [
          // 1. FONDO ILUSTRADO TIPO OVERCOOKED (Azulejos + Encimera de Madera)
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _steamController,
              builder: (context, child) {
                return CustomPaint(
                  painter: KitchenBackgroundPainter(_steamController.value),
                );
              },
            ),
          ),

          // 2. CONTENIDO Y ESTACIONES
          SafeArea(
            child: Column(
              children: [
                // Encabezado con barra de estado y estilo de restaurante
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B).withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.amber.withValues(alpha: 0.4), width: 1.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        '⭐ ${controller.score} Pts',
                        style: const TextStyle(fontSize: 18, color: Colors.amber, fontWeight: FontWeight.bold),
                      ),
                      if (controller.comboCount > 1)
                        AnimatedScale(
                          scale: 1.1,
                          duration: const Duration(milliseconds: 150),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'x${controller.comboCount} COMBO! 🔥',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                        ),
                      Text(
                        '❤️ ${controller.reputation}',
                        style: const TextStyle(fontSize: 18, color: Colors.redAccent, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                // Lista de Comandas / Tickets colgantes
                SizedBox(
                  height: 95,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: controller.activeOrders.length,
                    itemBuilder: (context, index) {
                      final item = controller.activeOrders[index];
                      return OrderTicketWidget(
                        order: item,
                        isSelected: item.id == order?.id,
                        onTap: () => controller.selectOrder(item),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 10),

                // Estación de cocina con vista temática
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(
                        scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
                        child: FadeTransition(opacity: animation, child: child),
                      );
                    },
                    child: order == null
                        ? const Center(
                      child: Text(
                        '👨‍🍳 ¡Esperando nuevos pedidos para Lucía! 🌷',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    )
                        : KeyedSubtree(
                      key: ValueKey('${order.id}_${order.currentStepIndex}'),
                      child: Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.35),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.amber.withValues(alpha: 0.3), width: 2),
                        ),
                        child: _buildStationView(order.recipe.steps[order.currentStepIndex]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStationView(RecipeStep step) {
    switch (step.station) {
      case StationType.cutting:
        return CuttingStationWidget(onSuccess: controller.completeCurrentStepSuccess);
      case StationType.frying:
        return FryingStationWidget(
          targetTime: step.targetTimeSeconds,
          onSuccess: controller.completeCurrentStepSuccess,
          onFailure: controller.failActionPenalization,
        );
      case StationType.oven:
        return OvenStationWidget(
          targetTime: step.targetTimeSeconds,
          onSuccess: controller.completeCurrentStepSuccess,
          onFailure: controller.failActionPenalization,
        );
      case StationType.plating:
        return PlatingStationWidget(onSuccess: controller.completeCurrentStepSuccess);
    }
  }
}

// CustomPainter para dibujar la Cocina Ilustrada estilo Overcooked
class KitchenBackgroundPainter extends CustomPainter {
  final double animationProgress;

  KitchenBackgroundPainter(this.animationProgress);

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Azulejos de la pared (Azul océano Ponyo + Tono suave)
    final wallPaint = Paint()..color = const Color(0xFF152238);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height * 0.55), wallPaint);

    final tileGridPaint = Paint()
      ..color = const Color(0xFF1E3A8A).withValues(alpha: 0.3)
      ..strokeWidth = 1.5;

    double tileSize = 40.0;
    for (double x = 0; x < size.width; x += tileSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height * 0.55), tileGridPaint);
    }
    for (double y = 0; y < size.height * 0.55; y += tileSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), tileGridPaint);
    }

    // 2. Encimera de Madera Cálida (Mesa de preparación)
    final counterRect = Rect.fromLTWH(0, size.height * 0.50, size.width, size.height * 0.50);
    final counterGradient = const LinearGradient(
      colors: [Color(0xFF8B4513), Color(0xFF5C2C06)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).createShader(counterRect);

    final counterPaint = Paint()..shader = counterGradient;
    canvas.drawRect(counterRect, counterPaint);

    // Borde de madera superior
    final borderPaint = Paint()
      ..color = const Color(0xFFA0522D)
      ..strokeWidth = 6;
    canvas.drawLine(Offset(0, size.height * 0.50), Offset(size.width, size.height * 0.50), borderPaint);

    // 3. Vapor de Cocina Flotante
    final steamPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.12)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 5; i++) {
      double offsetX = (size.width / 5) * i + 30;
      double offsetY = (size.height * 0.6) - ((animationProgress * 60 + (i * 20)) % 60);
      canvas.drawCircle(Offset(offsetX, offsetY), 12 + (i % 3) * 4, steamPaint);
    }
  }

  @override
  bool shouldRepaint(covariant KitchenBackgroundPainter oldDelegate) => true;
}
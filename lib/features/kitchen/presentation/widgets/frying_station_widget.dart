import 'dart:async';
import 'package:flutter/material.dart';
import '../../services/haptic_service.dart';

class FryingStationWidget extends StatefulWidget {
  final double targetTime;
  final VoidCallback onSuccess;
  final VoidCallback onFailure;

  const FryingStationWidget({
    super.key,
    required this.targetTime,
    required this.onSuccess,
    required this.onFailure,
  });

  @override
  State<FryingStationWidget> createState() => _FryingStationWidgetState();
}

class _FryingStationWidgetState extends State<FryingStationWidget> {
  double indicatorPosition = 0.0; // 0.0 a 1.0
  bool isMovingUp = true;
  bool isHolding = false;
  Timer? _loopTimer;

  @override
  void initState() {
    super.initState();
    _startIndicatorLoop();
  }

  void _startIndicatorLoop() {
    _loopTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (!mounted) return;
      setState(() {
        if (isMovingUp) {
          indicatorPosition += 0.02;
          if (indicatorPosition >= 1.0) isMovingUp = false;
        } else {
          indicatorPosition -= 0.02;
          if (indicatorPosition <= 0.0) isMovingUp = true;
        }
      });
    });
  }

  void _onPressDown() {
    HapticService.lightImpact();
    setState(() => isHolding = true);
  }

  void _onPressUp() {
    if (!isHolding) return;
    setState(() => isHolding = false);

    // La zona verde perfecta está entre 0.42 y 0.68
    if (indicatorPosition >= 0.42 && indicatorPosition <= 0.68) {
      HapticService.heavyImpact();
      widget.onSuccess();
    } else {
      HapticService.errorVibration();
      widget.onFailure();
    }
  }

  @override
  void dispose() {
    _loopTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Cambio visual del alimento según la posición del medidor
    Color foodTone = Colors.red.shade300;
    if (indicatorPosition >= 0.42 && indicatorPosition <= 0.68) {
      foodTone = Colors.amber.shade600; // Punto perfecto
    } else if (indicatorPosition > 0.68) {
      foodTone = Colors.brown.shade800; // Casi quemado
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '🔥 Mantén presionado y suelta en la ZONA VERDE',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Barra vertical de precisión
            Container(
              width: 30,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.black45, // Corregido: 'black45' en lugar de 'black50'
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white24),
              ),
              child: Stack(
                children: [
                  // Zona verde objetivo
                  Positioned(
                    top: 200 * 0.32,
                    left: 0,
                    right: 0,
                    height: 200 * 0.26,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  // Aguja indicadora
                  Positioned(
                    bottom: (200 - 16) * indicatorPosition,
                    left: 2,
                    right: 2,
                    child: Container(
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: const [
                          BoxShadow(color: Colors.amber, blurRadius: 8),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 40),
            // Sartén interactiva
            GestureDetector(
              onTapDown: (_) => _onPressDown(),
              onTapUp: (_) => _onPressUp(),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: foodTone,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isHolding ? Colors.amber : Colors.white30,
                    width: 4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isHolding
                          ? Colors.orange.withValues(alpha: 0.5)
                          : Colors.black45, // Corregido 'black45'
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text('🥩', style: TextStyle(fontSize: 65)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
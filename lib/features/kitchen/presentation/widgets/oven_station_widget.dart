import 'dart:async';
import 'package:flutter/material.dart';
import '../../services/haptic_service.dart';

class OvenStationWidget extends StatefulWidget {
  final double targetTime;
  final VoidCallback onSuccess;
  final VoidCallback onFailure;

  const OvenStationWidget({
    super.key,
    required this.targetTime,
    required this.onSuccess,
    required this.onFailure,
  });

  @override
  State<OvenStationWidget> createState() => _OvenStationWidgetState();
}

class _OvenStationWidgetState extends State<OvenStationWidget> with SingleTickerProviderStateMixin {
  double progress = 0.0;
  bool inOven = false;
  Timer? _timer;
  late AnimationController _alertController;

  @override
  void initState() {
    super.initState();
    _alertController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..repeat(reverse: true);
  }

  void _startOven() {
    HapticService.lightImpact();
    setState(() {
      inOven = true;
      progress = 0.0;
    });

    _timer = Timer.periodic(const Duration(milliseconds: 50), (t) {
      setState(() {
        progress += 0.02;
        if (progress >= 1.0) {
          _timer?.cancel();
          HapticService.errorVibration();
          widget.onFailure();
        }
      });
    });
  }

  void _stopOven() {
    _timer?.cancel();
    HapticService.heavyImpact();

    // Tiempo ideal: entre el 70% y el 90%
    if (progress >= 0.65 && progress <= 0.90) {
      widget.onSuccess();
    } else {
      widget.onFailure();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _alertController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isWarning = progress > 0.65;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('🔥 Saca la bandeja antes de que se queme', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 25),
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 160,
              height: 160,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 12,
                backgroundColor: Colors.white12,
                color: isWarning ? Colors.redAccent : Colors.orangeAccent,
              ),
            ),
            AnimatedBuilder(
              animation: _alertController,
              builder: (context, child) {
                return Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isWarning ? Colors.red.withOpacity(_alertController.value * 0.4) : Colors.transparent,
                  ),
                  child: const Center(child: Text('🥐', style: TextStyle(fontSize: 60))),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: inOven ? Colors.redAccent : Colors.amber,
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          onPressed: inOven ? _stopOven : _startOven,
          child: Text(
            inOven ? '¡SACAR AHORA!' : 'Hornear 🥐',
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
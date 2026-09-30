import 'package:flutter/material.dart';
import '../../services/haptic_service.dart';

class PlatingStationWidget extends StatefulWidget {
  final VoidCallback onSuccess;

  const PlatingStationWidget({super.key, required this.onSuccess});

  @override
  State<PlatingStationWidget> createState() => _PlatingStationWidgetState();
}

class _PlatingStationWidgetState extends State<PlatingStationWidget> {
  bool _isPlaced = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('🍽️ Arrastra el alimento terminado al plato',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _isPlaced
                ? const SizedBox(width: 80, height: 80)
                : Draggable<String>(
              data: 'food',
              feedback: const Material(
                color: Colors.transparent,
                child: Text('🍱', style: TextStyle(fontSize: 70)),
              ),
              childWhenDragging: const Opacity(opacity: 0.2, child: Text('🍱', style: TextStyle(fontSize: 70))),
              child: const Text('🍱', style: TextStyle(fontSize: 70)),
            ),
            DragTarget<String>(
              onAcceptWithDetails: (_) {
                HapticService.heavyImpact();
                setState(() => _isPlaced = true);
                Future.delayed(const Duration(milliseconds: 300), widget.onSuccess);
              },
              builder: (context, candidateData, rejectedData) {
                final isHover = candidateData.isNotEmpty;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: isHover ? Colors.amber.withOpacity(0.3) : Colors.white10,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isHover ? Colors.amber : Colors.white30,
                      width: 3,
                    ),
                  ),
                  child: Center(
                    child: Text(_isPlaced ? '🍱' : '🍽️', style: const TextStyle(fontSize: 50)),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
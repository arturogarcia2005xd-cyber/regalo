import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:lu/core/constants/app_colors.dart';

class FloatingBubbleWidget extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color accentColor;
  final VoidCallback onTap;
  final double size;
  final double floatOffset;

  const FloatingBubbleWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.accentColor,
    required this.onTap,
    this.size = 110.0,
    this.floatOffset = 0.0,
  });

  @override
  State<FloatingBubbleWidget> createState() => _FloatingBubbleWidgetState();
}

class _FloatingBubbleWidgetState extends State<FloatingBubbleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000 + (widget.floatOffset * 1000).toInt()),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _floatController,
      builder: (context, child) {
        // Movimiento flotante suave vertical y leve oscilación lateral
        double dy = math.sin((_floatController.value + widget.floatOffset) * math.pi * 2) * 12;
        double dx = math.cos((_floatController.value + widget.floatOffset) * math.pi * 2) * 6;

        return Transform.translate(
          offset: Offset(dx, dy),
          child: GestureDetector(
            onTap: widget.onTap,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        widget.accentColor.withOpacity(0.4),
                        widget.accentColor.withOpacity(0.1),
                        AppColors.warmWhite.withOpacity(0.25),
                      ],
                      stops: const [0.2, 0.7, 1.0],
                      center: const Alignment(-0.3, -0.3),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: widget.accentColor.withOpacity(0.35),
                        blurRadius: 18,
                        spreadRadius: 2,
                      ),
                    ],
                    border: Border.all(
                      color: AppColors.warmWhite.withOpacity(0.6),
                      width: 1.5,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Reflejo de luz superior en la burbuja
                      Positioned(
                        top: widget.size * 0.15,
                        left: widget.size * 0.2,
                        child: Container(
                          width: widget.size * 0.25,
                          height: widget.size * 0.12,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      // Icono central
                      Icon(
                        widget.icon,
                        size: widget.size * 0.4,
                        color: AppColors.starlightYellow,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.nightNavy.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: widget.accentColor.withOpacity(0.4)),
                  ),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: AppColors.warmWhite,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      shadows: [
                        Shadow(
                          color: AppColors.nightNavy,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
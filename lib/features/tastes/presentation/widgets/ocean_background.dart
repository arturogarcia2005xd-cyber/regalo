import 'package:flutter/material.dart';

class OceanBackground extends StatelessWidget {
  final Widget child;

  const OceanBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // GIF de fondo marino animado
        Positioned.fill(
          child: Image.asset(
            'lib/assets/hola.gif',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(color: const Color(0xFF0A192F));
            },
          ),
        ),
        // Capa translúcida para contraste
        Positioned.fill(
          child: Container(
            color: const Color(0xFF0A192F).withValues(alpha: 0.40),
          ),
        ),
        // Contenido sobre el fondo
        SafeArea(child: child),
      ],
    );
  }
}
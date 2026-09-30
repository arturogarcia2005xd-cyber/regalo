import 'package:flutter/material.dart';

class EnvelopeWidget extends StatelessWidget {
  final bool isOpen;
  final VoidCallback onTap;

  const EnvelopeWidget({
    super.key,
    required this.isOpen,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: 280,
        height: 180,
        decoration: BoxDecoration(
          color: const Color(0xFF1E3A8A), // Azul océano profundo
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(
            color: const Color(0xFF93C5FD).withValues(alpha: 0.5),
            width: 2,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Sello de lacre o adorno de Tulipán en el centro
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedScale(
                  duration: const Duration(milliseconds: 300),
                  scale: isOpen ? 0.8 : 1.0,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2C94C), // Dorado suave
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 6,
                        )
                      ],
                    ),
                    child: const Text('🌷', style: TextStyle(fontSize: 32)),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  isOpen ? '¡Haz tap para cerrar!' : 'Tocame para abrir 💌',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
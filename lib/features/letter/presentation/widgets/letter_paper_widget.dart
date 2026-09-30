import 'package:flutter/material.dart';

class LetterPaperWidget extends StatelessWidget {
  final String letterText;

  const LetterPaperWidget({super.key, required this.letterText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF7), // Tono pergamino suave
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('🌷', style: TextStyle(fontSize: 20)),
                Text(
                  '17 Años ✨',
                  style: TextStyle(
                    fontFamily: 'Serif',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
                Text('🌷', style: TextStyle(fontSize: 20)),
              ],
            ),
            const Divider(height: 24, thickness: 1, color: Color(0xFFE2E8F0)),
            SelectableText(
              letterText,
              style: const TextStyle(
                fontSize: 16,
                height: 1.8,
                color: Color(0xFF2D3748),
                fontFamily: 'Serif',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
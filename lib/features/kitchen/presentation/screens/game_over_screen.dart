import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  final int score;

  const GameOverScreen({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('👩‍🍳✨', style: TextStyle(fontSize: 70)),
              const SizedBox(height: 16),
              const Text(
                '¡Servicio Finalizado!',
                style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Puntuación total: $score pts',
                style: const TextStyle(color: Colors.amber, fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0284C7),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.replay, color: Colors.white),
                label: const Text('Volver a Intentar', style: TextStyle(color: Colors.white, fontSize: 16)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
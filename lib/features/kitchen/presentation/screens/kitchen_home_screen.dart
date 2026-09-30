import 'package:flutter/material.dart';
import '../../config/game_config.dart';
import '../../services/score_storage_service.dart';
import 'kitchen_game_screen.dart';

class KitchenHomeScreen extends StatelessWidget {
  const KitchenHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameConfig.primaryBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🍳 CHEF PRO 🍳', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Servicio de Repostería & Cocina', style: TextStyle(color: Colors.amber, fontSize: 16)),
              const SizedBox(height: 30),
              FutureBuilder<int>(
                future: ScoreStorageService.getHighScore(),
                builder: (context, snapshot) {
                  return Text(
                    '🏆 Récord Máximo: ${snapshot.data ?? 0}',
                    style: const TextStyle(color: Colors.white70, fontSize: 18),
                  );
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: GameConfig.accentOrange,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const KitchenGameScreen()),
                  );
                },
                child: const Text('¡Iniciar Servicio!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
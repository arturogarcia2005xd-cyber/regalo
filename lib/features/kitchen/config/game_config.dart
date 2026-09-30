import 'package:flutter/material.dart';

/// Configuración central de balance del juego.
/// Ajusta estos valores para cambiar la dificultad, velocidad y puntuación.
class GameConfig {
  static const int maxSimultaneousOrders = 4;
  static const int initialReputation = 100;
  static const int penaltyOrderExpired = 20;
  static const int penaltyBurnedFood = 15;

  // Tiempos en segundos por comanda (Paciencia del cliente)
  static const double baseOrderPatienceSeconds = 25.0;

  // Puntuación
  static const int pointsPerfect = 100;
  static const int pointsGood = 70;
  static const int pointsOk = 40;
  static const double comboMultiplierStep = 0.5;

  // Eventos Aleatorios
  static const double vipPatienceMultiplier = 0.7; // Paciencia más corta
  static const int vipBonusPoints = 200;            // Puntos extra

  // Colores de la UI del Juego
  static const Color primaryBg = Color(0xFF1E293B);
  static const Color cardBg = Color(0xFF334155);
  static const Color accentOrange = Color(0xFFF97316);
  static const Color accentGreen = Color(0xFF22C55E);
  static const Color accentRed = Color(0xFFEF4444);
}
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../config/game_config.dart';
import '../models/order_model.dart';
import '../models/recipe_model.dart';
import '../models/recipe_step_model.dart';
import '../services/haptic_service.dart';
import '../services/score_storage_service.dart';

class KitchenGameController extends ChangeNotifier {
  int score = 0;
  int comboCount = 0;
  int reputation = GameConfig.initialReputation;
  bool isGameOver = false;
  bool isPaused = false;

  List<KitchenOrder> activeOrders = [];
  KitchenOrder? selectedOrder;

  Timer? _gameLoopTimer;
  Timer? _orderSpawnerTimer;
  final Random _random = Random();

  void startGame() {
    score = 0;
    comboCount = 0;
    reputation = GameConfig.initialReputation;
    isGameOver = false;
    isPaused = false;
    activeOrders.clear();

    // Generar comandas iniciales
    _spawnOrder();
    _spawnOrder();

    // Loop de tiempo a 10 ticks por segundo para actualización suave
    _gameLoopTimer?.cancel();
    _gameLoopTimer = Timer.periodic(const Duration(milliseconds: 100), _updateGameTick);

    // Generador de nuevas comandas cada 7 segundos
    _orderSpawnerTimer?.cancel();
    _orderSpawnerTimer = Timer.periodic(const Duration(seconds: 7), (_) {
      if (!isPaused && !isGameOver && activeOrders.length < GameConfig.maxSimultaneousOrders) {
        _spawnOrder();
      }
    });
  }

  void _spawnOrder() {
    final recipe = masterRecipes[_random.nextInt(masterRecipes.length)];
    final isVIP = _random.nextDouble() < 0.2; // 20% probabilidad de cliente VIP

    double patience = GameConfig.baseOrderPatienceSeconds;
    if (isVIP) patience *= GameConfig.vipPatienceMultiplier;

    final order = KitchenOrder(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      recipe: recipe,
      remainingPatienceSeconds: patience,
      maxPatienceSeconds: patience,
      isVIP: isVIP,
    );

    activeOrders.add(order);
    selectedOrder ??= order;
    notifyListeners();
  }

  void _updateGameTick(Timer timer) {
    if (isPaused || isGameOver) return;

    for (int i = activeOrders.length - 1; i >= 0; i--) {
      final order = activeOrders[i];
      order.remainingPatienceSeconds -= 0.1;

      if (order.remainingPatienceSeconds <= 0) {
        // Comanda expirada por impaciencia
        activeOrders.removeAt(i);
        if (selectedOrder?.id == order.id) {
          selectedOrder = activeOrders.isNotEmpty ? activeOrders.first : null;
        }
        reputation -= GameConfig.penaltyOrderExpired;
        comboCount = 0;
        HapticService.errorVibration();

        if (reputation <= 0) {
          _triggerGameOver();
        }
      }
    }
    notifyListeners();
  }

  void selectOrder(KitchenOrder order) {
    selectedOrder = order;
    notifyListeners();
  }

  void completeCurrentStepSuccess() {
    if (selectedOrder == null) return;

    final order = selectedOrder!;
    order.currentStepIndex++;

    HapticService.lightImpact();

    if (order.isCompleted) {
      // Entrega de platillo exitosa
      int earnedPoints = GameConfig.pointsPerfect;
      if (order.isVIP) earnedPoints += GameConfig.vipBonusPoints;

      comboCount++;
      double multiplier = 1.0 + (comboCount * GameConfig.comboMultiplierStep);
      score += (earnedPoints * multiplier).round();

      activeOrders.removeWhere((o) => o.id == order.id);
      selectedOrder = activeOrders.isNotEmpty ? activeOrders.first : null;

      HapticService.heavyImpact();
    }
    notifyListeners();
  }

  void failActionPenalization() {
    comboCount = 0;
    reputation -= GameConfig.penaltyBurnedFood;
    HapticService.errorVibration();

    if (reputation <= 0) {
      _triggerGameOver();
    }
    notifyListeners();
  }

  void togglePause() {
    isPaused = !isPaused;
    notifyListeners();
  }

  void _triggerGameOver() {
    isGameOver = true;
    _gameLoopTimer?.cancel();
    _orderSpawnerTimer?.cancel();
    ScoreStorageService.saveHighScore(score);
    notifyListeners();
  }

  @override
  void dispose() {
    _gameLoopTimer?.cancel();
    _orderSpawnerTimer?.cancel();
    super.dispose();
  }
}
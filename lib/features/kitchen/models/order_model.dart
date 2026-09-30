import 'recipe_model.dart';

class KitchenOrder {
  final String id;
  final KitchenRecipe recipe;
  double remainingPatienceSeconds;
  final double maxPatienceSeconds;
  final bool isVIP;
  int currentStepIndex;

  KitchenOrder({
    required this.id,
    required this.recipe,
    required this.remainingPatienceSeconds,
    required this.maxPatienceSeconds,
    this.isVIP = false,
    this.currentStepIndex = 0,
  });

  double get patienceProgress => (remainingPatienceSeconds / maxPatienceSeconds).clamp(0.0, 1.0);
  bool get isCompleted => currentStepIndex >= recipe.steps.length;
}
enum StationType { cutting, frying, oven, plating }

class RecipeStep {
  final StationType station;
  final String instruction;
  final String requiredIngredientId;
  final double targetTimeSeconds; // Para sartén / horno

  RecipeStep({
    required this.station,
    required this.instruction,
    required this.requiredIngredientId,
    this.targetTimeSeconds = 3.0,
  });
}
import 'recipe_step_model.dart';

class KitchenRecipe {
  final String id;
  final String name;
  final String emoji;
  final List<RecipeStep> steps;

  KitchenRecipe({
    required this.id,
    required this.name,
    required this.emoji,
    required this.steps,
  });
}

// Catálogo de 6 recetas completas
final List<KitchenRecipe> masterRecipes = [
  KitchenRecipe(
    id: 'burger',
    name: 'Hamburguesa Pro',
    emoji: '🍔',
    steps: [
      RecipeStep(station: StationType.cutting, instruction: 'Corta el tomate y lechuga', requiredIngredientId: 'veg'),
      RecipeStep(station: StationType.frying, instruction: 'Cocina la carne al punto', requiredIngredientId: 'patty', targetTimeSeconds: 4.0),
      RecipeStep(station: StationType.plating, instruction: 'Arma la hamburguesa', requiredIngredientId: 'bun'),
    ],
  ),
  KitchenRecipe(
    id: 'pizza',
    name: 'Pizza Tulipán',
    emoji: '🍕',
    steps: [
      RecipeStep(station: StationType.cutting, instruction: 'Corta los champiñones', requiredIngredientId: 'mushrooms'),
      RecipeStep(station: StationType.oven, instruction: 'Hornea la pizza', requiredIngredientId: 'dough', targetTimeSeconds: 5.0),
      RecipeStep(station: StationType.plating, instruction: 'Emplata la pizza', requiredIngredientId: 'cheese'),
    ],
  ),
  KitchenRecipe(
    id: 'pasta',
    name: 'Pasta Mágica',
    emoji: '🍝',
    steps: [
      RecipeStep(station: StationType.frying, instruction: 'Sofríe la salsa de tomate', requiredIngredientId: 'sauce', targetTimeSeconds: 3.0),
      RecipeStep(station: StationType.plating, instruction: 'Sirve la pasta con queso', requiredIngredientId: 'pasta_noodle'),
    ],
  ),
  KitchenRecipe(
    id: 'brownies',
    name: 'Brownies Dulces',
    emoji: '🍫',
    steps: [
      RecipeStep(station: StationType.cutting, instruction: 'Corta las nueces', requiredIngredientId: 'nuts'),
      RecipeStep(station: StationType.oven, instruction: 'Hornea el brownie esponjoso', requiredIngredientId: 'batter', targetTimeSeconds: 4.0),
      RecipeStep(station: StationType.plating, instruction: 'Agrega chispa de chocolate', requiredIngredientId: 'chips'),
    ],
  ),
  KitchenRecipe(
    id: 'salad',
    name: 'Ensalada Fresca',
    emoji: '🥗',
    steps: [
      RecipeStep(station: StationType.cutting, instruction: 'Picado fino de verduras', requiredIngredientId: 'greens'),
      RecipeStep(station: StationType.plating, instruction: 'Mezcla y emplata', requiredIngredientId: 'dressing'),
    ],
  ),
  KitchenRecipe(
    id: 'steak',
    name: 'Filete Gourmet',
    emoji: '🥩',
    steps: [
      RecipeStep(station: StationType.frying, instruction: 'Sella el filete en su punto', requiredIngredientId: 'meat', targetTimeSeconds: 5.0),
      RecipeStep(station: StationType.cutting, instruction: 'Corta las papas rústicas', requiredIngredientId: 'potatoes'),
      RecipeStep(station: StationType.plating, instruction: 'Sirve con guarnición', requiredIngredientId: 'herbs'),
    ],
  ),
];
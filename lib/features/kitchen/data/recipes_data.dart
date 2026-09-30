import 'package:flutter/material.dart';

// --- DEFINICIÓN DE ENUMS Y MODELOS ---

enum IngredientType {
  flour,
  sugar,
  butter,
  cocoa,
  eggs,
  chocolateChips,
}

class Ingredient {
  final IngredientType id;
  final String name;
  final String iconEmoji;

  const Ingredient({
    required this.id,
    required this.name,
    required this.iconEmoji,
  });
}

class Recipe {
  final String id;
  final String name;
  final String description;
  final String iconEmoji;
  final Color themeColor;
  final List<IngredientType> requiredIngredients;

  const Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.iconEmoji,
    required this.themeColor,
    required this.requiredIngredients,
  });
}

// --- DATOS DEL JUEGO ---

final List<Ingredient> availableIngredients = [
  const Ingredient(id: IngredientType.flour, name: 'Harina', iconEmoji: '🌾'),
  const Ingredient(id: IngredientType.sugar, name: 'Azúcar', iconEmoji: '🍬'),
  const Ingredient(id: IngredientType.butter, name: 'Mantequilla', iconEmoji: '🧈'),
  const Ingredient(id: IngredientType.cocoa, name: 'Cacao', iconEmoji: '🍫'),
  const Ingredient(id: IngredientType.eggs, name: 'Huevos', iconEmoji: '🥚'),
  const Ingredient(id: IngredientType.chocolateChips, name: 'Chispas', iconEmoji: '🍪'),
];

final List<Recipe> kitchenRecipes = [
  const Recipe(
    id: 'brownies',
    name: 'Brownies Mágicos',
    description: 'Deliciosos, melosos y cargados de mucho chocolate.',
    iconEmoji: '🟫',
    themeColor: Color(0xFF5C3D2E),
    requiredIngredients: [
      IngredientType.flour,
      IngredientType.sugar,
      IngredientType.butter,
      IngredientType.cocoa,
      IngredientType.eggs,
    ],
  ),
];
enum CookingState { raw, perfect, overcooked, burned }

class IngredientItem {
  final String id;
  final String name;
  final String emoji;
  CookingState state;

  IngredientItem({
    required this.id,
    required this.name,
    required this.emoji,
    this.state = CookingState.raw,
  });

  IngredientItem copyWith({CookingState? state}) {
    return IngredientItem(
      id: id,
      name: name,
      emoji: emoji,
      state: state ?? this.state,
    );
  }
}
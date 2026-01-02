import 'package:flutter/material.dart';
import 'package:shop_lap_top/model/food.dart';

class FavoriteService extends ChangeNotifier {
  final List<Food> _favorites = [];

  List<Food> get favorites => _favorites;

  bool isFavorite(Food food) {
    return _favorites.any((f) => f.name == food.name);
  }

  void toggleFavorite(Food food) {
    if (isFavorite(food)) {
      _favorites.removeWhere((f) => f.name == food.name);
    } else {
      _favorites.add(food);
    }
    notifyListeners();
  }
}

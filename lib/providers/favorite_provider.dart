
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider with ChangeNotifier {
  List<String> _favoriteIds = [];
  static const _favoritesKey = 'favorite_herbs';

  List<String> get favoriteIds => _favoriteIds;

  FavoriteProvider() {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    _favoriteIds = prefs.getStringList(_favoritesKey) ?? [];
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favoritesKey, _favoriteIds);
  }

  void toggleFavorite(String herbId) {
    if (isFavorite(herbId)) {
      _favoriteIds.remove(herbId);
    } else {
      _favoriteIds.add(herbId);
    }
    _saveFavorites();
    notifyListeners();
  }

  bool isFavorite(String herbId) {
    return _favoriteIds.contains(herbId);
  }
}

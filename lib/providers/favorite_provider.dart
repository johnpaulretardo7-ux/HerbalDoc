import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myapp/models/herb.dart';

class FavoriteProvider with ChangeNotifier {
  final List<Herb> allHerbs;
  List<Herb> _favorites = [];
  static const _favoritesKey = 'favorite_herbs';

  List<Herb> get favorites => _favorites;

  FavoriteProvider({required this.allHerbs}) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList(_favoritesKey) ?? [];
    _favorites = allHerbs.where((herb) => favoriteIds.contains(herb.id)).toList();
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = _favorites.map((herb) => herb.id).toList();
    await prefs.setStringList(_favoritesKey, favoriteIds);
  }

  void toggleFavorite(Herb herb) {
    if (isFavorite(herb)) {
      _favorites.removeWhere((h) => h.id == herb.id);
    } else {
      _favorites.add(herb);
    }
    _saveFavorites();
    notifyListeners();
  }

  bool isFavorite(Herb herb) {
    return _favorites.any((h) => h.id == herb.id);
  }
}

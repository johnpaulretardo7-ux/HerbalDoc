import 'package:flutter/material.dart';
import 'package:myapp/models/herb.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Herb> _favorites = [];

  List<Herb> get favorites => _favorites;

  void toggleFavorite(Herb herb) {
    if (_favorites.contains(herb)) {
      _favorites.remove(herb);
    } else {
      _favorites.add(herb);
    }
    notifyListeners();
  }

  bool isFavorite(Herb herb) {
    return _favorites.contains(herb);
  }
}

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:myapp/models/herb.dart';

class HerbsProvider with ChangeNotifier {
  List<Herb> _herbs = [];
  bool _isLoading = true;
  String? _error;

  List<Herb> get herbs => _herbs;
  bool get isLoading => _isLoading;
  String? get error => _error;

  HerbsProvider() {
    loadHerbs();
  }

  Future<void> loadHerbs() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final String response = await rootBundle.loadString('assets/data/herbs.json');
      final data = json.decode(response);
      if (data['herbs'] != null) {
        _herbs = (data['herbs'] as List)
            .map((item) => Herb.fromJson(item))
            .toList();
      } else {
        throw Exception('"herbs" key not found in JSON file');
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Failed to load herbs: $e');
        print(stackTrace);
      }
      _error = 'Failed to load herb data. Please check the data file and restart the app.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

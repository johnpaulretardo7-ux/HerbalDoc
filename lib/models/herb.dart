import 'dart:convert';

class Herb {
  final String id;
  final String name;
  final String scientificName;
  final String partUsed;
  final String facts;
  final String preparation;
  final List<String> uses;
  final String imageUrl;

  Herb({
    required this.id,
    required this.name,
    required this.scientificName,
    required this.partUsed,
    required this.facts,
    required this.preparation,
    required this.uses,
    required this.imageUrl,
  });

  factory Herb.fromJson(Map<String, dynamic> json) {
    return Herb(
      id: json['id'] as String,
      name: json['name'] as String,
      scientificName: json['scientific_name'] as String,
      partUsed: json['part_used'] as String,
      facts: json['facts'] as String,
      preparation: json['preparation'] as String,
      uses: List<String>.from(json['uses'] as List),
      imageUrl: json['imageUrl'] as String,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Herb && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

List<Herb> loadHerbs(String jsonString) {
  final data = json.decode(jsonString);
  final List<dynamic> herbList = data['herbs'];
  return herbList.map((json) => Herb.fromJson(json)).toList();
}

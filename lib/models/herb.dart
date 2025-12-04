import 'dart:convert';

class Herb {
  final String id;
  final String name;
  final String scientificName;
  final String description; // Renamed from 'facts' to be more descriptive
  final List<String> healthBenefits; // Renamed from 'preparation'
  final List<String> usage; // Renamed from 'uses'
  final String imageUrl;

  Herb({
    required this.id,
    required this.name,
    required this.scientificName,
    required this.description,
    required this.healthBenefits,
    required this.usage,
    required this.imageUrl,
  });

  factory Herb.fromJson(Map<String, dynamic> json) {
    return Herb(
      id: json['id'] as String, // Assuming id is a string in the JSON
      name: json['name'] as String,
      scientificName: json['scientific_name'] as String,
      description: json['description'] as String,
      healthBenefits: List<String>.from(json['health_benefits'] as List),
      usage: List<String>.from(json['usage'] as List),
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

class Herb {
  final String name;
  final String scientificName;
  final String facts;
  final String preparation;
  final List<String> uses;
  final String imageUrl;

  Herb({
    required this.name,
    required this.scientificName,
    required this.facts,
    required this.preparation,
    required this.uses,
    required this.imageUrl,
  });

  factory Herb.fromJson(Map<String, dynamic> json) {
    return Herb(
      name: json['name'] as String,
      scientificName: json['scientific_name'] as String,
      facts: json['facts'] as String,
      preparation: json['preparation'] as String,
      uses: List<String>.from(json['uses'] as List),
      imageUrl: json['imageUrl'] as String,
    );
  }
}

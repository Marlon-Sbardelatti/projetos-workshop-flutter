class Character {
  final int id;
  final String name;
  final String? image;
  final String gender;
  final String species;
  final String originPlanet;

  Character({
    required this.id,
    required this.name,
    this.image,
    required this.gender,
    required this.species,
    required this.originPlanet,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
        id: json['id'],
        name: json['name'],
        image: json['image'] ?? '',
        gender: json['gender'],
        species: json['species'],
        originPlanet: json['origin']['name'] ?? 'Unknown');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'gender': gender,
      'species': species
    };
  }
}

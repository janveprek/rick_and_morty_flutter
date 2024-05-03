class CharacterDetail {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String origin;
  final String location;
  final String iconUrl;
  final bool isFavourite;

  CharacterDetail({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.iconUrl,
    this.isFavourite = false,
  });

  CharacterDetail copyWith({
    int? id,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
    String? origin,
    String? location,
    String? iconUrl,
    bool? isFavourite,
  }) {
    return CharacterDetail(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      species: species ?? this.species,
      type: type ?? this.type,
      gender: gender ?? this.gender,
      origin: origin ?? this.origin,
      location: location ?? this.location,
      iconUrl: iconUrl ?? this.iconUrl,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CharacterDetail &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              status == other.status &&
              species == other.species &&
              type == other.type &&
              gender == other.gender &&
              origin == other.origin &&
              location == other.location &&
              iconUrl == other.iconUrl;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ status.hashCode ^ species.hashCode ^ type.hashCode ^ gender.hashCode ^ origin.hashCode ^ location.hashCode ^ iconUrl.hashCode;
}
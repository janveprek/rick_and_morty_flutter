class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String iconUrl;
  final bool isFavourite;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.iconUrl,
    this.isFavourite = false,
  });


  CharacterModel copyWith({
    int? id,
    String? name,
    String? status,
    String? iconUrl,
    bool? isFavourite,
  }) {
    return CharacterModel(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      iconUrl: iconUrl ?? this.iconUrl,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'imageUrl': iconUrl,
      'isFavourite': isFavourite ? 1 : 0,
    };
  }

  factory CharacterModel.fromMap(Map<String, dynamic> map) {
    return CharacterModel(
      id: map['id'],
      name: map['name'],
      status: map['status'],
      iconUrl: map['imageUrl'],
      isFavourite: map['isFavourite'] == 1,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CharacterModel &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              status == other.status &&
              iconUrl == other.iconUrl &&
              isFavourite == other.isFavourite;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ status.hashCode ^ iconUrl.hashCode ^ isFavourite.hashCode;
}
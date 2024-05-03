import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:rick_and_morty_flutter/character/data/entity/character_detail_dto.dart';
import 'package:rick_and_morty_flutter/character/data/entity/character_dto.dart';
import 'package:rick_and_morty_flutter/character/model/character_detail.dart';
import 'package:rick_and_morty_flutter/character/model/character_model.dart';

@GenerateMocks([CharacterDto])
void main() {
  group('CharacterMapper tests', () {
    test('CharacterModel toMap converts correctly', () {
      final character = CharacterModel(
        id: 1,
        name: 'Rick',
        status: 'Alive',
        iconUrl: 'image.jpg',
        isFavourite: true,
      );

      final map = character.toMap();

      expect(map['id'], equals(1));
      expect(map['name'], equals('Rick'));
      expect(map['status'], equals('Alive'));
      expect(map['imageUrl'], equals('image.jpg'));
      expect(map['isFavourite'], equals(1));
    });

    test('CharacterModel fromMap converts correctly', () {
      final map = {
        'id': 1,
        'name': 'Rick',
        'status': 'Alive',
        'imageUrl': 'image.jpg',
        'isFavourite': 1,
      };

      final character = CharacterModel.fromMap(map);

      expect(character.id, equals(1));
      expect(character.name, equals('Rick'));
      expect(character.status, equals('Alive'));
      expect(character.iconUrl, equals('image.jpg'));
      expect(character.isFavourite, equals(true));
    });

    test('should map CharacterDto to model correctly', () {
      const id = 2;
      const name = "name";
      const status = "status";
      const iconUrl = "url";

      final characterDto = CharacterDto(id: id, name: name, status: status, image: iconUrl);

      final expected = CharacterModel(
        id: id,
        name: name,
        status: status,
        iconUrl: iconUrl,
      );

      final result = characterDto.toModel();
      expect(result, expected);
    });

    test('should map character detail to model correctly', () {
      final characterDto = CharacterDetailDto(
        id: 1,
        name: "Rick",
        status: "alive",
        species: "species",
        type: "type",
        gender: "gender",
        origin: OriginDto(name: "origin_name"),
        location: LocationDto(name: "location_name"),
        image: "image",
      );

      final expected = CharacterDetail(
        id: 1,
        name: "Rick",
        status: "alive",
        species: "species",
        type: "type",
        gender: "gender",
        origin: "origin_name",
        location: "location_name",
        iconUrl: "image",
      );

      final result = characterDto.toModel();
      expect(result, expected);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty_flutter/character/data/character_api.dart';
import 'package:rick_and_morty_flutter/character/data/character_db.dart';
import 'package:rick_and_morty_flutter/character/data/character_repository_impl.dart';
import 'package:rick_and_morty_flutter/character/data/entity/character_detail_dto.dart';
import 'package:rick_and_morty_flutter/character/data/entity/character_dto.dart';
import 'package:rick_and_morty_flutter/character/data/entity/paged_result_dto.dart';
import 'package:rick_and_morty_flutter/character/model/character_detail.dart';
import 'package:rick_and_morty_flutter/character/model/character_model.dart';
import 'package:rick_and_morty_flutter/character/model/result_wrapper.dart';

import 'character_repository_test.mocks.dart';

@GenerateMocks([CharacterApi, CharacterDatabase])
void main() {
  group('CharacterRepository tests', () {
    MockCharacterApi api = MockCharacterApi();
    MockCharacterDatabase db = MockCharacterDatabase();
    CharacterRepositoryImpl repository = CharacterRepositoryImpl(api, db);

    test('getAllCharacters returns characters', () async {
      when(api.getAllCharacters()).thenAnswer((_) async =>
          PagedResultDto(result: [
            CharacterDto(id: 1, name: "Rick", status: "alive", image: "icon")
          ]));
      when(db.getFavouriteCharacters()).thenAnswer((_) async => []);

      final result = await repository.getAllCharacters();

      expect(result is Success<List<CharacterModel>>, true);
      result as Success<List<CharacterModel>>;
      expect(result.value, hasLength(1));
      expect(
        result.value.first,
        CharacterModel(
            id: 1,
            name: "Rick",
            status: "alive",
            iconUrl: "icon",
            isFavourite: false)
      );
    });

    test('getAllCharacters returns favorite characters', () async {
      when(api.getAllCharacters()).thenAnswer((_) async => PagedResultDto(
        result: [
          CharacterDto(id: 1, name: "Rick", status: "alive", image: "icon"),
          CharacterDto(id: 2, name: "Morty", status: "alive", image: "icon"),
        ],
      ));
      when(db.getFavouriteCharacters()).thenAnswer((_) async => [CharacterModel(id: 1, name: "Rick", status: "alive", iconUrl: 'icon')]);
      final result = await repository.getAllCharacters();

      expect(result is Success<List<CharacterModel>>, true);
      result as Success<List<CharacterModel>>;
      expect(result.value.length, 2);
      expect(
        result.value,
        [
          CharacterModel(id: 1, name: "Rick", status: "alive", iconUrl: "icon", isFavourite: true),
          CharacterModel(id: 2, name: "Morty", status: "alive", iconUrl: "icon", isFavourite: false),
        ],
      );
    });

    test('getCharactersByName returns characters by name', () async {
      when(api.getCharactersByName(any)).thenAnswer((_) async => PagedResultDto(
        result: [
          CharacterDto(id: 1, name: "Rick", status: "alive", image: ""),
          CharacterDto(id: 2, name: "Morty", status: "alive", image: ""),
        ],
      ));
      when(db.getFavouriteCharacters()).thenAnswer((_) async => [CharacterModel(id: 1, name: "Rick", status: "alive", iconUrl: '')]);
      final result = await repository.getCharactersByName("name");

      expect(result is Success<List<CharacterModel>>, true);
      result as Success<List<CharacterModel>>;
      expect(result.value.length, 2);
      expect(
        result.value,
        [
          CharacterModel(id: 1, name: "Rick", status: "alive", iconUrl: "", isFavourite: true),
          CharacterModel(id: 2, name: "Morty", status: "alive", iconUrl: "", isFavourite: false),
        ],
      );
    });

    test('getCharacterById returns character', () async {
      final detail = CharacterDetailDto(
        id: 1,
        name: "Rick",
        status: "alive",
        species: "species",
        type: "type",
        gender: "gender",
        origin: OriginDto(name: "name"),
        location: LocationDto(name: "name"),
        image: "image",
      );

      when(api.getCharacterById(any)).thenAnswer((_) async => detail);
      when(db.getFavouriteCharacters()).thenAnswer((_) async => []);
      final result = await repository.getCharacterById(1);
      expect(result is Success<CharacterDetail>, true);
      result as Success<CharacterDetail>;
      expect(result.value, detail.toModel());
    });

    test('getCharacterById returns favourite character', () async {
      final detail = CharacterDetailDto(
        id: 1,
        name: "Rick",
        status: "alive",
        species: "species",
        type: "type",
        gender: "gender",
        origin: OriginDto(name: "name"),
        location: LocationDto(name: "name"),
        image: "image",
      );

      when(api.getCharacterById(any)).thenAnswer((_) async => detail);
      when(db.getFavouriteCharacters()).thenAnswer((_) async => [CharacterModel(id: 1, name: 'Rick', status: 'status', iconUrl: 'url')]);
      final result = await repository.getCharacterById(1);

      expect(result is Success<CharacterDetail>, true);
      result as Success<CharacterDetail>;
      expect(result.value, detail.toModel().copyWith(isFavourite: true));
    });

    test('addCharacterToFavourites calls the right method', () async {
      final character = CharacterModel(id: 1, name: 'Rick', status: 'alive', iconUrl: '');
      repository.addCharacterToFavorites(character);
      verify(db.addCharacterToFavourites(character)).called(1);
    });

    test('removeCharacterFromFavourites calls the right method', () async {
      final character = CharacterModel(id: 1, name: "Rick", status: "alive", iconUrl: "");
      repository.removeCharacterFromFavourites(character);
      verify(db.removeCharacterFromFavourites(character)).called(1);
    });

    test('getAllCharacters returns error when exception arises', () async {
      when(api.getAllCharacters()).thenThrow(Exception());
      when(db.getFavouriteCharacters()).thenAnswer((_) async =>
      [
        CharacterModel(id: 1, name: "Rick", status: "alive", iconUrl: "")
      ]);
      final result = await repository.getAllCharacters();

      expect(result is Error, true);
    });
    
    test('getCharactersByName returns error when exception arises', () async {
      when(api.getCharactersByName(any)).thenThrow(Exception());
      when(db.getFavouriteCharacters()).thenAnswer((_) async =>
      [
        CharacterModel(id: 1, name: "Rick", status: "alive", iconUrl: "")
      ]);
      final result = await repository.getCharactersByName("name");

      expect(result is Error, true);
    });

    test('getCharacterById returns error when exception arises', () async {
      when(api.getCharacterById(any)).thenThrow(Exception());
      final result = await repository.getCharacterById(1);

      expect(result is Error, true);
    });
  });
}

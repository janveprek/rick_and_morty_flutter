import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty_flutter/character/domain/character_repository.dart';
import 'package:rick_and_morty_flutter/character/domain/get_favorite_characters_use_case.dart';
import 'package:rick_and_morty_flutter/character/domain/remove_character_from_favorites_use_case.dart';
import 'package:rick_and_morty_flutter/character/model/character_model.dart';

import 'get_character_by_id_test.mocks.dart';

@GenerateMocks([CharacterRepository])
void main() {
  group('RemoveCharacterFromFavouritesUseCaseImplTest', () {
    test('should call repository removeCharacterFromFavourites once', () async {
      MockCharacterRepository repository = MockCharacterRepository();
      when(repository.removeCharacterFromFavourites(any)).thenAnswer((_) async {});

      final useCase = RemoveCharacterFromFavoritesUseCaseImpl(repository);

      await useCase(CharacterModel(id: 1, name: "name", status: "status", iconUrl: "url"));

      verify(repository.removeCharacterFromFavourites(any)).called(1);
    });
  });
}
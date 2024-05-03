import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty_flutter/character/domain/character_repository.dart';
import 'package:rick_and_morty_flutter/character/domain/get_favorite_characters_use_case.dart';

import 'get_character_by_id_test.mocks.dart';

@GenerateMocks([CharacterRepository])
void main() {
  group('GetFavouriteCharactersUseCaseImplTest', () {
    test('should call repository getFavouriteCharacters once', () async {
      MockCharacterRepository repository = MockCharacterRepository();
      when(repository.getFavouriteCharacters()).thenAnswer((_) async => List.empty());

      final useCase = GetFavoriteCharactersUseCaseImpl(repository);

      await useCase();

      verify(repository.getFavouriteCharacters()).called(1);
    });
  });
}
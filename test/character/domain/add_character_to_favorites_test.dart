import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty_flutter/character/domain/add_character_to_favorites.dart';
import 'package:rick_and_morty_flutter/character/domain/character_repository.dart';
import 'package:rick_and_morty_flutter/character/model/character_model.dart';
import 'add_character_to_favorites_test.mocks.dart';

@GenerateMocks([CharacterRepository])
void main() {
  group('AddCharacterToFavouritesUseCaseImplTest', () {
    test('should call repository addCharacterToFavourites', () async {
      MockCharacterRepository repository = MockCharacterRepository();
      when(repository.addCharacterToFavorites(any)).thenAnswer((_) async {});

      final useCase = AddCharacterToFavoritesUseCaseImpl(repository);

      await useCase(CharacterModel(id: 1, name: "name", status: "status", iconUrl: "url"));

      verify(repository.addCharacterToFavorites(any)).called(1);
    });
  });
}

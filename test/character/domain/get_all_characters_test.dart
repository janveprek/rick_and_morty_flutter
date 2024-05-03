import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty_flutter/character/domain/character_repository.dart';
import 'package:rick_and_morty_flutter/character/domain/get_all_characters_use_case.dart';
import 'package:rick_and_morty_flutter/character/model/result_wrapper.dart';

import 'add_character_to_favorites_test.mocks.dart';

@GenerateMocks([CharacterRepository])
void main() {
  group('GetAllCharactersUseCaseImplTest', () {
    test('should call repository getAllCharacters once', () async {
      MockCharacterRepository repository = MockCharacterRepository();
      when(repository.getAllCharacters(page: 0)).thenAnswer((_) async => Success(List.empty()));

      final useCase = GetAllCharactersUseCaseImpl(repository);

      await useCase();

      verify(repository.getAllCharacters(page: 0)).called(1);
    });
  });
}
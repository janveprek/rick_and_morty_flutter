import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty_flutter/character/domain/character_repository.dart';
import 'package:rick_and_morty_flutter/character/domain/get_characters_by_name_use_case.dart';
import 'package:rick_and_morty_flutter/character/model/result_wrapper.dart';

import 'get_character_by_id_test.mocks.dart';

@GenerateMocks([CharacterRepository])
void main() {
  group('GetCharactersByNameUseCaseImplTest', () {
    test('should call repository getCharactersByName once', () async {
      MockCharacterRepository repository = MockCharacterRepository();
      when(repository.getCharactersByName(any)).thenAnswer((_) async => Success(List.empty()));

      final useCase = GetCharactersByNameUseCaseImpl(repository);

      await useCase("name");

      verify(repository.getCharactersByName(any)).called(1);
    });
  });
}
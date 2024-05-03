import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty_flutter/character/domain/character_repository.dart';
import 'package:rick_and_morty_flutter/character/domain/get_character_by_id_use_case.dart';
import 'package:rick_and_morty_flutter/character/model/character_detail.dart';
import 'package:rick_and_morty_flutter/character/model/result_wrapper.dart';

import 'get_character_by_id_test.mocks.dart';

@GenerateMocks([CharacterRepository, CharacterDetail])
void main() {
  group('GetCharacterByIdUseCaseImplTest', () {
    test('should call repository getCharacterById once', () async {
      MockCharacterRepository repository = MockCharacterRepository();
      MockCharacterDetail detail = MockCharacterDetail();
      when(repository.getCharacterById(any)).thenAnswer((_) async => Success(detail));

      final useCase = GetCharacterByIdUseCaseImpl(repository);

      await useCase(1);

      verify(repository.getCharacterById(any)).called(1);
    });
  });
}
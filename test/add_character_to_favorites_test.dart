import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty_flutter/character/data/character_repository_impl.dart';
import 'package:rick_and_morty_flutter/character/domain/add_character_to_favorites.dart';
import 'package:rick_and_morty_flutter/character/domain/character_repository.dart';
import 'package:rick_and_morty_flutter/character/model/character_model.dart';

class MockCharacterRepository extends Mock implements CharacterRepositoryImpl {}

void main() {
  // group('AddCharacterToFavoritesUseCaseImpl', () {
  //   late CharacterRepository repository;
  //   late AddCharacterToFavoritesUseCaseImpl useCase;
  //
  //   setUp(() {
  //     repository = MockCharacterRepository();
  //     useCase = AddCharacterToFavoritesUseCaseImpl(repository);
  //   });
  //
  //   test('should call repository addCharacterToFavorites', () async {
  //     final character = CharacterModel(
  //       id: 1,
  //       name: 'name',
  //       status: 'status',
  //       iconUrl: 'url',
  //     );
  //
  //     when(repository.addCharacterToFavorites(character))
  //         .thenAnswer((_) async {});
  //
  //     await useCase.call(character);
  //
  //     verify(repository.addCharacterToFavorites(character)).called(1);
  //   });
  // });
}

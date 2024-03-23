import 'package:rick_and_morty_flutter/character/domain/character_repository.dart';
import 'package:rick_and_morty_flutter/character/model/character_model.dart';

abstract class RemoveCharacterFromFavoritesUseCase {
  Future<void> call(CharacterModel character);
}
class RemoveCharacterFromFavoritesUseCaseImpl implements RemoveCharacterFromFavoritesUseCase {
  final CharacterRepository repository;

  RemoveCharacterFromFavoritesUseCaseImpl(this.repository);

  @override
  Future<void> call(CharacterModel character) async {
    await repository.removeCharacterFromFavourites(character);
  }
}

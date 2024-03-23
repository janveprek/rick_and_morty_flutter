import 'package:rick_and_morty_flutter/character/domain/character_repository.dart';
import 'package:rick_and_morty_flutter/character/model/character_model.dart';

abstract class AddCharacterToFavoritesUseCase {
  Future<void> call(CharacterModel character);
}

class AddCharacterToFavoritesUseCaseImpl implements AddCharacterToFavoritesUseCase {
  final CharacterRepository repository;

  AddCharacterToFavoritesUseCaseImpl(this.repository);

  @override
  Future<void> call(CharacterModel character) async {
    await repository.addCharacterToFavorites(character);
  }
}
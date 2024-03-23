import 'package:rick_and_morty_flutter/character/model/character_model.dart';

import 'character_repository.dart';

abstract class GetFavoriteCharactersUseCase {
  Future<List<CharacterModel>> call();
}

class GetFavoriteCharactersUseCaseImpl implements GetFavoriteCharactersUseCase {
  final CharacterRepository repository;

  GetFavoriteCharactersUseCaseImpl(this.repository);

  @override
  Future<List<CharacterModel>> call() async {
    return repository.getFavouriteCharacters();
  }
}
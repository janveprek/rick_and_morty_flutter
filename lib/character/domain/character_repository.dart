import 'package:rick_and_morty_flutter/character/model/character_detail.dart';
import 'package:rick_and_morty_flutter/character/model/character_model.dart';
import 'package:rick_and_morty_flutter/character/model/filter.dart';
import 'package:rick_and_morty_flutter/character/model/result_wrapper.dart';

abstract class CharacterRepository {
  Future<ResultWrapper<List<CharacterModel>>> getAllCharacters({int page = 1});

  Future<ResultWrapper<List<CharacterModel>>> getCharactersByName(String name, {StatusFilter filter = StatusFilter.all});

  Future<List<CharacterModel>> getFavouriteCharacters();

  Future<void> addCharacterToFavorites(CharacterModel character);

  Future<void> removeCharacterFromFavourites(CharacterModel character);

  Future<ResultWrapper<CharacterDetail>> getCharacterById(int id);
}
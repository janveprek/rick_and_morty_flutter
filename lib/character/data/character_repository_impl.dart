import 'dart:async';

import 'package:rick_and_morty_flutter/character/data/character_api.dart';
import 'package:rick_and_morty_flutter/character/data/character_db.dart';
import 'package:rick_and_morty_flutter/character/domain/character_repository.dart';
import 'package:rick_and_morty_flutter/character/model/character_detail.dart';
import 'package:rick_and_morty_flutter/character/model/character_model.dart';
import 'package:rick_and_morty_flutter/character/model/filter.dart';
import 'package:rick_and_morty_flutter/character/model/result_wrapper.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterApi charactersApi;
  final CharacterDatabase charactersDatabase;

  CharacterRepositoryImpl(this.charactersApi, this.charactersDatabase);

  @override
  Future<ResultWrapper<List<CharacterModel>>> getAllCharacters(
      {int page = 1}) async {
    try {
      var characters = await charactersApi
          .getAllCharacters(page: page)
          .then((result) => result.toModel().data);
      var favourites = await getFavouriteCharacters();
      characters = characters
          .map((char) => favourites.any((fav) => fav.id == char.id)
              ? char.copyWith(isFavourite: true)
              : char)
          .toList();
      return Success(characters);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  @override
  Future<ResultWrapper<List<CharacterModel>>> getCharactersByName(String name,
      {StatusFilter filter = StatusFilter.all}) async {
    try {
      var characters = await charactersApi
          .getCharactersByName(name, filter: filter)
          .then((result) => result.toModel().data);
      var favourites = await getFavouriteCharacters();
      characters = characters
          .map((char) => favourites.any((fav) => fav.id == char.id)
              ? char.copyWith(isFavourite: true)
              : char)
          .toList();
      return Success(characters);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  @override
  Future<List<CharacterModel>> getFavouriteCharacters() async {
    return charactersDatabase.getFavouriteCharacters();
  }

  @override
  Future<void> addCharacterToFavorites(CharacterModel character) async {
    charactersDatabase.addCharacterToFavourites(character);
  }

  @override
  Future<void> removeCharacterFromFavourites(CharacterModel character) async {
    charactersDatabase.removeCharacterFromFavourites(character);
  }

  @override
  Future<ResultWrapper<CharacterDetail>> getCharacterById(int id) async {
    try {
      var character = await charactersApi
          .getCharacterById(id)
          .then((apiCharacter) => apiCharacter.toModel());
      return Success(character);
    } on Exception catch (e) {
      return Error(e);
    }
  }
}

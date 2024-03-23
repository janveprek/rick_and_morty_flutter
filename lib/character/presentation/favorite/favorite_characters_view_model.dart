import 'package:flutter/material.dart';
import 'package:rick_and_morty_flutter/character/domain/add_character_to_favorites.dart';
import 'package:rick_and_morty_flutter/character/domain/get_favorite_characters_use_case.dart';
import 'package:rick_and_morty_flutter/character/domain/remove_character_from_favorites_use_case.dart';
import 'package:rick_and_morty_flutter/character/model/character_model.dart';
import 'package:rick_and_morty_flutter/character/presentation/favorite/state/favorite_characters_state.dart';
import 'package:rick_and_morty_flutter/design/model/screen_state.dart';

class FavoriteCharactersViewModel extends ChangeNotifier {
  final GetFavoriteCharactersUseCase getFavoriteCharacters;
  final AddCharacterToFavoritesUseCase addCharacterToFavorites;
  final RemoveCharacterFromFavoritesUseCase removeCharacterFromFavorites;

  FavoriteCharactersViewModel({
    required this.getFavoriteCharacters,
    required this.addCharacterToFavorites,
    required this.removeCharacterFromFavorites,
  }) {
    getCharacters();
  }

  FavoriteCharactersState _charactersState = FavoriteCharactersState();

  FavoriteCharactersState get charactersState => _charactersState;

  Future<void> getCharacters() async {
    var characters = await getFavoriteCharacters();
    updateState(characters);
  }

  Future<void> toggleFavourite(CharacterModel character) async {
    var index = _charactersState.characters.indexOf(character);
    if (index != -1) {
      var updatedCharacter = _charactersState.characters[index].copyWith(
          isFavourite: !_charactersState.characters[index].isFavourite);
      if (updatedCharacter.isFavourite) {
        await addCharacterToFavorites(character);
      } else {
        await removeCharacterFromFavorites(character);
      }
      var updatedCharacters =
          List<CharacterModel>.from(_charactersState.characters);
      updatedCharacters[index] = updatedCharacter;
      _charactersState =
          _charactersState.copyWith(characters: updatedCharacters);
      notifyListeners();
    }
  }

  Future<void> search(String query) async {
    _charactersState = _charactersState.copyWith(state: const LoadingState());
    notifyListeners();

    var characters = await getFavoriteCharacters();
    updateState(characters);
  }

  void updateState(List<CharacterModel> characters) {
    _charactersState = _charactersState.copyWith(
      state: characters.isNotEmpty ? const SuccessState() : EmptyState(),
      characters: characters,
    );
    notifyListeners();
  }
}
